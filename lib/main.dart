import 'package:escom_app/screens/isc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Pantallas importadas
import 'screens/dashboard_alumno_screen.dart';
import 'screens/dashboard_externo_screen.dart';
import 'screens/map_screen.dart';
import 'screens/galeria.dart';
import 'screens/profile_screen.dart';
import 'screens/home_screen.dart';
import 'screens/splash_intermedio_screen.dart';
import 'screens/professor_directory_screen.dart';
import 'screens/professor_schedule_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_selection_screen.dart';
import 'screens/register_alumno_screen.dart';
import 'screens/register_externo_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/historia_screen.dart';
import 'screens/actividades_screen.dart';
import 'screens/carreras.dart';
import 'screens/redes.dart';
import 'screens/chatbot.dart';
import 'screens/informacion_screen.dart';
import 'screens/configuracion.dart'; // Asegúrate de agregar esta pantalla

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Cargar preferencia de tema desde SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDarkTheme = prefs.getBool('isDarkTheme') ?? false;

  runApp(MyApp(isDarkTheme: isDarkTheme));
}

class MyApp extends StatefulWidget {
  final bool isDarkTheme;
  const MyApp({Key? key, required this.isDarkTheme}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isDarkTheme;

  @override
  void initState() {
    super.initState();
    isDarkTheme = widget.isDarkTheme;
  }

  void _toggleTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', value);
    setState(() {
      isDarkTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESCOM App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false, // Desactiva el banner
      initialRoute: '/splash', // Pantalla inicial de la app
      routes: {
        '/splash': (context) => SplashScreen(),
        '/intermediateSplash': (context) => IntermediateSplashScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) =>
            HomeScreen(role: 'alumno'), // Rol dinámico según el login
        '/map': (context) => MapScreen(),
        '/directorio': (context) =>
            ProfessorDirectoryScreen(), // Pantalla del Directorio
        '/registerSelection': (context) => RegisterSelectionScreen(),
        '/registerAlumno': (context) => RegisterAlumnoScreen(),
        '/registerExterno': (context) => RegisterExternoScreen(),
        '/forgotPassword': (context) => ForgotPasswordScreen(),
        '/profile': (context) => ProfileScreen(),
        '/galeria': (context) => GaleriaScreen(),
        '/historia': (context) => Historia(),
        '/academicInfo': (context) => InformacionScreen(),
        '/dashboardAlumno': (context) => DashboardAlumnoScreen(),
        '/dashboardExterno': (context) => DashboardExternoScreen(),
        '/actividades': (context) => ActividadesScreen(),
        '/redes': (context) => Redes(),
        '/chatbot': (context) => ChatbotScreen(),
        '/horarios': (context) => const ProfessorScheduleScreen(
              professor: {},
            ),
        '/carreras': (context) => CarrerasScreen(),
        '/isc': (context) => CarreraSistemasScreen(),
        '/configuracion': (context) => ConfiguracionScreen(
              onThemeChanged: _toggleTheme,
            ),
      },
    );
  }
}
