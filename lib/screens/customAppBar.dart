import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title; // Título de la pantalla
  final String? username; // Nombre del usuario (opcional)

  const CustomAppBar({Key? key, required this.title, this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // Ocultar el botón "atrás"
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (username != null)
            Text(
              'Hola, $username', // Muestra el saludo si hay un nombre
              style: TextStyle(fontSize: 16),
            ),
          Expanded(
            child: Center(
              child: Text(
                title, // Título de la pantalla
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.blue,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
