import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String label;

  const MyButton({super.key, required this.onTap, this.label = ""});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: Colors.deepPurpleAccent[400],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    fontFamily: 'Impact'),
              ),
            ),
          ),
        ));
  }
}
