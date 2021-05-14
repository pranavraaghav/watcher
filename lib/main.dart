import 'package:flutter/material.dart';
import 'package:crosswalk/pages/home.dart';
import 'package:camera/camera.dart';

// CameraDescription holds data concerning
// each camera available on device
List<CameraDescription> cameras;

// Future<void> because async loading of cameras or whatever
Future<void> main() async {
  // initialize the cameras when the app starts
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  runApp(MaterialApp(
    home: Home(
      cameras: cameras,
    ),
    theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
  ));
}
