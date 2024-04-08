import 'package:flutter/material.dart';

class Common {
  BuildContext context;

  Common(this.context);

  double getMediaHeight() {
    return MediaQuery.of(context).size.height;
  }

  double getMediaWidth() {
    return MediaQuery.of(context).size.width;
  }

// You can add similar methods for other MediaQuery properties as needed
}

class AppColor {
  static const Color primary = Colors.white;
  static const Color secondary = Colors.black;
  static const LinearGradient pendingGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.topLeft,
    colors: [Color(0xffcfe2f3), Color(0xff98b8d5)],
  );
  static const Color completed = Colors.green;
}
