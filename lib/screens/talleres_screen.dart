import 'package:flutter/material.dart';

class Talleres extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hsitoria'),
      ),
      body: Center(
        child: Text(
          'Aguante talleres.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
