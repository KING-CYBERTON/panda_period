import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlareActor(
        'assets/animation.flr',
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: 'splash',
        callback: (name) {
          // Navigate to the next screen after the animation has finished
          Navigator.pushReplacementNamed(context, '/home');
        },
      ),
    );
  }
}
