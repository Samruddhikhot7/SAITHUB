import 'package:flutter/material.dart';

class Techfusion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Techfusion Page')),
      body: Center(
        child: Text(
          'Techfusion Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
