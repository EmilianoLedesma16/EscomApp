import 'package:flutter/material.dart';

class ActividadesScreen extends StatelessWidget {
  final List<Map<String, String>> actividadesDeportivas = [
    {
      'nombre': 'Club de Fútbol',
      'descripcion':
          'Participa en entrenamientos y torneos representando a la ESCOM. Ideal para quienes buscan mejorar su técnica y trabajo en equipo.',
      'imagen': 'assets/img/futbol.jpg',
    },
    {
      'nombre': 'Club de Voleibol',
      'descripcion':
          'Entrena y juega voleibol en un ambiente competitivo y colaborativo. Abierto a todos los niveles de experiencia.',
      'imagen': 'assets/img/voleibol.jpg',
    },
    {
      'nombre': 'Club de Básquetbol',
      'descripcion':
          'Mejora tus habilidades de baloncesto y compite en torneos. Fomenta el trabajo en equipo y la disciplina deportiva.',
      'imagen': 'assets/img/basquetbol.jpg',
    },
    {
      'nombre': 'Club de Ping Pong',
      'descripcion':
          'Desarrolla tu precisión y reflejos en el club de ping pong. Compite en torneos y participa en eventos internos.',
      'imagen': 'assets/img/pingpong.jpg',
    },
    {
      'nombre': 'Club de Taekwondo',
      'descripcion':
          'Aprende técnicas de defensa personal y participa en exhibiciones. Ideal para mejorar tu concentración y condición física.',
      'imagen': 'assets/img/taekwondo.PNG',
    },
    {
      'nombre': 'Club de Béisbol',
      'descripcion':
          'Únete al equipo de béisbol de la ESCOM y disfruta de entrenamientos y torneos. Ideal para quienes disfrutan el deporte en equipo.',
      'imagen': 'assets/img/beisbol.jpg',
    },
    {
      'nombre': 'Club de Ajedrez',
      'descripcion':
          'Mejora tus habilidades estratégicas y participa en competencias locales. Un espacio ideal para los amantes del pensamiento crítico.',
      'imagen': 'assets/img/ajedrez.jpg',
    },
  ];

  final List<Map<String, String>> actividadesCulturales = [
    {
      'nombre': 'Taller de Baile',
      'descripcion':
          'Aprende diversos estilos de baile y participa en presentaciones artísticas. Perfecto para expresar tu creatividad.',
      'imagen': 'assets/img/baile.jpg',
    },
    {
      'nombre': 'Club de Robótica',
      'descripcion':
          'Desarrolla robots innovadores y compite en eventos tecnológicos. Una oportunidad perfecta para los amantes de la tecnología.',
      'imagen': 'assets/img/robotica.jpg',
    },
    {
      'nombre': 'Taller de Pintura',
      'descripcion':
          'Explora tu creatividad con técnicas de pintura. Exhibe tu trabajo en galerías y eventos artísticos.',
      'imagen': 'assets/img/pintura.jpg',
    },
    {
      'nombre': 'Club de Teatro',
      'descripcion':
          'Desarrolla tus habilidades actorales y participa en puestas en escena. Ideal para quienes disfrutan el arte dramático.',
      'imagen': 'assets/img/teatro.jpg',
    },
    {
      'nombre': 'Música Folklórica',
      'descripcion':
          'Disfruta y aprende música tradicional mexicana. Participa en presentaciones dentro y fuera de la escuela.',
      'imagen': 'assets/img/musica.jpg',
    },
    {
      'nombre': 'Tuna',
      'descripcion':
          'Forma parte de la tradicional tuna estudiantil. Canta, toca instrumentos y participa en eventos culturales.',
      'imagen': 'assets/img/tuna.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actividades Extracurriculares'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Actividades Deportivas',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            ...actividadesDeportivas
                .map((actividad) => _buildActividadCard(actividad)),
            const SizedBox(height: 32),
            const Text(
              'Actividades Culturales',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 16),
            ...actividadesCulturales
                .map((actividad) => _buildActividadCard(actividad)),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildActividadCard(Map<String, String> actividad) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.asset(
              actividad['imagen']!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  actividad['nombre']!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  actividad['descripcion']!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
