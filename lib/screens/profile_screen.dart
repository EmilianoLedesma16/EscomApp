import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userName;
  File? _profileImage;
  String? _uniqueImageKey;

  @override
  void initState() {
    super.initState();
    fetchUserName();
    loadProfileImage();
  }

  /// Obtener el nombre del usuario desde Firestore
  Future<void> fetchUserName() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .get();
        setState(() {
          userName = userDoc['nombre'] ?? 'Usuario';
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener el nombre: $e')),
      );
    }
  }

  /// Cargar la imagen de perfil almacenada localmente
  Future<void> loadProfileImage() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/profile_image.png';
      final imageFile = File(imagePath);

      if (await imageFile.exists()) {
        setState(() {
          _profileImage = imageFile;
          _uniqueImageKey = DateTime.now().toString(); // Nueva clave única
        });
      }
    } catch (e) {
      debugPrint('Error al cargar la imagen: $e');
    }
  }

  /// Seleccionar una imagen desde la cámara o galería
  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);

      if (pickedImage != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = '${directory.path}/profile_image.png';

        // Copiar y sobrescribir la imagen seleccionada
        final imageFile = File(pickedImage.path);
        await imageFile.copy(imagePath);

        setState(() {
          _profileImage = File(imagePath); // Actualizar la referencia
          _uniqueImageKey = DateTime.now().toString(); // Forzar recarga
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Imagen actualizada correctamente')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al seleccionar la imagen: $e')),
      );
    }
  }

  /// Borrar la imagen de perfil
  Future<void> deleteProfileImage() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/profile_image.png';

      final imageFile = File(imagePath);
      if (await imageFile.exists()) {
        await imageFile.delete(); // Eliminar el archivo
      }

      setState(() {
        _profileImage = null; // Restablecer la imagen a nula
        _uniqueImageKey = DateTime.now().toString(); // Forzar recarga
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Imagen eliminada correctamente')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al borrar la imagen: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () =>
                    pickImage(ImageSource.gallery), // Seleccionar desde galería
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage:
                      _profileImage != null ? FileImage(_profileImage!) : null,
                  key: ValueKey(
                      _uniqueImageKey), // Clave única para forzar recarga
                  child: _profileImage == null
                      ? const Icon(Icons.person, size: 100)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Hola, ${userName ?? 'Cargando...'}',
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () =>
                    pickImage(ImageSource.camera), // Tomar foto con cámara
                icon: const Icon(Icons.camera_alt),
                label: const Text('Tomar Foto'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  backgroundColor: Colors.blue.shade300,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () => pickImage(ImageSource.gallery),
                icon: const Icon(Icons.photo_library),
                label: const Text('Seleccionar de la Galería'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  backgroundColor: Colors.blue.shade300,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              if (_profileImage !=
                  null) // Mostrar botón de borrar solo si hay una imagen
                ElevatedButton.icon(
                  onPressed: deleteProfileImage,
                  icon: const Icon(Icons.delete),
                  label: const Text('Borrar Foto'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    backgroundColor: Colors.red.shade300,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
