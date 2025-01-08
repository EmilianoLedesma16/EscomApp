import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart'; // Para rootBundle

class IsaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingeniería en Sistemas Automotrices'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            const Text(
              'Ingeniería en Sistemas Automotrices',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Breve descripción
            const Text(
              'La Ingeniería en Sistemas Automotrices forma profesionales especializados en el diseño, análisis y mantenimiento de sistemas automotrices con enfoque en innovación tecnológica y eficiencia energética.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),

            // Imagen descriptiva
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/img/isa.jpg', // Imagen específica para ISA
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
              'No Escolarizada.',
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
              'Formar ingenieros en sistemas automotrices con capacidades para innovar en el diseño, análisis y manufactura de vehículos, contribuyendo a la industria automotriz mediante el uso de tecnologías avanzadas.',
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
              'Ser una carrera reconocida a nivel nacional e internacional por la formación de ingenieros líderes en el sector automotriz, comprometidos con la innovación y el desarrollo sustentable.',
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
              '- Diseñar y analizar sistemas automotrices avanzados.\n'
              '- Implementar soluciones tecnológicas para la manufactura automotriz.\n'
              '- Evaluar y mejorar la eficiencia energética de los vehículos.\n'
              '- Aplicar principios de sustentabilidad en el desarrollo de sistemas automotrices.',
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
                      'assets/docs/mapaCurricularISA.pdf'); // Ruta del PDF del mapa curricular
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
        title: const Text('Mapa Curricular'),
      ),
      body: PDFView(
        filePath: filePath,
      ),
    );
  }
}
