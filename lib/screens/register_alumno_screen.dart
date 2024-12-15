import 'dart:convert'; // Para decodificar JSON
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart'; // Para cargar archivos locales

class RegisterAlumnoScreen extends StatelessWidget {
  final TextEditingController boletaController = TextEditingController();
  final TextEditingController curpController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Cargar el JSON de boletas y CURPs desde un archivo local
  Future<Map<String, dynamic>> fetchAlumnosData() async {
    try {
      // Cargar el archivo JSON desde la carpeta assets/data
      final String response =
          await rootBundle.loadString('assets/data/alumnos.json');
      print("Archivos JSON cargado correctamente");
      return jsonDecode(response); // Parsear el JSON
    } catch (e) {
      throw Exception('Error al cargar los datos de alumnos: $e');
    }
  }

  Future<bool> checkAlumnoExistente(String boleta, String curp) async {
    try {
      // Cargar los datos desde el JSON
      final data = await fetchAlumnosData();

      // Asegurarnos de que 'alumnos' no sea null
      if (data['alumnos'] != null) {
        List alumnos = data['alumnos'];

        // Buscar si la boleta y el curp están en los datos cargados
        bool boletaValida = alumnos.any((alumno) => alumno['boleta'] == boleta);
        bool curpValido = alumnos.any((alumno) => alumno['curp'] == curp);

        // Devolver verdadero solo si ambas condiciones son verdaderas
        return boletaValida && curpValido;
      } else {
        print('Error: Los datos de alumnos no existen en el JSON.');
        return false;
      }
    } catch (e) {
      print('Error al verificar los datos del alumno: $e');
      return false;
    }
  }

  Future<void> registerAlumno(BuildContext context) async {
    try {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();
      final String confirmPassword = confirmPasswordController.text.trim();
      final String boleta = boletaController.text.trim();
      final String curp = curpController.text.trim();

      // Validar que los campos no estén vacíos
      if (boleta.isEmpty ||
          curp.isEmpty ||
          email.isEmpty ||
          password.isEmpty ||
          confirmPassword.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Todos los campos son obligatorios.'),
        ));
        return;
      }

      // Validar que las contraseñas coincidan
      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Las contraseñas no coinciden.'),
        ));
        return;
      }

      // Validar formato de la contraseña
      final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$');
      if (!passwordRegex.hasMatch(password)) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'La contraseña debe tener al menos 8 caracteres, incluir una letra mayúscula, una minúscula y un número.'),
        ));
        return;
      }

      // Verificar si la boleta y el CURP existen en el JSON
      bool alumnoValido = await checkAlumnoExistente(boleta, curp);
      if (!alumnoValido) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('La boleta o el CURP no están registrados como alumnos.'),
        ));
        return;
      }

      // Registrar usuario en Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Crear el documento en Firestore inmediatamente
      await completeRegistration(
          userCredential.user!.uid, email, boleta, curp, 'alumno');

      // Enviar correo de verificación
      await userCredential.user!.sendEmailVerification();

      // Mostrar mensaje y redirigir al login
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Registro exitoso. Se ha enviado un correo de verificación. Por favor, verifica tu bandeja de entrada.'),
      ));

      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${e.toString()}'),
      ));
    }
  }

  Future<void> completeRegistration(
      String uid, String email, String boleta, String curp, String role) async {
    try {
      await FirebaseFirestore.instance.collection('Users').doc(uid).set({
        'email': email,
        'role': role,
        'boleta': boleta,
        'curp': curp,
        'emailVerified': false,
      });
      print('Documento creado correctamente en Firestore para el UID: $uid');
    } catch (e) {
      print('Error al crear el documento en Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro como Alumno'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: boletaController,
              decoration: InputDecoration(labelText: 'Número de Boleta'),
            ),
            TextField(
              controller: curpController,
              decoration: InputDecoration(labelText: 'CURP'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Correo Electrónico'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirmar Contraseña'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => registerAlumno(context),
              child: Text('Registrarse como Alumno'),
            ),
          ],
        ),
      ),
    );
  }
}
