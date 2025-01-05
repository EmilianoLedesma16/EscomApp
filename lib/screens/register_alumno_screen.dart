import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class RegisterAlumnoScreen extends StatelessWidget {
  final TextEditingController boletaController = TextEditingController();
  final TextEditingController curpController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<Map<String, dynamic>> fetchAlumnosData() async {
    try {
      final String response =
          await rootBundle.loadString('assets/data/alumnos.json');
      return jsonDecode(response);
    } catch (e) {
      throw Exception('Error al cargar los datos de alumnos: $e');
    }
  }

  Future<bool> checkAlumnoExistente(String boleta, String curp) async {
    try {
      final data = await fetchAlumnosData();

      if (data['alumnos'] != null) {
        List alumnos = data['alumnos'];
        return alumnos.any((alumno) =>
            alumno['boleta'].toString() == boleta && alumno['curp'] == curp);
      } else {
        return false;
      }
    } catch (e) {
      print('Error al verificar los datos del alumno: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> getAlumnoDetails(
      String boleta, String curp) async {
    try {
      final data = await fetchAlumnosData();

      if (data['alumnos'] != null) {
        List alumnos = data['alumnos'];
        return alumnos.firstWhere(
            (alumno) =>
                alumno['boleta'].toString() == boleta && alumno['curp'] == curp,
            orElse: () => null);
      } else {
        return null;
      }
    } catch (e) {
      print('Error al obtener los detalles del alumno: $e');
      return null;
    }
  }

  Future<void> registerAlumno(BuildContext context) async {
    try {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();
      final String confirmPassword = confirmPasswordController.text.trim();
      final String boleta = boletaController.text.trim();
      final String curp = curpController.text.trim();

      if (boleta.isEmpty ||
          curp.isEmpty ||
          email.isEmpty ||
          password.isEmpty ||
          confirmPassword.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Todos los campos son obligatorios.'),
        ));
        return;
      }

      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Las contraseñas no coinciden.'),
        ));
        return;
      }

      final passwordRegex =
          RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])[A-Za-z0-9]{8,}$');
      if (!passwordRegex.hasMatch(password)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'La contraseña debe tener al menos 8 caracteres, incluir una letra mayúscula, una minúscula y un número.'),
        ));
        return;
      }

      bool alumnoValido = await checkAlumnoExistente(boleta, curp);
      if (!alumnoValido) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('La boleta o el CURP no están registrados como alumnos.'),
        ));
        return;
      }

      Map<String, dynamic>? alumnoDetails =
          await getAlumnoDetails(boleta, curp);
      if (alumnoDetails == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('No se pudieron recuperar los datos del alumno.'),
        ));
        return;
      }

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set({
        'email': email,
        'role': 'alumno',
        'boleta': boleta,
        'curp': curp,
        'nombre': alumnoDetails['nombre'],
        'primerApe': alumnoDetails['primerApe'],
        'segundoApe': alumnoDetails['segundoApe'],
        'emailVerified': false,
      });

      await userCredential.user!.sendEmailVerification();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro como Alumno'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: boletaController,
              decoration: const InputDecoration(labelText: 'Número de Boleta'),
            ),
            TextField(
              controller: curpController,
              decoration: const InputDecoration(labelText: 'CURP'),
            ),
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
            TextField(
              controller: confirmPasswordController,
              decoration:
                  const InputDecoration(labelText: 'Confirmar Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => registerAlumno(context),
              child: const Text('Registrarse como Alumno'),
            ),
          ],
        ),
      ),
    );
  }
}
