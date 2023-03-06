import 'package:flutter/material.dart';

class RectTile extends StatelessWidget {
  final String imagePath;
  final String imgDis;
  const RectTile({
    super.key,
    required this.imagePath,
    required this.imgDis,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey[200],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Image.asset(
            imagePath,
            height: 24,
          ),
          const SizedBox(width: 25),
            Text(
              imgDis,
              style: const TextStyle(
                fontSize: 20,
              )
            ),
        ],
          )
        );
  }
}