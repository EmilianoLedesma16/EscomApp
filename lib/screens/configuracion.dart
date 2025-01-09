import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        ],
      ),
    );
  }
}
