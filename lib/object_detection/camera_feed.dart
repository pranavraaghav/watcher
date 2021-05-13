import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;
import 'package:crosswalk/utils/image_utils.dart';
import 'package:image/image.dart' as imglib;

typedef void Callback(List<dynamic> list, int h, int w);

class CameraFeed extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback setRecognitions;
  // The cameraFeed Class takes the cameras list and the setRecognitions
  // function as argument
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
  // imageReady decides what to show in build()
  bool imageReady = false;
  void captureImage(CameraImage img) async {
    png = await convertImagetoPng(img);
    imageReady = true;
  }

  @override
  void initState() {
    super.initState();
    print(widget.cameras);
    if (widget.cameras == null || widget.cameras.length < 1) {
      print('No Cameras Found.');
    } else {
      controller = new CameraController(
        widget.cameras[0],
        ResolutionPreset.high,
      );
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});

        controller.startImageStream((CameraImage img) {
          if (!isDetecting) {
            isDetecting = true;
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
              // Loop through all recognitions and check for person recognitions
              for (var recognition in recognitions) {
                if (recognition['detectedClass'] == 'person') {
                  print('PERSON');
                  // Stopwatch implementation
                  if (stopwatch.elapsedMilliseconds == 0) {
                    // Taking the picture
                    print('TAKING PICTURE');
                    captureImage(img);
                    stopwatch.start();
                    continue;
                  } else {
                    if (stopwatch.elapsedMilliseconds > 5000) {
                      stopwatch.stop();
                      stopwatch.reset();
                      print('STOPWATCH RESET');
                    }
                  }
                } else {
                  print('NOT PERSON');
                }
              }
              isDetecting = false;
            });
          }
        });
      });
    }
  }

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
      // imageReady is set to true the first time a picture is taken.
      child: (imageReady) ? Image.memory(png) : CameraPreview(controller),
    );
  }
}
