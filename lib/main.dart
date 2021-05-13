import 'package:flutter/material.dart';
import 'object_detection/live_camera.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  // initialize the cameras when the app starts
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  runApp(MaterialApp(
    home: LiveFeed(cameras),
    theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
  ));
}
