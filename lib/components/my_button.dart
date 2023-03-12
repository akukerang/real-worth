import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  
  final void Function()? onPressed;
  final String buttonText;
  const MyButton(
    {super.key,
    required this.onPressed,
    required this.buttonText
  }
  );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () { 
              onPressed!();
            },
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize:16,
            ),
          ),
        ),
      ),
    );
    
  }
}