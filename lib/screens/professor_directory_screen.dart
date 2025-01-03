import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/professor_service.dart';
import 'package:flutter/services.dart';
import 'professor_schedule_screen.dart';

class ProfessorDirectoryScreen extends StatefulWidget {
  const ProfessorDirectoryScreen({Key? key}) : super(key: key);

  @override
  _ProfessorDirectoryScreenState createState() =>
      _ProfessorDirectoryScreenState();
}

class _ProfessorDirectoryScreenState extends State<ProfessorDirectoryScreen> {
  List<Map<String, dynamic>> _professors = [];
  List<Map<String, dynamic>> _filteredProfessors = [];
  Map<String, dynamic>? _selectedProfessor;

  @override
  void initState() {
    super.initState();
    _loadProfessors();
  }

  Future<void> _loadProfessors() async {
    try {
      final data = await ProfessorService().fetchProfessors();
      setState(() {
        _professors = data;
        _filteredProfessors =
            data; // Inicialmente, muestra todos los profesores
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar profesores: $e')),
      );
    }
  }

  void _filterProfessors(String query) {
    setState(() {
      _filteredProfessors = _professors.where((professor) {
        final name = professor['profesor']?.toLowerCase() ?? '';
        return name.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Directorio de Profesores'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar profesor por nombre...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterProfessors,
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.48,
                  child: ListView.builder(
                    itemCount: _filteredProfessors.length,
                    itemBuilder: (context, index) {
                      final professor = _filteredProfessors[index];
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: ListTile(
                          title: Text(
                            professor['profesor'] ?? 'Nombre no disponible',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(professor['department'] ??
                              'Departamento no disponible'),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {
                            setState(() {
                              _selectedProfessor = professor;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: _selectedProfessor != null
                      ? _buildProfessorDetails(_selectedProfessor!)
                      : const Center(
                          child: Text(
                            'Selecciona un profesor para ver los detalles',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfessorDetails(Map<String, dynamic> professor) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            professor['profesor'] ?? 'Nombre no disponible',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Departamento: ${professor['department'] ?? 'No disponible'}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            'Correo: ${professor['email'] ?? 'No disponible'}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              try {
                final String response = await rootBundle
                    .loadString('assets/data/horarios_profesores.json');
                final List<dynamic> horarios = json.decode(response);

                final professorSchedule = horarios.firstWhere(
                  (p) => p['profesor'] == professor['profesor'],
                  orElse: () => null,
                );

                if (professorSchedule != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfessorScheduleScreen(
                        professor: professorSchedule,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'No se encontraron horarios para este profesor.')),
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error al cargar horarios: $e')),
                );
              }
            },
            child: const Text('Ver Horarios'),
          ),
        ],
      ),
    );
  }
}
