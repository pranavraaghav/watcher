import 'package:flutter/material.dart';
import 'package:crosswalk/pages/home.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

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
