import 'dart:convert';
import 'package:flutter/services.dart';

class ProfessorService {
  Future<List<Map<String, dynamic>>> fetchProfessors() async {
    try {
      final String response =
          await rootBundle.loadString('assets/data/profesores.json');
      return List<Map<String, dynamic>>.from(json.decode(response));
    } catch (e) {
      throw Exception('Error al cargar el archivo JSON: $e');
    }
  }
}
