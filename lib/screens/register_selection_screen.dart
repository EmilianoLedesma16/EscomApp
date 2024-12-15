import 'package:flutter/material.dart';

class RegisterSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar Tipo de Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/registerAlumno');
              },
              child: Text('Registro como Alumno'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // Botón más ancho
                padding: EdgeInsets.symmetric(vertical: 15), // Altura del botón
              ),
            ),
            SizedBox(height: 30), // Espaciado entre botones
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/registerExterno');
              },
              child: Text('Registro como Externo'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // Botón más ancho
                padding: EdgeInsets.symmetric(vertical: 15), // Altura del botón
              ),
            ),
          ],
        ),
      ),
    );
  }
}
