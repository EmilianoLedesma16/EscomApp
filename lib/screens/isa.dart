import 'package:flutter/material.dart';

class IsaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hsitoria'),
      ),
      body: Center(
        child: Text(
          'Aquí se mostrará la linea del tiempo.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
