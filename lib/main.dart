import 'package:flutter/material.dart';
import 'package:crosswalk/pages/home.dart';
import 'package:crosswalk/utils/firestore_util.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';

// CameraDescription holds data concerning
// each camera available on device
List<CameraDescription> cameras;

// Future<void> because async loading of cameras or whatever
Future<void> main() async {
  // initialize the cameras when the app starts
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    home: Home(
      cameras: cameras,
    ),
    theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
  ));
}
