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
    botIcon: const Icon(Icons.android, color: Colors.white),
    botChatColor: const Color.fromARGB(255, 81, 80, 80),
    userChatColor: Colors.blue,
    delayBot: 100,
    closingTime: 1,
    delayResponse: 1,
    waitingTime: 1,

    // Palabras clave y respuestas
    keywords: ['ubicacion', 'horarios', 'actividades', 'carreras', 'contacto'],
    responses: [
      'ESCOM está ubicada en Zacatenco, Ciudad de México.',
      'Las clases se imparten entre las 7:00 AM y las 8:00 PM.',
      'Consulta la sección de actividades para más información.',
      'Las carreras incluyen ISC, IA y LCD.',
      'Puedes contactarnos al teléfono (55) 5729-6000 Ext. 52000.'
    ],

    // Personalización del diseño
    backgroundColor: Colors.white,
    initialGreeting:
        "👋 ¡Hola! \nBienvenido al Chatbot de ESCOM\n¿Cómo puedo ayudarte hoy?",
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
        title: const Text('Chatbot ESCOM'),
      ),
      body: ikchatbot(config: chatBotConfig),
    );
  }
}
