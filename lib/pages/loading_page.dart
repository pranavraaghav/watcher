import 'package:crosswalk/pages/login_page.dart';
import 'package:crosswalk/styling/color_palettes.dart';
import 'package:flutter/material.dart';

// TODO: figure out how to skip loading page when navigating backwards.

class LoadingPage extends StatefulWidget {
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  // void initState() {
  //   super.initState();
  //   // init();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: verticalGradient(night),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Image.asset(
                'assets/images/logo.png',
                scale: 0.5,
              ),
            )));
  }

  // void init() async {
  //   // Wait 3 seconds
  //   await new Future.delayed(const Duration(seconds: 3));
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => LoginPage()));
  // }
}
