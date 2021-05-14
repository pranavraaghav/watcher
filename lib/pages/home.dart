import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:crosswalk/pages/camera_join_room.dart';
import 'package:crosswalk/pages/monitor_create_room.dart';

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
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 80,
              child: ElevatedButton(
                onPressed: () {
                  print('Pushing to monitor screen');

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Monitor()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.monitor),
                    SizedBox(width: 5),
                    Text('Monitor')
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 80,
              child: ElevatedButton(
                onPressed: () {
                  print('Pushing to camera screen');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => JoinRoom(cameras: cameras)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.visibility),
                    SizedBox(width: 5),
                    Text('Camera')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
