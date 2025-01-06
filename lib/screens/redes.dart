import 'package:flutter/material.dart';

class Redes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Redes Sociales'),
      ),
      body: Center(
        child: Text(
          'Aquí se mostrarán las redes sociales.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
