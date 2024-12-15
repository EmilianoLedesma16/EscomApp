import 'package:flutter/material.dart';

class SchoolarMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa Interactivo'),
      ),
      body: Center(
        child: Text(
          'Aquí se mostrará el mapa interactivo.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
