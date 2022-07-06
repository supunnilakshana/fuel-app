import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: const Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: ListTile(
            leading: Icon(
              Icons.account_balance,
              // size: size.width * 0.1,
            ),
            title: Text("Account details"),
          ),
        ),
      ),
    );
  }
}
