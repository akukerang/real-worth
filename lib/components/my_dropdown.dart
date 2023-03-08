import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  final List<String> menuItems;
  const MyDropdown({
    Key? key,
    required this.menuItems,
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
    return Center(
      child: DropdownButton(
        hint: const Text('Select Fruit'),
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
