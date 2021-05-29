import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:crosswalk/object_detection/live_camera.dart';
import 'package:crosswalk/pages/monitor.dart';

class Home extends StatelessWidget {
  // cameras needed to be passed on to LiveFeed screen
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Monitor()));
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
