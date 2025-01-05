import 'package:flutter/material.dart';

class Mscm extends StatelessWidget {
  const Mscm({super.key});

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
