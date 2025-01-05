import 'package:flutter/material.dart';

class RegisterSelectionScreen extends StatefulWidget {
  const RegisterSelectionScreen({super.key});

  @override
  _RegisterSelectionScreenState createState() =>
      _RegisterSelectionScreenState();
}

class _RegisterSelectionScreenState extends State<RegisterSelectionScreen> {
  String _selectedOption = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Tipo de Registro'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedOption = 'alumno';
                  });
                  Future.delayed(const Duration(milliseconds: 200), () {
                    Navigator.pushNamed(context, '/registerAlumno');
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: _selectedOption == 'alumno'
                        ? Colors.blue.shade50
                        : Colors.transparent,
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(
                        Icons.school,
                        size: 100,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Registro como Alumno',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30), // Espaciado entre opciones
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedOption = 'externo';
                  });
                  Future.delayed(const Duration(milliseconds: 200), () {
                    Navigator.pushNamed(context, '/registerExterno');
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: _selectedOption == 'externo'
                        ? Colors.green.shade50
                        : Colors.transparent,
                    border: Border.all(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(
                        Icons.person,
                        size: 100,
                        color: Colors.green,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Registro como Externo',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
