import 'package:firebase_auth/firebase_auth.dart';
import 'package:flueapp/designs/design_constants.dart';
import 'package:flueapp/screens/auth_screen/sign_in.dart';
import 'package:flutter/material.dart';

import '../../../designs/components/popup_dilog.dart';
import '../../../designs/components/tots.dart';

class MenuDrawer extends StatelessWidget {
  final String name;
  MenuDrawer({
    Key? key,
    required this.name,
  }) : super(key: key);

  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
        color: const Color.fromARGB(255, 192, 79, 45).withOpacity(1),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                  // image: DecorationImage(
                  //   image: AssetImage("assets/images/dashappbar.jpg"),
                  //   fit: BoxFit.cover,
                  // ),
                  color: Color.fromARGB(255, 208, 81, 43)),
              accountEmail: Text(user!.email.toString()),
              accountName: Text(name),
              currentAccountPicture: Image.asset("assets/icons/profile.png"),
            ),
            Card(
              color: kprimarylightcolor,
              child: ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('Reset Password'),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return FogetPWScreen();
                  //     },
                  //   ),
                  // );
                },
              ),
            ),
            Card(
              color: kprimarylightcolor,
              child: ListTile(
                leading: const Icon(Icons.history_sharp),
                title: const Text('History'),
                onTap: () async {},
              ),
            ),
            Card(
              color: kprimarylightcolor,
              child: ListTile(
                leading: const Icon(Icons.people),
                title: const Text('About Us'),
                onTap: () {
                  // Customtost.commontost(
                  //     "We are Zeedx Developers", Colors.amber);
                },
              ),
            ),
            Card(
              color: kprimarylightcolor,
              child: ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('App Version'),
                onTap: () {
                  Customtost.commontost("Version 1.0.0", Colors.green);
                },
              ),
            ),
            Card(
              color: kprimarylightcolor,
              child: ListTile(
                leading: const Icon(Icons.logout_rounded),
                title: const Text('Logout'),
                onTap: () {
                  PopupDialog.showPopuplogout(
                      context, "Signout", "Do you want to signout ? ",
                      () async {
                    // await FirebaseAuth.instance.signOut();

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignIn()));
                    print("logingout");
                  });
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.2,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: CustRoundedButton(
            //     height: size.height * 0.06,
            //     width: size.width * 0.25,
            //     text: "Logout",
            //     onpress: () async {
            //       // print(user.providerData[0].providerId);

            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
