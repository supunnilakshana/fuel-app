import 'package:flueapp/designs/components/errorpage.dart';
import 'package:flueapp/designs/design_constants.dart';
import 'package:flueapp/screens/Home/home_screen.dart';
import 'package:flueapp/services/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:lottie/lottie.dart';

import '../../services/Data/firebaseHandeler.dart';

class LoadHomeScreeen extends StatefulWidget {
  const LoadHomeScreeen({
    Key? key,
  }) : super(key: key);
  @override
  _LoadHomeScreeenState createState() => _LoadHomeScreeenState();
}

class _LoadHomeScreeenState extends State<LoadHomeScreeen> {
  late Future<UserModel> futureData;

  @override
  void initState() {
    super.initState();
    futureData = FireDBHandeler.getUser();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: futureData,
      builder: (context, snapshot) {
        print(snapshot.hasData);
        if (snapshot.hasData) {
          UserModel data = snapshot.data as UserModel;
          return HomeScreen(
            userdata: data,
          );
        } else if (snapshot.hasError) {
          return Errorpage(size: size.width * 0.7);
        }
        // By default show a loading spinner.
        return Scaffold(
          backgroundColor: kprimarylightcolor,
          body: Center(
              child: Lottie.asset("assets/animations/loading.json",
                  width: size.width * 0.3)),
        );
      },
    );
  }

  loaddata() async {
    futureData = FireDBHandeler.getUser();
    setState(() {});
  }
}
