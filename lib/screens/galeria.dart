import 'package:flutter/material.dart';

class Galeria extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Galeria'),
      ),
      body: Center(
        child: Text(
          'Aquí se mostrará la galeria xd',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
