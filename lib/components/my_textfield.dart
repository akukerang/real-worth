import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller; //access textfield contents
  final String hintText; //place holder
  final bool obscureText; //hide characters when typing password
  final String labelText;
  final TextInputType keyboardType;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;

  final void Function(String?) onSaved;
  final String? Function(String?) validator;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.obscureText = false,
      this.labelText = '',
      this.keyboardType = TextInputType.text,
      this.errorText,
      required this.onSaved,
      required this.validator,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          errorText: errorText,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
