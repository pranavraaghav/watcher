import 'package:flutter/material.dart';

//Used in Home Page
Color mainBG = Color(0xffEAF0F8);
Color neutral = Color(0xff8E98A4);
Color primary = Color(0xff1A6BD6);
Color active = Color(0xff134B96);
Color hover = Color(0xff195FBB);
Color whiteTint = Color(0xffFDFEFF);
Color cardGray = Color(0xff8E98A4);
Color textColor = Color(0xff313A46);
Color accentYellow = Color(0xffFFD700);
//

Color snow = Color(0xffFCF7F8);
Color lightGray = Color(0xffCED3DC);
Color unselectedGray = Color(0xff707070);
Color persianGreen = Color(0xff1B998B);
Color seafoamGreen = Color(0xffBCE2BF);
Color orange = Color(0xffFC8400);
Color sixtyPercOrange = Color(0x96FC8400);
Color blackCoral = Color(0xff5B616A);

Color loginYellow = Color(0xFFFFD700);

List<Color> crosswalkBlue = [
  Color(0xff2E86FB),
  Color(0xBA08479B),
];

List<Color> sunset = [
  Color(0xffD65DB1),
  Color(0xffFF6F91),
  Color(0xffFF9671),
  Color(0xffFFC75F),
];

List<Color> instaHeavy = [
  Color(0xffffbe0b),
  Color(0xfffb5607),
  Color(0xffff006e),
  Color(0xff8338ec),
];

List<Color> twilight = [
  Color(0xff4895ef),
  Color(0xff7209b7),
  Color(0xffb5179e),
];

List<Color> dusk = [
  Color(0xfff2b880),
  Color(0xffe7cfbc),
  Color(0xffc98686),
  Color(0xff966b9d),
];

List<Color> bubbles = [
  Color(0xfff2e9e4),
  Color(0xffc9e4de),
  Color(0xffc6def1),
  Color(0xffdbcdf0),
//  Color(0xff489fb5),
];

List<Color> calm = [
  Color(0xffFED9B7),
  Color(0xff8ed4e8),
];

List<Color> spectral = [
  Color(0xffF07167),
  Color(0xffFED9B7),
  Color(0xff72efdd),
  Color(0xff0081A7),
];

LinearGradient verticalGradient(List<Color> palette) {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: palette,
  );
}

LinearGradient horizontalGradient(List<Color> palette) {
  return LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: palette,
  );
}
