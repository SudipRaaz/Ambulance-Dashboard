import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyGradientButton extends StatelessWidget {
  // variables for buttons class
  final String text;
  final VoidCallback onPress;

  // constructor
  const MyGradientButton({
    super.key,
    required this.text,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0.0),
        elevation: 5,
      ),
      onPressed: onPress,
      child: Ink(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Color.fromARGB(255, 126, 234, 248)]),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          constraints: const BoxConstraints(minWidth: 88.0),
          child: Text(text, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
