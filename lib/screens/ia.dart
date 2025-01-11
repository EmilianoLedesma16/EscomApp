import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart'; // Para rootBundle

class CarreraIAScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingeniería en Inteligencia Artificial'),
        backgroundColor: Colors.pink.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            const Text(
              'Ingeniería en Inteligencia Artificial',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Breve descripción
            const Text(
              'La Ingeniería en Inteligencia Artificial forma profesionales con habilidades para diseñar y desarrollar soluciones innovadoras basadas en el aprendizaje automático, el procesamiento del lenguaje natural y la visión por computadora.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),

            // Imagen descriptiva
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/img/ia.png', // Imagen específica para IA
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 200,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Modalidad
            const Text(
              'Modalidad',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Escolarizada.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),

            // Misión
            const Text(
              'Misión',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Formar profesionistas en el campo de la inteligencia artificial con capacidades para resolver problemas complejos, innovar tecnologías disruptivas y contribuir al desarrollo de la sociedad de manera ética y sustentable.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),

            // Visión
            const Text(
              'Visión',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ser una carrera reconocida a nivel nacional e internacional como líder en formación de especialistas en inteligencia artificial, comprometida con la innovación tecnológica y el impacto social positivo.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),

            // Perfil de egreso
            const Text(
              'Perfil de Egreso',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'El egresado de esta carrera será capaz de:\n'
              '- Diseñar e implementar modelos de aprendizaje automático.\n'
              '- Desarrollar sistemas inteligentes para diversas aplicaciones.\n'
              '- Resolver problemas complejos mediante algoritmos avanzados.\n'
              '- Integrar tecnologías de inteligencia artificial en procesos industriales y sociales.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Mapa Curricular
            const Text(
              'Mapa Curricular',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'A continuación puedes consultar el mapa curricular de la carrera.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final file = await _loadPdfFromAssets(
                      'assets/docs/mapaCurricularIIA.pdf'); // Ruta del PDF del mapa curricular
                  if (file != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PdfViewerScreen(file.path),
                      ),
                    );
                  }
                },
                child: const Text('Ver Mapa Curricular'),
              ),
            ),
            const SizedBox(height: 24),

            // Unidades Optativas
            const Text(
              'Unidades Optativas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Consulta el documento con las unidades optativas disponibles para la carrera.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final file = await _loadPdfFromAssets(
                      'assets/docs/optativasIA.pdf'); // Ruta del PDF de unidades optativas
                  if (file != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PdfViewerScreen(file.path),
                      ),
                    );
                  }
                },
                child: const Text('Ver Unidades Optativas'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Función para cargar el PDF desde los assets
  Future<File?> _loadPdfFromAssets(String assetPath) async {
    try {
      final data = await rootBundle.load(assetPath);
      final bytes = data.buffer.asUint8List();
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/temp.pdf');
      await file.writeAsBytes(bytes);
      return file;
    } catch (e) {
      print('Error cargando PDF: $e');
      return null;
    }
  }
}

class PdfViewerScreen extends StatelessWidget {
  final String filePath;

  const PdfViewerScreen(this.filePath, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa curricular IIA 2020'),
      ),
      body: PDFView(
        filePath: filePath,
      ),
    );
  }
}
