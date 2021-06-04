import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:crosswalk/object_detection/live_camera.dart';
import 'package:crosswalk/pages/monitor.dart';
import 'package:crosswalk/widgets/drawer.dart';

import 'package:crosswalk/models/user.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  // cameras needed to be passed on to LiveFeed screen
  const Home({
    Key key,
    this.cameras,
  });
  final List<CameraDescription> cameras;

  Widget build(BuildContext context) {
    final user = Provider.of<CrosswalkUser>(context);
    String uid = user.uid;

    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () {
                  print('Pushing to monitor screen');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Monitor(
                                uid: uid,
                              )));
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
