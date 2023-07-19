import 'package:flutter/material.dart';

class transparentTag extends StatelessWidget {
  final String data;
  transparentTag({required this.data});

  @override
  Widget build(BuildContext context) {
    return data.toString() != 'null'
        ? Container(
            child: Padding(
              padding: const EdgeInsets.all(5.5),
              child: Text(
                data,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
                color: Color.fromARGB(159, 143, 141, 141),
                borderRadius: BorderRadius.circular(30)),
          )
        : Container();
  }
}
