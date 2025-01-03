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
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nombre del profesor
            Text(
              professor['profesor'] ?? 'Nombre no disponible',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Departamento
            Text(
              'Departamento: ${professor['department'] ?? 'Departamento no disponible'}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Tabla de horarios
            Expanded(child: _buildScheduleTable(professor)),
          ],
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

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 10.0, // Espaciado entre columnas
        headingRowColor:
            WidgetStateColor.resolveWith((states) => Colors.blueGrey.shade100),
        dataRowColor: WidgetStateColor.resolveWith((states) {
          // Alternar colores para las filas
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
        border: TableBorder.all(color: Colors.white, width: 0.5),
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
