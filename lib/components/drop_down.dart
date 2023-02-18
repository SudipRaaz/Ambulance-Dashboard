import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String? _selectedOption;
  List<String> _options = ['Option 1', 'Option 2', 'Option 3'];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedOption,
      hint: Text('Select an option'),
      onChanged: (String? newValue) {
        setState(() {
          _selectedOption = newValue;
        });
      },
      items: _options.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
    );
  }
}
