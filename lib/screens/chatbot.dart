import 'package:flutter/material.dart';
import 'package:ikchatbot/ikchatbot.dart';

class ChatbotScreen extends StatelessWidget {
  // Configuración del chatbot
  final chatBotConfig = IkChatBotConfig(
    // Configuración de rating por SMTP
    ratingIconYes: const Icon(Icons.star),
    ratingIconNo: const Icon(Icons.star_border),
    ratingIconColor: Colors.black,
    ratingBackgroundColor: Colors.white,
    ratingButtonText: 'Enviar Calificación',
    thankyouText: '¡Gracias por tu calificación!',
    ratingText: 'Califica tu experiencia:',
    ratingTitle: '¡Gracias por usar el chatbot!',
    body: 'Este es un correo de prueba enviado desde Flutter.',
    subject: 'Calificación de prueba',
    recipient: 'recipient@example.com',
    isSecure: false,
    senderName: 'Tu Nombre',
    smtpUsername: 'Tu Correo',
    smtpPassword: 'Tu Contraseña',
    smtpServer: 'smtp.gmail.com',
    smtpPort: 587,

    // Configuración general del chatbot
    sendIcon: const Icon(Icons.send, color: Colors.black),
    userIcon: const Icon(Icons.person, color: Colors.white),
    botIcon: const Icon(Icons.smart_toy, color: Colors.white),
    botChatColor: const Color.fromARGB(255, 81, 80, 80),
    userChatColor: Colors.blue,
    delayBot: 100,
    closingTime: 1,
    delayResponse: 1,
    waitingTime: 1,

    // Palabras clave y respuestas
    keywords: [
      'hola',
      'adios',
      'ubicacion',
      'localizada',
      'ubicada',
      'horarios',
      'actividades',
      'carreras',
      'contacto',
      'admision',
      'convocatoria',
      'becas',
      'calendario',
      'titulacion',
      'requisitos',
      'historia',
    ],
    responses: [
      '¡Hola!\nDime, ¿cómo puedo ayudarte?',
      'Espero haberte ayudado ¡Regresa pronto!',
      'La ESCOM está ubicada en Zacatenco en la Unidad Profesional Adolfo López Mateos, Av. Juan de Dios Bátiz, Nueva Industrial Vallejo, Gustavo A. Madero, 07320 Ciudad de México, CDMX.',
      'La ESCOM está ubicada en Zacatenco en la Unidad Profesional Adolfo López Mateos, Av. Juan de Dios Bátiz, Nueva Industrial Vallejo, Gustavo A. Madero, 07320 Ciudad de México, CDMX.',
      'La ESCOM está ubicada en Zacatenco en la Unidad Profesional Adolfo López Mateos, Av. Juan de Dios Bátiz, Nueva Industrial Vallejo, Gustavo A. Madero, 07320 Ciudad de México, CDMX.',
      'Las clases se imparten entre las 7:00 AM y las 8:00 PM.',
      'La ESCOM brinda una gran variedad de actividades deportivas (fútbol, baloncesto, voleibol, ajedrez, etc) y culturales (baile, música folklorica, teatro, etc). Consulta la sección de actividades para más información.',
      'En la ESCOM se imparten las carreras a nivel superior de ISC, IA y LCD. Además de las maestrías en Inteligencia Artificial y Ciencia de Datos y en Ciencias en Sistemas Computacionales Móviles',
      'Puedes contactarnos al teléfono (55) 5729-6000 Ext. 52000. o mandando un correo a escom@ipn.mx',
      'Puedes consultar la convocatoria de admisión en la página oficial del IPN o directamente en el sitio web de la ESCOM.',
      'Puedes consultar la convocatoria más reciente en la página oficial del IPN o directamente en el sitio web de la ESCOM. Las fechas y detalles están disponibles allí.',
      'La ESCOM ofrece diversas becas como la Beca de Manutención, IPN-Bécalos, y otras. Consulta la sección de becas en la página del IPN para requisitos y fechas.',
      'El calendario escolar incluye información sobre periodos de inscripción, exámenes, días festivos y vacaciones. Puedes descargarlo desde la página oficial del IPN o de la ESCOM.',
      'Las opciones de titulación en la ESCOM incluyen tesis, proyectos integradores, desempeño académico sobresaliente y más. Consulta la coordinación de titulación para más información.',
      'Los requisitos de admisión a la ESCOM incluyen haber concluido el nivel medio superior, presentar el examen de admisión del IPN, y entregar la documentación necesaria.',
      'La ESCOM fue fundada en 1993 y es una de las unidades académicas más destacadas del IPN en el área de ciencias computacionales. Su trayectoria está marcada por la excelencia educativa.'
    ],

    // Personalización del diseño
    backgroundColor: Colors.white,
    initialGreeting:
        "👋 ¡Hola! \nBienvenido al Chatbot de ESCOMapp\n¿Cómo puedo ayudarte hoy?",
    defaultResponse: "Lo siento, no entendí tu pregunta.",
    inactivityMessage: "¿Hay algo más en lo que te pueda ayudar?",
    closingMessage: "Esta conversación se cerrará ahora.",
    inputHint: 'Escribe tu mensaje aquí...',
    waitingText: 'Por favor, espera...',
    useAsset: false,
    backgroundAssetimage: 'assets/img/fondo.jpg',
    backgroundImage: 'assets/img/fondo.jpg',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot ESCOMapp'),
      ),
      body: ikchatbot(config: chatBotConfig),
    );
  }
}
