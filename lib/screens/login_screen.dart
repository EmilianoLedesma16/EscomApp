import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  Future<void> login(BuildContext context) async {
    try {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      // Iniciar sesión con Firebase
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Verificar si el correo está confirmado
      if (!userCredential.user!.emailVerified) {
        await FirebaseAuth.instance.signOut();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'El correo no está verificado. Por favor verifica tu correo e inténtalo de nuevo.'),
        ));
        return;
      }

      // Recuperar el rol del usuario desde Firestore
      String role = await getRole(userCredential.user!.uid);

      // Redirigir al Home correspondiente según el rol
      // Limpia el stack de navegación para evitar regresar al Login
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(role: role)),
        (Route<dynamic> route) => false,
      );
    } on FirebaseAuthException catch (e) {
      // Manejo específico de errores
      String errorMessage = getErrorMessage(e.code);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));
    } catch (e) {
      // Manejo genérico de errores
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Ocurrió un error. Por favor intenta de nuevo.'),
      ));
    }
  }

  Future<String> getRole(String uid) async {
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      if (userDoc.exists) {
        return userDoc['role'] ?? 'unknown';
      }
      return 'unknown';
    } catch (e) {
      return 'unknown';
    }
  }

  // Traduce códigos de error de Firebase a mensajes claros
  String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No se encontró una cuenta con este correo.';
      case 'wrong-password':
        return 'La contraseña es incorrecta. Por favor, intenta de nuevo.';
      case 'invalid-email':
        return 'El correo ingresado no es válido.';
      case 'user-disabled':
        return 'La cuenta está deshabilitada. Contacta al soporte técnico.';
      default:
        return 'Ocurrió un error desconocido. Por favor, intenta de nuevo.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de Sesión'),
        automaticallyImplyLeading: false, // Elimina el botón de regresar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration:
                  const InputDecoration(labelText: 'Correo Electrónico'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => login(context),
              child: const Text('Iniciar Sesión'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/forgotPassword');
              },
              child: const Text('¿Olvidaste tu contraseña?'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/registerSelection');
              },
              child: const Text('¿No tienes cuenta? Regístrate'),
            ),
          ],
        ),
      ),
    );
  }
}
