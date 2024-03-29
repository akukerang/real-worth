import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  final List<String>? menuItems;
  final String? value;
  final String hint;
  final void Function(Object?)? onChanged;
  final void Function(Object?)? onSaved;

  final String? Function(Object?) validator;

  const MyDropdown({
    Key? key,
    required this.menuItems,
    required this.value,
    required this.hint,
    required this.onChanged,
    this.onSaved,
    required this.validator,
  }) : super(key: key);
  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
        value: widget.value,
        items: widget.menuItems?.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        hint: Text(widget.hint),
        onChanged: widget.onChanged,
        validator: widget.validator,
        onSaved: widget.onSaved,
        //check later
      ),
    );
  }
}
