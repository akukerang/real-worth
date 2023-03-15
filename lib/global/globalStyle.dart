import 'package:flutter/material.dart';

class componentStyle {
  static textFieldStyle({
    String labelTextStr = "",
    String hintTextStr = "",
  }) {
    return InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      fillColor: Colors.grey.shade200,
      filled: true,
      labelText: labelTextStr,
      hintText: hintTextStr,
      hintStyle: TextStyle(color: Colors.grey[500]),
    );
  }

  static dropdownStyle() {
    return InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      fillColor: Colors.grey.shade200,
      filled: true,
      hintStyle: TextStyle(color: Colors.grey[500]),
    );
  }

  static elevatedStyle() {
    return ElevatedButton.styleFrom(backgroundColor: Colors.black);
  }
}
