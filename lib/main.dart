import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gemzeru/util/const.dart';
import 'package:gemzeru/util/theme_config.dart';

import 'package:gemzeru/screens/splash/splash.dart';
import 'package:gemzeru/screens/auth/login.dart';
import 'package:gemzeru/screens/edit_profile.dart';
import 'package:gemzeru/screens/main_screen.dart';
void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: themeData(ThemeConfig.lightTheme),
      darkTheme: themeData(ThemeConfig.darkTheme),
      home: Splash(),
      routes: <String, WidgetBuilder> {
        '/splash': (BuildContext context) => new Splash(),
        '/signIn' : (BuildContext context) => new SignIn(),
        '/MainScreen' : (BuildContext context) => new MainScreen(),
        '/editProfile' : (BuildContext context) => new EditProfile(),
      },
    );
  }

  ThemeData themeData(ThemeData theme) {
    return theme.copyWith(
      textTheme: GoogleFonts.sourceSansProTextTheme(
        theme.textTheme,
      ),
    );
  }
}
