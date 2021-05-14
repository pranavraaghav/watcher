import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:crosswalk/object_detection/live_camera.dart';

class Home extends StatelessWidget {
  const Home({
    Key key,
    this.cameras,
  });
  final List<CameraDescription> cameras;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  print('Pushing to monitor screen');
                },
                child: Text('Monitor')),
            ElevatedButton(
                onPressed: () {
                  print('Pushing to camera screen');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LiveFeed(cameras)));
                },
                child: Text('Camera')),
          ],
        ),
      ),
    );
  }
}
