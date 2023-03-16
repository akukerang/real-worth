import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String label;
  const Label({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const SizedBox(height: 16.0),
      Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      ),
      const SizedBox(height: 8.0),
    ]);
  }
}
