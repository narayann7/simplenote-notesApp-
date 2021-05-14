import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

Color d = new Color(0xff121212);
Color d1 = new Color(0xff1E1E1E);
Color d2 = new Color(0xff232323);
Color d3 = new Color(0xff252525);
Color d4 = new Color(0xff272727);
Color d5 = new Color(0xff2C2C2C);
Color d6 = new Color(0xff2E2E2E);
Color d7 = new Color(0xff333333);
Color d8 = new Color(0xff383838);
Color d9 = Colors.grey[350];

Color b = new Color(0xff000000);
Color b1 = new Color(0xff121212);
Color t = new Color(0xff00BFA6);
Color t1 = new Color(0xff008080);
Color t2 = new Color(0xff007373);
Color t3 = new Color(0xff004D4D);
Color t4 = new Color(0xff002626);
Color t5 = new Color(0xff001A1A);
Color t6 = new Color(0xff000D0D);
Color w = Colors.white;

void vibe() async {
  if (await Vibration.hasCustomVibrationsSupport()) {
    Vibration.vibrate(duration: 30, amplitude: 1, intensities: [
      1,
      1,
      1,
      1,
    ]);
  } else {
    Vibration.vibrate();
    await Future.delayed(Duration(milliseconds: 500));
    Vibration.vibrate();
  }
}

class ScaleRoute extends PageRouteBuilder {
  final Widget page;
  ScaleRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          ),
        );
}
