import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gemzeru/components/animations/type_write.dart';
import 'package:gemzeru/screens/auth/login.dart';
import 'package:gemzeru/util/const.dart';
import 'package:gemzeru/util/router.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // Timer to change the screen in 1.2 seconds
  startTimeout() {
    return Timer(Duration(milliseconds: 7000), handleTimeout);
  }

  void handleTimeout() {
    changeScreen();
  }

  changeScreen() async {
    Router.pushPageWithFadeAnimation(context, SignIn());
  }

  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Hero(
              tag: 'appname',
              child: Material(
                type: MaterialType.transparency,
                child: TypeWrite(
                  word: '${Constants.appName}',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                  seconds: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
