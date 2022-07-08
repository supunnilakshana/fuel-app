// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flueapp/designs/components/buttons.dart';
import 'package:flueapp/designs/components/textfileds.dart';
import 'package:flueapp/designs/components/tots.dart';
import 'package:flueapp/designs/design_constants.dart';
import 'package:flueapp/screens/Home/compt/drawer.dart';
import 'package:flueapp/services/Data/firebaseHandeler.dart';
import 'package:flueapp/services/models/fuel_model.dart';
import 'package:flueapp/services/models/user_model.dart';
import 'package:flueapp/services/validation/date.dart';
import 'package:flueapp/services/validation/validate_handeler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'compt/result_item.dart';

class HomeScreen extends StatefulWidget {
  final UserModel userdata;
  const HomeScreen({Key? key, required this.userdata}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool ischecked = false;
  final GlobalKey<FormState> _formKeycheck = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyadd = GlobalKey<FormState>();
  final TextEditingController _vidcon = TextEditingController();
  final TextEditingController _amountcon = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime pre_backpress = DateTime.now();
  bool _iscpress = false;
  int tval = -1;
  String vnum = " ";
  late Future<List<FuelModel>> checkdata;
  final user = FirebaseAuth.instance.currentUser;
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
            drawer: MenuDrawer(name: widget.userdata.name),
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
                  onPressed: () {
                    clear();
                  },
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
                            widget.userdata.name,
                            style: TextStyle(
                                fontSize: size.width * 0.07,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        )),
                      ),
                    ),
                    Form(
                      key: _formKeycheck,
                      child: Column(
                        children: [
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
                              onpress: () async {
                                FocusScope.of(context).unfocus();
                                if (_formKeycheck.currentState!.validate()) {
                                  vnum = _vidcon.text;
                                  final today = DateFormat.yMd()
                                      .format(DateTime.now())
                                      .toString();
                                  ischecked = true;
                                  checkdata =
                                      FireDBHandeler.getFuel(vnum, today);
                                  setState(() {});
                                } else {}
                              },
                              text: "Check",
                              pbottom: 13,
                              ptop: 12,
                              pleft: size.width * 0.07,
                              pright: size.width * 0.07,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ischecked
                        ? FutureBuilder(
                            future: checkdata,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<FuelModel> data =
                                    snapshot.data as List<FuelModel>;
                                String dates = " ";
                                bool iscan = true;
                                FuelModel resitem;
                                Function() clickfun = () {};
                                if (data.isEmpty) {
                                  iscan = true;
                                  print("can");
                                  dates = "not get fuel in the time period";
                                } else {
                                  final resitem = data.first;
                                  iscan = false;

                                  dates = resitem.fueledtime;
                                  print("cant");
                                  clickfun = () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Center(
                                          child: AlertDialog(
                                            title: Text(
                                                'This vehicle can\'t get fuel  '),
                                            content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text("Regi No : " +
                                                      resitem.vnumber),
                                                  Text("Fueling Station : " +
                                                      resitem.stationname),
                                                  Text("Time : " +
                                                      resitem.fueledtime)
                                                ]),
                                            actions: [],
                                          ),
                                        );
                                      },
                                    );
                                  };
                                }
                                return Form(
                                  key: _formKeyadd,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.05,
                                      ),
                                      GestureDetector(
                                        onTap: clickfun,
                                        child: ResultItem(
                                          iscan: iscan,
                                          date: dates,
                                          vid: vnum,
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.02,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize:
                                                          size.width * 0.05,
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
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize:
                                                          size.width * 0.05,
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
                                                return Validater.isNumeric(
                                                    text!);
                                              },
                                              save: (text) {},
                                              controller: _amountcon),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.02,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Iconbutton(
                                          bicon: const Icon(Icons.check_circle),
                                          color: const Color.fromARGB(
                                              255, 70, 97, 251),
                                          onpress: _iscpress
                                              ? () {}
                                              : () async {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  if (_formKeyadd.currentState!
                                                          .validate() &&
                                                      tval != -1) {
                                                    FuelModel fuelModel = FuelModel(
                                                        id: user!.uid +
                                                            Date
                                                                .getDateTimeId() +
                                                            vnum,
                                                        vnumber: vnum,
                                                        amount: double.parse(
                                                            _amountcon.text),
                                                        ftype: tval,
                                                        stationid: user!.uid,
                                                        stationname:
                                                            "stationname",
                                                        fueleddate: DateFormat
                                                                .yMd()
                                                            .format(
                                                                DateTime.now())
                                                            .toString(),
                                                        fueledtime: DateFormat
                                                                .yMd()
                                                            .add_jm()
                                                            .format(
                                                                DateTime.now()),
                                                        cdatetime:
                                                            DateTime.now()
                                                                .toString());

                                                    int res =
                                                        await FireDBHandeler
                                                            .addfuel(fuelModel);
                                                    if (res == 1) {
                                                      Customtost.commontost(
                                                          "Added successfull",
                                                          Colors.green);
                                                      clear();
                                                    } else {
                                                      Customtost.commontost(
                                                          "Added fail ",
                                                          Colors.red);
                                                    }

                                                    ischecked = false;
                                                    setState(() {});
                                                  } else {
                                                    Customtost.commontost(
                                                        "Fill type ",
                                                        Colors.red);
                                                  }
                                                },
                                          text: "Mark as fueled",
                                          pbottom: 16,
                                          ptop: 14,
                                          pleft: size.width * 0.07,
                                          pright: size.width * 0.07,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return const Text("snapshot.hasError");
                              }
                              // By default show a loading spinner.
                              return Center(
                                  child: Lottie.asset(
                                      "assets/animations/loading.json",
                                      width: size.width * 0.4));
                            },
                          )
                        : Container()
                  ],
                ),
              ),
            )),
      ),
    );
  }

  clear() {
    FocusScope.of(context).unfocus();
    tval = -1;
    _vidcon.clear();
    _amountcon.clear();
    ischecked = false;
    setState(() {});
  }
}
