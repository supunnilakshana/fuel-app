import 'package:flueapp/designs/components/buttons.dart';
import 'package:flueapp/designs/components/textfileds.dart';
import 'package:flueapp/designs/design_constants.dart';
import 'package:flueapp/screens/Home/compt/drawer.dart';
import 'package:flueapp/services/validation/validate_handeler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'compt/result_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool ischecked = false;
  final GlobalKey<FormState> _formKeycheck = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyadd = GlobalKey<FormState>();
  final TextEditingController _vidcon = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime pre_backpress = DateTime.now();
  bool _tvalue = false;
  int tval = -1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          final timegap = DateTime.now().difference(pre_backpress);
          final cantExit = timegap >= const Duration(seconds: 2);
          pre_backpress = DateTime.now();
          if (cantExit) {
            const snack = SnackBar(
              content: Text('Press Back button again to Exit'),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snack);
            return Future<bool>.value(false);
          } else {
            return Future<bool>.value(true);
          }
        },
        child: Scaffold(
            key: _scaffoldKey,
            drawer: const MenuDrawer(name: ""),
            appBar: AppBar(
              backgroundColor: kprimaryColor,
              leading: IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  _scaffoldKey.currentState!.openDrawer();
                },
                icon: Icon(
                  Icons.menu_rounded,
                  color: Colors.white,
                  size: size.width * 0.08,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.clear_all_outlined,
                    color: Colors.white,
                    size: size.width * 0.08,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.01,
                ),
              ],
              elevation: 0,
            ),
            body: Container(
              color: kprimarylightcolor,
              width: size.width,
              height: double.infinity,
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipPath(
                      clipper: WaveClipperOne(),
                      child: Container(
                        height: size.height * 0.15,
                        color: kprimaryColor,
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.only(bottom: size.height * 0.04),
                          child: Text(
                            "Station Name",
                            style: TextStyle(
                                fontSize: size.width * 0.07,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Gnoiconformfiled(
                          hintText: "Vechicel Number",
                          label: "Vechicel Number",
                          onchange: (text) {},
                          valid: (text) {
                            return Validater.genaralvalid(text!);
                          },
                          save: (text) {},
                          controller: _vidcon),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Iconbutton(
                        bicon: const Icon(Icons.graphic_eq_sharp),
                        onpress: () {},
                        text: "Check",
                        pbottom: 13,
                        ptop: 12,
                        pleft: size.width * 0.07,
                        pright: size.width * 0.07,
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        const ResultItem(),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      value: 1,
                                      groupValue: tval,
                                      onChanged: (value) {
                                        setState(() {
                                          tval = value as int;
                                        });
                                      },
                                      activeColor: Colors.green,
                                    ),
                                    SizedBox(
                                      width: size.width * 0.01,
                                    ),
                                    Text(
                                      "Petrol",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: size.width * 0.05,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 2,
                                      groupValue: tval,
                                      onChanged: (value) {
                                        setState(() {
                                          tval = value as int;
                                        });
                                      },
                                      activeColor: Colors.green,
                                    ),
                                    SizedBox(
                                      width: size.width * 0.01,
                                    ),
                                    Text(
                                      "Diesel",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: size.width * 0.05,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Container(
                            width: size.width * 0.7,
                            child: Gnoiconformfiled(
                                textinput: TextInputType.number,
                                hintText: "Vechicel Number",
                                label: "Amount of fuel(Rs)",
                                onchange: (text) {},
                                valid: (text) {
                                  return Validater.genaralvalid(text!);
                                },
                                save: (text) {},
                                controller: _vidcon),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Iconbutton(
                            bicon: const Icon(Icons.check_circle),
                            color: const Color.fromARGB(255, 70, 97, 251),
                            onpress: () {},
                            text: "Mark as fueled",
                            pbottom: 16,
                            ptop: 14,
                            pleft: size.width * 0.07,
                            pright: size.width * 0.07,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
