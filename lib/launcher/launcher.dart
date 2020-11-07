import 'dart:async';

// import 'package:asik/landingpage/landing_home.dart';
import 'package:asik/login.dart';
import 'package:flutter/material.dart';

class Launcher extends StatefulWidget {
  @override
  _LauncherState createState() => _LauncherState();
}

class _LauncherState extends State<Launcher> {
  @override
  void initState() {
    super.initState();
    startLaunching();
  }

  startLaunching() async {
    var duration = const Duration(seconds: 3);
    return new Timer(duration, () {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_) {
        //  return new LandingPage();
        return Login();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: new Image.asset(
          "assets/launcer.png",
          height: 200.0,
          width: 300.0,
        ),
      ),
    );
  }
}
