import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class Monitor extends StatefulWidget {
  final List<CameraDescription> cameras;
  Monitor({this.cameras});

  @override
  _MonitorState createState() => _MonitorState();
}

class _MonitorState extends State<Monitor> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a room'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 65,
              child: ElevatedButton(
                onPressed: () {
                  print('Pushing to camera screen');
                  //TODO
                  // Store server address and paths
                  // ping server to get room details
                  // Create a monitoring page somehow
                  // Push new monitoring page

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ,
                  //   ),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: Text('Create room'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
