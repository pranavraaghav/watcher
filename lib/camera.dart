import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class Camera extends StatefulWidget {
  Camera({Key key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController _camera;
  bool _cameraInitialized = false;
  CameraImage _savedImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    // Getting list of cameras
    List<CameraDescription> cameras = await availableCameras();

    // Creating a camera controller
    _camera = new CameraController(cameras[0], ResolutionPreset.medium);

    // Initiliaze camera controller
    _camera.initialize().then((_) async {
      await _camera
          .startImageStream((CameraImage image) => _processCameraImage(image));
      setState(() {
        _cameraInitialized = true;
      });
    });
  }

  void _processCameraImage(CameraImage image) async {
    setState(() {
      _savedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: (_cameraInitialized)
            ? AspectRatio(
                aspectRatio: deviceRatio,
                child: CameraPreview(_camera),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
