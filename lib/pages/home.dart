import 'package:crosswalk/models/user.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:crosswalk/object_detection/live_camera.dart';
import 'package:crosswalk/pages/monitor.dart';
import 'package:crosswalk/widgets/drawer.dart';
import 'package:crosswalk/styling/custom_text_styles.dart';

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
      drawer: DrawerWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: EdgeInsets.fromLTRB(60, 30, 60, 30),
              ),
              onPressed: () {
                print('Pushing to monitor screen');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Monitor(),
                  ),
                );
              },
              child: Text(
                'Monitor',
                style: buildLogoTextStyle(25, Colors.white, FontWeight.bold),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange,
                padding: EdgeInsets.fromLTRB(60, 30, 60, 30),
              ),
              onPressed: () {
                print('Pushing to camera screen');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LiveFeed(cameras)));
              },
              child: Text(
                'Camera',
                style: buildLogoTextStyle(25, Colors.white, FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
