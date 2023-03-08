import 'package:flutter/material.dart';
import 'package:real_worth/components/my_dropdown.dart';

class Test extends StatelessWidget {
  Test({Key? key}) : super(key: key);

  final List<String> test = ["testing", "123"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: MyDropdown(menuItems: test),
    ));
  }
}
