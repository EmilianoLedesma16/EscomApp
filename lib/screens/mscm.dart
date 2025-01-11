import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart'; // Para rootBundle

class MscmScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maestría en Sistemas Computacionales Móviles'),
        backgroundColor: Colors.pink.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            const Text(
              'Maestría en Sistemas Computacionales Móviles',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Breve descripción
            const Text(
              'La Maestría en Sistemas Computacionales Móviles está orientada a formar expertos en el desarrollo, diseño y optimización de sistemas móviles y distribuidos, con un enfoque en aplicaciones de alto rendimiento.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),

            // Imagen descriptiva
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/img/mscm.jpg', // Imagen específica para MSCM
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
              'Formar especialistas en sistemas computacionales móviles capaces de liderar proyectos tecnológicos, innovar en el desarrollo de sistemas distribuidos y optimizar recursos en plataformas móviles.',
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
              'Ser un posgrado líder en el área de sistemas móviles, reconocido por la formación de profesionistas con impacto en la investigación y la industria tecnológica.',
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
              'El egresado de esta maestría será capaz de:\n'
              '- Diseñar y desarrollar aplicaciones móviles de alto rendimiento.\n'
              '- Implementar soluciones en sistemas distribuidos y en la nube.\n'
              '- Optimizar el uso de recursos en plataformas móviles.\n'
              '- Liderar proyectos de investigación y desarrollo tecnológico.',
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
              'Consulta el mapa curricular para conocer las asignaturas de este programa.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final file = await _loadPdfFromAssets(
                      'assets/docs/mapaCurricularMSCM.pdf'); // Ruta del PDF para MSCM
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
