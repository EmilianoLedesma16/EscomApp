import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterExternoScreen extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> registerExterno(BuildContext context) async {
    try {
      final String firstName = firstNameController.text.trim();
      final String lastName = lastNameController.text.trim();
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();
      final String confirmPassword = confirmPasswordController.text.trim();

      if (firstName.isEmpty ||
          lastName.isEmpty ||
          email.isEmpty ||
          password.isEmpty ||
          confirmPassword.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, llena todos los campos.')),
        );
        return;
      }

      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Las contraseñas no coinciden.')),
        );
        return;
      }

      // Validar formato de la contraseña
      final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$');
      if (!passwordRegex.hasMatch(password)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'La contraseña debe tener al menos 8 caracteres, incluir una letra mayúscula, una minúscula y un número.'),
        ));
        return;
      }

      // Registrar usuario en Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Crear el documento en Firestore
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set({
        'email': email,
        'role': 'externo',
        'nombre': firstName,
        'primerApe': lastName,
        'emailVerified': false,
      });

      // Enviar correo de verificación
      await userCredential.user!.sendEmailVerification();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Registro exitoso. Verifica tu correo electrónico.'),
      ));

      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro Externo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: 'Apellido'),
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
              onPressed: () => registerExterno(context),
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
