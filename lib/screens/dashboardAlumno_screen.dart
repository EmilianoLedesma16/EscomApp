import 'package:flutter/material.dart';

class DashboardAlumnoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: const EdgeInsets.all(16),
        children: [
          _buildOption(context, 'ESCOM Maps', Icons.location_on, '/map'),
          _buildOption(
              context, 'Directorio de Profesores', Icons.school, '/directorio'),
          _buildOption(
              context, 'Información Académica', Icons.info, '/academicInfo'),
          _buildOption(context, 'Mapa interactivo', Icons.map, '/schoolarMap'),
          _buildOption(
              context, 'Horarios de profesores', Icons.schedule, '/Horarios'),
          _buildOption(context, 'Historia', Icons.book, '/historia'),
        ],
      ),
    );
  }

  Widget _buildOption(
      BuildContext context, String title, IconData icon, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
            SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
