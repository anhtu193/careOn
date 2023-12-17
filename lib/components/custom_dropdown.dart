import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  List<String> items;
  String? selectedItem;
  ValueChanged<String?> onChanged;
  CustomDropdown(
      {super.key,
      required this.items,
      required this.selectedItem,
      required this.onChanged});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _selectedItem;
  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 14, right: 7),
      decoration: BoxDecoration(
          color: Color(0xfff5f5f5),
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Color(0xffcdcdcd))),
      child: DropdownButton<String>(
        isExpanded: true,
        underline: Container(),
        value: _selectedItem,
        items: widget.items
            .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )))
            .toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedItem = newValue;
          });
          widget.onChanged(newValue); // Gửi giá trị mới về widget cha
        },
      ),
    );
  }
}
