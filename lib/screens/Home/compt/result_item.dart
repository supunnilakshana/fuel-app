import 'package:flutter/material.dart';

class ResultItem extends StatelessWidget {
  const ResultItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.green,
        child: ListTile(
          leading: Icon(
            Icons.check_circle_sharp,
            color: Colors.white,
            size: size.width * 0.075,
          ),
          textColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "BEG-6768",
              style: TextStyle(fontSize: size.width * 0.075),
            ),
          ),
          subtitle: Row(
            children: [
              const Icon(
                Icons.timer_sharp,
                color: Colors.white,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    DateTime.now().toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: size.width * 0.04),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
