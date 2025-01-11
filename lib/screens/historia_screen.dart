import 'package:flutter/material.dart';

class Historia extends StatelessWidget {
  final List<Map<String, String>> events = [
    {
      "year": "1993",
      "title": "Fundación de la ESCOM",
      "description":
          "Creación oficial de la Escuela Superior de Cómputo del Instituto Politécnico Nacional.",
      "image": "assets/img/consejo.jpg", // Imagen genérica
    },
    {
      "year": "1994",
      "title": "Inicio de Actividades Académicas",
      "description":
          "Se comienzan a impartir las primeras clases en los programas de ingeniería.",
      "image": "assets/img/fachada.jpg",
    },
    {
      "year": "1998",
      "title": "Primer Proyecto de Investigación Aprobado",
      "description":
          "Primer proyecto de investigación aprobado por el CONACYT, impulsando la ciencia y la tecnología.",
      "image": "assets/img/computadora.jpg",
    },
    {
      "year": "2000",
      "title": "Primera Generación de Egresados",
      "description":
          "Los primeros ingenieros en computación egresan de la ESCOM.",
      "image": "assets/img/primera.jpg",
    },
    {
      "year": "2005",
      "title": "Participación Destacada en ACM ICPC",
      "description":
          "El primer equipo de la ESCOM clasifica a la etapa regional del ACM International Collegiate Programming Contest.",
      "image": "assets/img/icpc.jpg",
    },
    {
      "year": "2008",
      "title": "Renovación de Laboratorios",
      "description":
          "Actualización de equipos en laboratorios de redes, inteligencia artificial y bases de datos.",
      "image": "assets/img/lab.jpg",
    },
    {
      "year": "2010",
      "title": "Reconocimiento del Programa por CACEI",
      "description":
          "Certificación de calidad educativa por el Consejo de Acreditación de la Enseñanza de la Ingeniería (CACEI).",
      "image": "assets/img/ia.png",
    },
    {
      "year": "2020",
      "title": "Inauguración de las Carreras de IA y LCD",
      "description":
          "La ESCOM abre las carreras de Inteligencia Artificial y Licenciatura en Ciencia de Datos, ampliando su oferta educativa en áreas de alta demanda tecnológica.",
      "image": "assets/img/inauguranIA.jpg"
    },
    {
      "year": "2022",
      "title": "Reconocimiento Nacional",
      "description":
          "La ESCOM es reconocida como una de las mejores escuelas de computación en México.",
      "image": "assets/img/ranking.PNG",
    },
    {
      "year": "2023",
      "title": "Celebración del 30° Aniversario",
      "description":
          "Eventos académicos y tecnológicos conmemorativos del aniversario.",
      "image": "assets/img/aniversario.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historia de la ESCOM'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Año del evento
                  Container(
                    width: 60,
                    child: Text(
                      event["year"]!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título del evento
                        Text(
                          event["title"]!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        // Descripción del evento
                        Text(
                          event["description"]!,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 8),
                        // Imagen del evento
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            event["image"]!,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (index < events.length - 1)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Divider(
                    color: Colors.grey[300],
                    thickness: 1,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
