import 'package:firebase_auth/firebase_auth.dart';
import 'package:flueapp/screens/Home/home_screen.dart';
import 'package:flueapp/screens/auth_screen/sign_in.dart';
import 'package:flutter/material.dart';

import '../Home/loadhome_data.dart';

class CheckSignIn extends StatelessWidget {
  const CheckSignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return const LoadHomeScreeen();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Somthing wrong!!"),
          );
        } else {
          return const SignIn();
        }
      },
    ));
  }
}
