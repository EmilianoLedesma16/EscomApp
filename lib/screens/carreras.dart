import 'package:flutter/material.dart';

// Importa las pantallas correspondientes a cada carrera
import 'isc.dart'; // Ingeniería en Sistemas Computacionales
import 'ia.dart'; // Ingeniería en Inteligencia Artificial
import 'lcd.dart'; // Licenciatura en Ciencia de Datos
import 'isa.dart'; // Ingeniería en Sistemas Automotrices
import 'mscm.dart'; // Maestría en Sistemas Computacionales Móviles
import 'miacd.dart'; // Maestría en Inteligencia Artificial y Ciencia de Datos

class CarrerasScreen extends StatelessWidget {
  // Define las carreras de nivel superior
  final List<_CarreraItem> carrerasSuperior = [
    _CarreraItem(
      title: 'Ingeniería en Sistemas Computacionales',
      imagePath: 'assets/img/isc.png',
      destination: CarreraSistemasScreen(),
    ),
    _CarreraItem(
      title: 'Ingeniería en Inteligencia Artificial',
      imagePath: 'assets/img/ia.png',
      destination: CarreraIAScreen(),
    ),
    _CarreraItem(
      title: 'Licenciatura en Ciencia de Datos',
      imagePath: 'assets/img/lcd.jpg',
      destination: CienciaDeDatosScreen(),
    ),
    _CarreraItem(
      title: 'Ingeniería en Sistemas Automotrices',
      imagePath: 'assets/img/isa.jpg',
      destination: IsaScreen(),
    ),
  ];

  // Define las carreras de posgrado
  final List<_CarreraItem> carrerasPosgrado = [
    _CarreraItem(
      title: 'Maestría en Sistemas Computacionales Móviles',
      imagePath: 'assets/img/mscm.jpg',
      destination: MscmScreen(),
    ),
    _CarreraItem(
      title: 'Maestría en Inteligencia Artificial y Ciencia de Datos',
      imagePath: 'assets/img/ia.png',
      destination: MiacdScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oferta Educativa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sección de nivel superior
              const Text(
                'Nivel Superior',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              _buildCareerGrid(carrerasSuperior),

              const SizedBox(height: 30),

              // Sección de posgrado
              const Text(
                'Posgrado',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              _buildCareerGrid(carrerasPosgrado),
            ],
          ),
        ),
      ),
    );
  }

  // Método para construir el GridView
  Widget _buildCareerGrid(List<_CarreraItem> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Número de columnas
        crossAxisSpacing: 10, // Espaciado horizontal
        mainAxisSpacing: 10, // Espaciado vertical
        childAspectRatio: 3 / 4, // Relación de aspecto
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final carrera = items[index];
        return GestureDetector(
          onTap: () {
            // Navegar a la pantalla correspondiente
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => carrera.destination),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    child: Image.asset(
                      carrera.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    carrera.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Clase para definir las carreras y sus propiedades
class _CarreraItem {
  final String title;
  final String imagePath;
  final Widget destination;

  _CarreraItem({
    required this.title,
    required this.imagePath,
    required this.destination,
  });
}
