import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  final List<String>? menuItems;
  final String? value;
  final String hint;
  String? personInfo;
  final String? validatorReturn;

   MyDropdown({
    Key? key,
    required this.menuItems,
    required this.value,
    required this.hint,
    required this.validatorReturn,
    required this.personInfo
  }) : super(key: key);
  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  // String selectedmenuItem = '';
  //@override
  // void initState() {
  //   super.initState();
  //   if (widget.menuItems.isNotEmpty) {
  //     selectedmenuItem = widget.menuItems.first;
  //   }
  //}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[500]),
          ),
        value: widget.personInfo,
        items: widget.menuItems?.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
          }).toList(),
        hint: Text(widget.hint),
        onChanged: (value) {
          setState(() {
            widget.personInfo = value.toString(); // check later
          });
        },
        validator: (value) {
          if (value == null) {
            return widget.validatorReturn;
          }
          return null;
        },
         //check later
      ),
    );
  }
}
