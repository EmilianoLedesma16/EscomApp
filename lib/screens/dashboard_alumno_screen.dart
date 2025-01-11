import 'package:flutter/material.dart';

class DashboardAlumnoScreen extends StatelessWidget {
  const DashboardAlumnoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: const EdgeInsets.all(16),
        children: [
          _buildOption(
              context, 'Información General', Icons.info, '/academicInfo'),
          _buildOption(context, 'ESCOM Maps', Icons.location_on, '/map'),
          _buildOption(
              context, 'Directorio de Profesores', Icons.phone, '/directorio'),
          _buildOption(context, 'Galería', Icons.photo_album, '/galeria'),
          _buildOption(context, 'Historia', Icons.work_history, '/historia'),
          _buildOption(context, 'Carreras', Icons.school, '/carreras'),
          _buildOption(context, 'Actividades Extracurriculares',
              Icons.sports_football, '/actividades'),
          _buildOption(
              context, 'Chatbot', Icons.chat_bubble_rounded, '/chatbot'),
          _buildOption(context, 'Redes sociales', Icons.facebook, '/redes'),
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
