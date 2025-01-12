import 'package:flutter/material.dart';

class ProfessorScheduleScreen extends StatelessWidget {
  final Map<String, dynamic> professor;

  const ProfessorScheduleScreen({Key? key, required this.professor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Horarios de ${professor['profesor'] ?? 'Nombre no disponible'}'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nombre del profesor
              Text(
                professor['profesor'] ?? 'Nombre no disponible',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Ícono circular centrado
              Center(
                child: CircleAvatar(
                  radius: 100, // Tamaño grande del ícono
                  backgroundColor: Colors.blueGrey.shade100,
                  child: const Icon(
                    Icons.assignment_ind, // Ícono de persona
                    color: Colors.black54,
                    size: 100, // Tamaño del ícono dentro del círculo
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Departamento
              Text(
                'Departamento: ${professor['department'] ?? 'Departamento no disponible'}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // Correo
              Text(
                'Correo: ${professor['correo'] ?? 'Correo no disponible'}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // Sala
              Text(
                'Sala: ${professor['sala'] ?? 'Sala no disponible'}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Tabla de horarios con scroll horizontal
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: _buildScheduleTable(professor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleTable(Map<String, dynamic> professor) {
    final materias = professor['materias'] as List<dynamic>? ?? [];

    if (materias.isEmpty) {
      return const Center(
        child: Text(
          'No hay horarios disponibles.',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // Bordes redondeados
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Posición de la sombra
          ),
        ],
      ),
      child: DataTable(
        columnSpacing: 10.0,
        headingRowColor:
            WidgetStateColor.resolveWith((states) => Colors.indigo.shade200),
        dataRowColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.blue.shade50;
          }
          return Colors.white;
        }),
        headingTextStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        dataTextStyle: const TextStyle(fontSize: 14),
        border: TableBorder(
          horizontalInside: BorderSide(
            color: Colors.grey.shade300, // Líneas horizontales suaves
            width: 1,
          ),
        ),
        columns: const [
          DataColumn(label: Text('Materia')),
          DataColumn(label: Text('Grupo')),
          DataColumn(label: Text('Día')),
          DataColumn(label: Text('Horario')),
        ],
        rows: materias.expand((materia) {
          final horarios = (materia['horarios'] as Map<String, dynamic>);
          return horarios.entries.map((entry) {
            return DataRow(
              cells: [
                DataCell(Text(materia['nombre'] ?? 'No disponible')),
                DataCell(Text((materia['grupos'] as List<dynamic>).join(', '))),
                DataCell(Text(entry.key)),
                DataCell(Text(entry.value)),
              ],
            );
          }).toList();
        }).toList(),
      ),
    );
  }
}
