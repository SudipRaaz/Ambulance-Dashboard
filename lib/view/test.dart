import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TestingWidget extends StatelessWidget {
  const TestingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // body: Center(
      //   child: Text('Hello, World!'),
      // ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('My App'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: Center(
          child: Text(
            'Hello, World!',
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
