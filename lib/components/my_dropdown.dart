import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  final List<String> menuItems;
  final String label;
  const MyDropdown({
    Key? key,
    required this.menuItems,
    required this.label,
  }) : super(key: key);
  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  String selectedmenuItem = '';
  @override
  void initState() {
    super.initState();
    if (widget.menuItems.isNotEmpty) {
      selectedmenuItem = widget.menuItems.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 12),
      child: DropdownButtonFormField(
        focusColor: Colors.white,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: 'Select your ${widget.label}',
        ),
        onChanged: (newItem) {
          setState(() {
            selectedmenuItem = newItem!;
          });
        },
        items: widget.menuItems.map((String item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        value: selectedmenuItem,
      ),
    );
  }
}
