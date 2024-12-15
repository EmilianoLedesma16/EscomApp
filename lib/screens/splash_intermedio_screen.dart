import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IntermediateSplashScreen extends StatefulWidget {
  @override
  _IntermediateSplashScreenState createState() =>
      _IntermediateSplashScreenState();
}

class _IntermediateSplashScreenState extends State<IntermediateSplashScreen> {
  @override
  void initState() {
    super.initState();
    _redirectUser();
  }

  Future<void> _redirectUser() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.reload();
        final bool isEmailVerified = user.emailVerified;

        if (isEmailVerified) {
          // Actualizar emailVerified en Firestore
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(user.uid)
              .update({'emailVerified': true});

          // Obtener rol y redirigir
          String? role = await _getUserRole(user.uid);
          if (role == 'alumno') {
            Navigator.pushReplacementNamed(context, '/dashboardAlumno');
          } else if (role == 'externo') {
            Navigator.pushReplacementNamed(context, '/dashboardExterno');
          } else {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, '/login');
          }
        } else {
          // Redirigir al login si el correo no está verificado
          await FirebaseAuth.instance.signOut();
          Navigator.pushReplacementNamed(context, '/login');
        }
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      print('Error durante la redirección: $e');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<String?> _getUserRole(String userId) async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();
      if (userDoc.exists) {
        return userDoc['role'] as String?;
      }
    } catch (e) {
      print('Error obteniendo el rol del usuario: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
