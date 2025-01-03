import 'package:flutter/material.dart';
import '../services/professor_service.dart';

class ProfessorDirectoryScreen extends StatefulWidget {
  const ProfessorDirectoryScreen({Key? key}) : super(key: key);

  @override
  _ProfessorDirectoryScreenState createState() =>
      _ProfessorDirectoryScreenState();
}

class _ProfessorDirectoryScreenState extends State<ProfessorDirectoryScreen> {
  late Future<List<Map<String, dynamic>>> _professors;
  Map<String, dynamic>? _selectedProfessor;

  @override
  void initState() {
    super.initState();
    _professors = ProfessorService().fetchProfessors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Directorio de Profesores'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _professors,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('No se encontraron profesores.'));
          } else {
            final professors = snapshot.data!;
            return Row(
              children: [
                // Lista de Profesores
                Container(
                  width:
                      MediaQuery.of(context).size.width * 0.46, // 40% del ancho
                  child: ListView.builder(
                    itemCount: professors.length,
                    itemBuilder: (context, index) {
                      final professor = professors[index];
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: ListTile(
                          title: Text(
                            professor['name'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(professor['department']),
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

                // Detalles del Profesor
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
            );
          }
        },
      ),
    );
  }

  Widget _buildProfessorDetails(Map<String, dynamic> professor) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            professor['name'],
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Departamento: ${professor['department']}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            'Correo: ${professor['email']}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          const Text(
            'Horario:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...professor['schedule'].entries.map(
                (entry) => Text(
                  '${entry.key}: ${entry.value}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
        ],
      ),
    );
  }
}
