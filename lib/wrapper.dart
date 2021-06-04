import 'package:crosswalk/models/user.dart';
import 'package:crosswalk/pages/authenticate/authenticate.dart';
import 'package:crosswalk/pages/home.dart';
import 'package:crosswalk/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({
    Key key,
    this.cameras,
  });
  final List<CameraDescription> cameras;

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CrosswalkUser>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home(
        cameras: widget.cameras,
      );
    }
  }
}
