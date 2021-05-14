import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;
import 'package:crosswalk/utils/image_utils.dart';

// Custom callback to move data conveniently
typedef void Callback(List<dynamic> list, int h, int w);

class CameraFeed extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback setRecognitions;

  // Contructor
  // 1. cameras is a list of all cameras, we choose the one we want later on
  // 2. setRecognitions passed to/from parent (LiveFeed) which uses
  //    this data to draw the boundary boxes for recognitions
  CameraFeed(this.cameras, this.setRecognitions);

  @override
  _CameraFeedState createState() => new _CameraFeedState();
}

class _CameraFeedState extends State<CameraFeed> {
  CameraController controller;
  bool isDetecting = false;
  // Stopwatch to ensure a photo is taking once every 10 seconds
  Stopwatch stopwatch = new Stopwatch();

  // I do not know what is happening. I am dead on the inside.
  List<int> png;
  // isCapturedImageReady decides what to show in build()
  bool isCapturedImageReady = false;

  // The name of this function is slightly misleading
  // It takes a CameraImage frame in format Yuv420
  // and converts it to a black-and-white PNG
  // This PNG as List<int>
  void captureImage(CameraImage frame) async {
    png = await convertImagetoPng(frame);
    // Debugging
    // print(png.toString());
    isCapturedImageReady = true;
  }

  @override
  void initState() {
    super.initState();

    // Checking if camera not found
    if (widget.cameras == null || widget.cameras.length < 1) {
      print('No Cameras Found.');
    } else {
      controller = new CameraController(
        widget.cameras[0], // Primary camera at index 0 i.e. Back Camera
        ResolutionPreset.high,
      );

      controller.initialize().then((_) {
        // If not mounted properly, quit
        // That's what I THINK this does.
        if (!mounted) {
          return;
        }
        setState(() {});

        // Imagestream provides individual frames
        // Frames are in Yuv420 format
        controller.startImageStream((CameraImage img) {
          if (isCapturedImageReady) {
            // TODO
            // Handle sending image to backend
            isCapturedImageReady = false;
          }
          // Not quite sure why we use isDetecting
          // But it is needed, just let it be.
          // Some higher logic my brain cannot comprehend.
          if (!isDetecting) {
            isDetecting = true;
            // detectObjectOnFrame returns a list of recognitions as string labels
            // these recognitions are used under the then() part
            Tflite.detectObjectOnFrame(
              bytesList: img.planes.map((plane) {
                return plane.bytes;
              }).toList(),
              model: "SSDMobileNet",
              imageHeight: img.height,
              imageWidth: img.width,
              imageMean: 127.5,
              imageStd: 127.5,
              numResultsPerClass: 1,
              threshold: 0.4,
            ).then((recognitions) {
              /*
              When setRecognitions is called here, the parameters are being passed on to the parent widget as callback. i.e. to the LiveFeed class
               */
              widget.setRecognitions(recognitions, img.height, img.width);

              // Looping through recognitions to check for "person"
              // Using a stopwatch to ensure app doesn't take 10 photos in a second.
              for (var recognition in recognitions) {
                if (recognition['detectedClass'] == 'person') {
                  print('PERSON');
                  if (stopwatch.elapsedMilliseconds == 0) {
                    // Taking the picture
                    print('TAKING PICTURE');
                    // The captureImage() takes the Yuv420 frame stored in "img" as type CameraImage (from camera library)
                    captureImage(img);
                    // Starting stopwatch to prevent any more "captures"
                    stopwatch.start();
                    continue;
                  } else {
                    // Frame is captured only once every 5000ms
                    if (stopwatch.elapsedMilliseconds > 5000) {
                      stopwatch.stop();
                      stopwatch.reset(); // sets stopwatch count back to 0
                      print('STOPWATCH RESET');
                    }
                  }
                } else {
                  print('NOT PERSON');
                }
              }
              // Still no clue why this is needed
              // But it is needed.
              isDetecting = false;
            });
          }
        });
      });
    }
  }

  // Destructor basically.
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Container();
    }
    // Necessary math to ensure the preview window has
    // correct cropping and aspect ratio or whatever.
    var tmp = MediaQuery.of(context).size;
    var screenH = math.max(tmp.height, tmp.width);
    var screenW = math.min(tmp.height, tmp.width);
    tmp = controller.value.previewSize;
    var previewH = math.max(tmp.height, tmp.width);
    var previewW = math.min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;

    return OverflowBox(
      maxHeight:
          screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
      maxWidth:
          screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
      child: CameraPreview(controller),

      // Comment out the previous line and uncomment the line after to view the images being captured
      // child: (isCapturedImageReady) ? Image.memory(png) : CameraPreview(controller),
    );
  }
}
