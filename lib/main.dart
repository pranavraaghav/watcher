import 'package:crosswalk/models/user.dart';
import 'package:crosswalk/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:crosswalk/pages/home.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:crosswalk/wrapper.dart';

// CameraDescription holds data concerning
// each camera available on device
List<CameraDescription> cameras;

// Future<void> because async loading of cameras or whatever
Future<void> main() async {
  // initialize the cameras when the app starts
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StreamProvider<CrosswalkUser>.value(
      initialData: CrosswalkUser(
        uid: null,
        displayName: null,
        email: null,
      ),
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: Wrapper(
          cameras: cameras,
        ),
      ),
    );
  }
}
