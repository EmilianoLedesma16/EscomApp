import 'package:flutter/material.dart';

class ProfessorsDirectoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Directorio de Profesores'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Profesor 1'),
            subtitle: Text('Departamento de Matemáticas'),
          ),
          ListTile(
            title: Text('Profesor 2'),
            subtitle: Text('Departamento de Computación'),
          ),
        ],
      ),
    );
  }
}
