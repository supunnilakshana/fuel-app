import 'package:flutter/material.dart';

class ResultItem extends StatelessWidget {
  final bool iscan;
  final String vid;
  final String date;
  const ResultItem({
    Key? key,
    required this.iscan,
    required this.vid,
    required this.date,
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
        color: iscan ? Colors.green : const Color.fromARGB(255, 207, 51, 51),
        child: ListTile(
          leading: Icon(
            iscan ? Icons.check_circle_sharp : Icons.not_interested,
            color: Colors.white,
            size: size.width * 0.075,
          ),
          textColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              vid,
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
                    date,
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
