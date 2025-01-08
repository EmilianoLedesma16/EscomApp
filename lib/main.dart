import 'package:escom_app/screens/isc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// Pantallas importadas
//import 'screens/customAppBar.dart';
import 'screens/dashboard_alumno_screen.dart';
import 'screens/dashboard_externo_screen.dart';
import 'screens/map_screen.dart';
import 'screens/galeria.dart';
import 'screens/profile_screen.dart';
import 'screens/home_screen.dart';
import 'screens/splash_intermedio_screen.dart';
import 'screens/professor_directory_screen.dart';
//import 'services/professor_service.dart';
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
import 'screens/informacion_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESCOM App',
      theme: ThemeData.light(),
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
        '/horarios': (context) => const ProfessorScheduleScreen(
              professor: {},
            ),
        '/carreras': (context) => CarrerasScreen(),
        //'/dashboardAlumno': (context) => DashboardAlumnoScreen(),
        //'/dashboardAlumno': (context) => DashboardAlumnoScreen(),
        '/isc': (context) => CarreraSistemasScreen(),
      },
    );
  }
}
