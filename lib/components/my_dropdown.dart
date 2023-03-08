import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  final List<String> menuItems;
  const MyDropdown({
    super.key,
    required this.menuItems,
    });
  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  String selectedmenuItem = ' ';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton(
        hint: const Text('Select Fruit'),
        onChanged: (newItem){
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