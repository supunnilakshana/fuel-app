import 'package:flueapp/screens/Home/home_screen.dart';
import 'package:flueapp/screens/Home/loadhome_data.dart';
import 'package:flueapp/services/email/email_auth.dart';
import 'package:flueapp/services/validation/validate_handeler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _email = "";
  String _passWord = "";
  var emailauth = EmailAuth();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _uncon = TextEditingController();
  final TextEditingController _pwcon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Color.fromARGB(255, 235, 103, 8),
              Color.fromARGB(255, 233, 109, 8),
              Color.fromARGB(255, 171, 68, 0)
            ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: size.height * 0.05),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Welcome Back",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Lottie.asset('assets/animations/fuelpump.json'),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60))),
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color.fromRGBO(225, 95, 27, .3),
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextFormField(
                                      controller: _uncon,
                                      onChanged: (value) {
                                        _email = value;
                                      },
                                      validator: (value) {
                                        return Validater.vaildemail(value!);
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Email",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextFormField(
                                      controller: _pwcon,
                                      onChanged: (value) {
                                        _passWord = value;
                                      },
                                      validator: (value) {
                                        return Validater.signupPassword(value!);
                                      },
                                      decoration: const InputDecoration(
                                          hintText: "Password",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 33,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  print("press login");
                                  print(_email);
                                  print(_passWord);
                                  await emailauth.emailsignIN(
                                      _email, _passWord);
                                  int r = emailauth.getSigninstatus();
                                  if (r == 0) {
                                    print("loged");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const LoadHomeScreeen();
                                        },
                                      ),
                                    );
                                  } else if (r == 1) {
                                    Get.snackbar(
                                      "Signin failed",
                                      "Please enter the correct email or password",
                                      icon: const Icon(Icons.error,
                                          color: Colors.white),
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  } else if (r == 2) {
                                    Get.snackbar(
                                      "Signin failed",
                                      "Please enter the correct email or password",
                                      icon: const Icon(Icons.error,
                                          color: Colors.white),
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  }
                                } else {
                                  print("Not Complete");
                                }
                              },
                              child: Container(
                                height: 50,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.orange[900]),
                                child: const Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
