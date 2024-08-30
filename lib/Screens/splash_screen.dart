import 'dart:async';

import 'package:flutter/material.dart';
import 'package:imagecloud/Screens/login_screen.dart';
class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}
class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    super.initState();
    Timer((Duration(seconds: 1)), () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login_Screen(),));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash'),
      ),
    );
  }
}
