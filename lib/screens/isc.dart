import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart'; // Para rootBundle

class CarreraSistemasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingeniería en Sistemas Computacionales'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            const Text(
              'Ingeniería en Sistemas Computacionales',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Breve descripción
            const Text(
              'La Ingeniería en Sistemas Computacionales forma profesionales capaces de diseñar, implementar y administrar sistemas de software para resolver problemas complejos de la industria y la sociedad.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),

            // Imagen descriptiva
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/img/isc.png',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 200,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Misión
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
              'Formar profesionales con sólidos conocimientos en tecnología de información, capaces de innovar y contribuir al desarrollo sustentable, con un compromiso ético y social.',
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
              'Ser una carrera líder en el desarrollo de sistemas computacionales a nivel nacional e internacional, reconocida por su calidad académica y por la formación de profesionistas competentes.',
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
              '- Diseñar y desarrollar sistemas de software.\n'
              '- Administrar bases de datos y sistemas de información.\n'
              '- Innovar tecnologías para la solución de problemas reales.\n'
              '- Aplicar principios éticos y de sustentabilidad en su desempeño profesional.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Mapa curricular
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
                      'assets/docs/mapaCurricularISC.pdf');
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
