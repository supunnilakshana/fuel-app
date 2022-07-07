import 'package:firebase_core/firebase_core.dart';
import 'package:flueapp/screens/Home/home_screen.dart';
import 'package:flueapp/screens/auth_screen/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flue APP',
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          textTheme: GoogleFonts.robotoSerifTextTheme(
            Theme.of(context).textTheme,
          )),
      home: SignIn(),
    );
  }
}
