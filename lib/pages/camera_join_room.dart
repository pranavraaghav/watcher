import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:crosswalk/object_detection/live_camera.dart';

class JoinRoom extends StatefulWidget {
  final List<CameraDescription> cameras;
  JoinRoom({this.cameras});

  @override
  _JoinRoomState createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join a room'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Room ID',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4), gapPadding: 2),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 65,
            child: ElevatedButton(
              onPressed: () {
                print('Pushing to camera screen');
                // TODO
                // Get camera_token from server
                // Pass on all relevant data elegantly

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LiveFeed(cameras: widget.cameras),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepOrange,
              ),
              child: Text('Start Surveillance'),
            ),
          ),
        ],
      ),
    );
  }
}
