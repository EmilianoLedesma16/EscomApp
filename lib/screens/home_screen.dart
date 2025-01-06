import 'package:escom_app/screens/dashboard_externo_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dashboard_alumno_screen.dart';
import 'profile_screen.dart';
import 'carreras.dart';

class HomeScreen extends StatefulWidget {
  final String role;
  const HomeScreen({Key? key, required this.role}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late final List<Widget> _screens;
  String? userName;

  @override
  void initState() {
    super.initState();

    fetchUserName();

    _screens = [
      _buildHomeScreen(),
      widget.role == 'alumno'
          ? DashboardAlumnoScreen()
          : DashboardExternoScreen(),
      ProfileScreen(),
    ];
  }

  Future<void> fetchUserName() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        throw Exception("Usuario no autenticado.");
      }
      final userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();
      if (!userDoc.exists) {
        throw Exception("Usuario no encontrado en Firestore.");
      }
      setState(() {
        userName = userDoc['nombre'] ?? 'Usuario';
      });
    } catch (e) {
      setState(() {
        userName = 'Usuario';
      });
      print('Error al obtener el nombre del usuario: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ESCOMapp'),
        backgroundColor: const Color.fromARGB(255, 212, 216, 240),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
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
        backgroundColor: const Color.fromARGB(255, 212, 216, 240),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
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
          // Bienvenida con el nombre del usuario
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              userName != null ? 'Hola, $userName' : 'Hola, usuario...',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

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
              height: 200,
            ),
          ),

          // Descripción breve
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nivel Superior',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),
                _buildCareerGrid([
                  _CareerItem(
                    title: 'Ingeniería en Sistemas Computacionales',
                    imagePath: 'assets/img/isc.png',
                    modalidad: 'Modalidad Escolarizada',
                  ),
                  _CareerItem(
                    title: 'Ingeniería en Inteligencia Artificial',
                    imagePath: 'assets/img/ia.png',
                    modalidad: 'Modalidad Escolarizada',
                  ),
                  _CareerItem(
                    title: 'Licenciatura en Ciencia de Datos',
                    imagePath: 'assets/img/lcd.jpg',
                    modalidad: 'Modalidad Escolarizada',
                  ),
                  _CareerItem(
                    title: 'Ingeniería en Sistemas Automotrices',
                    imagePath: 'assets/img/isa.jpg',
                    modalidad: 'Modalidad No Escolarizada',
                  ),
                ]),
                const SizedBox(height: 30),
                const Text(
                  'Maestrías de Posgrado',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),
                _buildCareerGrid([
                  _CareerItem(
                    title:
                        'Maestría en Inteligencia Artificial y Ciencia de Datos',
                    imagePath: 'assets/img/ia.png',
                    modalidad: 'Modalidad No Escolarizada',
                  ),
                  _CareerItem(
                    title: 'Maestría en Sistemas Computacionales Móviles',
                    imagePath: 'assets/img/mscm.jpg',
                    modalidad: 'Modalidad No Escolarizada',
                  ),
                ]),
                const SizedBox(height: 30),
                const Text(
                  '¿Quieres conocer más acerca de estas carreras?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CarrerasScreen()),
                      );
                    },
                    child: const Text('Ver más'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCareerGrid(List<_CareerItem> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 4,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _FlipCard(item: items[index]);
      },
    );
  }
}

class _CareerItem {
  final String title;
  final String imagePath;
  final String modalidad;

  _CareerItem(
      {required this.title, required this.imagePath, required this.modalidad});
}

class _FlipCard extends StatefulWidget {
  final _CareerItem item;
  const _FlipCard({required this.item});

  @override
  State<_FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<_FlipCard> {
  bool _isFlipped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isFlipped = !_isFlipped;
        });
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _isFlipped
            ? Card(
                key: ValueKey(true),
                color: Colors.blue,
                child: Center(
                  child: Text(
                    widget.item.modalidad,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : Card(
                key: ValueKey(false),
                color: Colors.white,
                child: Column(
                  children: [
                    Expanded(
                      child:
                          Image.asset(widget.item.imagePath, fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.item.title,
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
      ),
    );
  }
}
