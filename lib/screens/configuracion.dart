import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConfiguracionScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  const ConfiguracionScreen({Key? key, required this.onThemeChanged})
      : super(key: key);

  @override
  _ConfiguracionScreenState createState() => _ConfiguracionScreenState();
}

class _ConfiguracionScreenState extends State<ConfiguracionScreen> {
  bool isDarkTheme = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    });
  }

  Future<void> _saveThemePreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkTheme', value);
  }

  void _toggleTheme(bool value) {
    setState(() {
      isDarkTheme = value;
      widget.onThemeChanged(value);
    });
    _saveThemePreference(value);
  }

  Future<void> _reauthenticateUser(String email, String password) async {
    try {
      // Credenciales para reautenticación
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      // Reautenticación
      await FirebaseAuth.instance.currentUser
          ?.reauthenticateWithCredential(credential);
    } catch (e) {
      throw Exception("Error al reautenticar: $e");
    }
  }

  Future<String> _promptPassword(BuildContext context) async {
    String password = "";
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Reautenticación requerida"),
          content: TextField(
            obscureText: true,
            decoration:
                const InputDecoration(labelText: "Ingresa tu contraseña"),
            onChanged: (value) {
              password = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Aceptar"),
            ),
          ],
        );
      },
    );
    return password;
  }

  Future<void> _deleteAccount(BuildContext context) async {
    try {
      // Obtener el usuario actual
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("No se encontró un usuario autenticado.");
      }

      // Solicita la contraseña al usuario
      String email = user.email ?? "";
      String password = await _promptPassword(context);

      // Reautenticar al usuario
      await _reauthenticateUser(email, password);

      // Eliminar el documento del usuario en Firestore
      final userDoc =
          FirebaseFirestore.instance.collection('Users').doc(user.uid);
      await userDoc.delete();

      // Eliminar la cuenta de Firebase Auth
      await user.delete();

      // Redirigir al Login
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Cuenta eliminada correctamente."),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error al eliminar la cuenta: $e"),
      ));
    }
  }

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error al cerrar sesión: $e"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text('Modo Oscuro'),
            trailing: Switch(
              value: isDarkTheme,
              onChanged: _toggleTheme,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.lock_reset),
            title: const Text('Restablecer Contraseña'),
            onTap: () {
              Navigator.pushNamed(context, '/forgotPassword');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Cambiar Foto de Perfil'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever),
            title: const Text('Eliminar Cuenta'),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Confirmar eliminación"),
                    content: const Text(
                        "¿Estás seguro de que deseas eliminar tu cuenta? Esta acción no se puede deshacer."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Cancelar"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("Eliminar"),
                      ),
                    ],
                  );
                },
              );

              if (confirm == true) {
                await _deleteAccount(context);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar Sesión'),
            onTap: () async {
              await _logout(context);
            },
          ),
        ],
      ),
    );
  }
}
