// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'dart:async';
import 'package:flueapp/screens/auth_screen/check_signIn.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<WelcomeScreen> {
  final bool isnewwelcome = true;
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 3);

    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const CheckSignIn()));
  }

  initScreen(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    print("Start");
    return Scaffold(
        body: Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height * 0.2,
          ),
          Padding(
              padding: EdgeInsets.all(size.width * 0.1),
              child: Image.asset("assets/icons/appicon.png")),
          SizedBox(
            height: size.height * 0.2,
          ),
          Text(
            isnewwelcome
                ? "Copyright 2021 © Fuel app"
                : "Dinesh Asian Mart", //Copyright 2021 © Dinesh Asian Mart
            style: TextStyle(
              fontSize: isnewwelcome ? size.width * 0.04 : size.width * 0.05,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    ));
  }
}
