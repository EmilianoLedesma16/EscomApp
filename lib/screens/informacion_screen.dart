import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class InformacionScreen extends StatefulWidget {
  @override
  _InformacionScreenState createState() => _InformacionScreenState();
}

class _InformacionScreenState extends State<InformacionScreen> {
  late Map<DateTime, List<String>> _events;
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();

    // Normalizar las fechas al inicio del día
    _events = {
      _normalizeDate(DateTime(2024, 8, 26)): [
        'Inicio del Semestre 2025-1'
      ], // Verde
      _normalizeDate(DateTime(2025, 1, 21)): [
        'Fin del Semestre 2025-1'
      ], // Rojo
      _normalizeDate(DateTime(2025, 2, 10)): [
        'Inicio del Semestre 2025-2'
      ], // Verde
      _normalizeDate(DateTime(2025, 7, 7)): ['Fin del Semestre 2025-2'], // Rojo
      ..._generateVacationDays(DateTime(2025, 4, 17), DateTime(2025, 4, 25),
          'Vacaciones de Semana Santa'), // Morado
      _normalizeDate(DateTime(2025, 5, 5)): ['Batalla de Puebla'], // Azul
    };
  }

  Map<DateTime, List<String>> _generateVacationDays(
      DateTime start, DateTime end, String eventName) {
    final Map<DateTime, List<String>> days = {};
    DateTime current = start;
    while (current.isBefore(end.add(Duration(days: 1)))) {
      days[_normalizeDate(current)] = [eventName];
      current = current.add(Duration(days: 1));
    }
    return days;
  }

  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  List<String> _getEventsForDay(DateTime day) {
    return _events[_normalizeDate(day)] ?? [];
  }

  Color _getEventColor(String event) {
    if (event.contains('Inicio')) return Colors.green;
    if (event.contains('Fin')) return Colors.red;
    if (event.contains('Vacaciones')) return Colors.purple;
    return Colors.blue; // Días festivos
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información General'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ubicación
              Text(
                'Ubicación',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Avenida Juan de Dios Bátiz S/N,\nColonia Nueva Industrial Vallejo,\nAlcaldía Gustavo A. Madero, Ciudad de México.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),

              // Horarios
              Text(
                'Contacto',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Teléfono: 555729 6000 Ext. 52001\nCorreo: escom@ipn.mx',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),

              // Horarios
              Text(
                'Horarios de Clases',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'De lunes a viernes: 7:00 - 21:00 hrs.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),

              // Transporte Público Cercano
              Text(
                'Transporte Público Cercano',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.train, color: Colors.orange),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Metro:\n'
                      '• Línea 5 - Politécnico (a 1 km).\n'
                      '• Línea 6 - Lindavista (a 3.1 km).',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.directions_bus_filled, color: Colors.red),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Metrobús:\n'
                      '• Línea 3 - La Patera (a 1.3 km).',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Simbología del Calendario
              Text(
                'Simbología del Calendario',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _buildLegendItem('Inicio de Semestre', Colors.green),
              _buildLegendItem('Fin de Semestre', Colors.red),
              _buildLegendItem('Vacaciones', Colors.purple),
              _buildLegendItem('Días Festivos', Colors.blue),
              SizedBox(height: 16),

              // Calendario Académico
              Text(
                'Calendario Académico',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TableCalendar(
                focusedDay: _focusedDay,
                firstDay: DateTime(2024, 1, 1),
                lastDay: DateTime(2025, 12, 31),
                headerStyle: HeaderStyle(formatButtonVisible: false),
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, date, events) {
                    if (events.isEmpty) return null;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: events.map((event) {
                        final color = _getEventColor(event as String);
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                          width: 8,
                          height: 8,
                        );
                      }).toList(),
                    );
                  },
                ),
                eventLoader: _getEventsForDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Icon(Icons.circle, color: color, size: 12),
        SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
