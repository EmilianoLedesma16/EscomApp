import 'package:escom_app/screens/dashboard_externo_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'isc.dart'; // Pantalla para Ingeniería en Sistemas Computacionales
import 'ia.dart'; // Pantalla para Ingeniería en Tecnologías Computacionales
import 'lcd.dart'; // Pantalla para Licenciatura en Ciencias de la Computación
import 'isa.dart'; // Pantalla para Maestría en Ciencias de la Computación
import 'mscm.dart'; // Pantalla para Ingeniería en Software
import 'miacd.dart'; // Pantalla para Licenciatura en Desarrollo de Software
import 'dashboard_alumno_screen.dart'; // Pantalla de Dashboard para alumnos
import 'profile_screen.dart'; // Pantalla de perfil

class HomeScreen extends StatefulWidget {
  final String role;
  final String? username;

  const HomeScreen({Key? key, required this.role, this.username})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = [
      _buildHomeScreen(), // Pantalla principal
      widget.role == 'alumno'
          ? DashboardAlumnoScreen()
          : DashboardExternoScreen(), // Redirige según el rol
      ProfileScreen(), // Pantalla de Perfil
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.app_shortcut, size: 28),
            SizedBox(width: 8),
            Text('ESCOMapp'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person, size: 28), // Ícono de perfil
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Opciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Carrusel de imágenes
          CarouselSlider(
            items: [
              Image.asset('assets/img/uno.jpeg', fit: BoxFit.cover),
              Image.asset('assets/img/dos.jpeg', fit: BoxFit.cover),
              Image.asset('assets/img/tres.jpeg', fit: BoxFit.cover),
              Image.asset('assets/img/cuatro.jpg', fit: BoxFit.cover),
            ],
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              viewportFraction: 1.0,
              height:
                  200, // Establece una altura fija para que todas las imágenes tengan el mismo tamaño
            ),
          ),

          // Descripción breve
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Bienvenido a la ESCOM, la Escuela Superior de Cómputo del IPN, '
              'una institución líder en la formación de profesionales en informática y tecnología.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
          ),

          // Sección de Oferta Académica
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Oferta Académica',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                // Botones mejor distribuidos
                _buildCareerButton('Ingeniería en Sistemas Computacionales',
                    CarreraSistemasScreen()),
                _buildCareerButton('Ingeniería en Inteligencia Artificial',
                    CarreraInteligencia()),
                _buildCareerButton(
                    'Licenciatura en Ciencia de Datos', CienciaDeDatos()),
                _buildCareerButton(
                    'Ingeniería en Sistemas Automotrices', Isa()),
                _buildCareerButton(
                    'Maestría en Inteligencia Artificial y Ciencia de Datos',
                    Miacd()),
                _buildCareerButton(
                    'Maestría en Sistemas Computacionales Móviles', Mscm()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCareerButton(String careerName, Widget screen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => screen,
            ),
          );
        },
        child: Text(careerName),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
          backgroundColor: Colors.blue,
          textStyle: TextStyle(fontSize: 16), // Cambiar el color si lo deseas
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
