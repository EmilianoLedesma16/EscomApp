import 'package:flutter/material.dart';

class GaleriaScreen extends StatelessWidget {
  final Map<String, List<String>> categories = {
    "Infraestructura": [
      'assets/img/biblioteca.jpg',
      'assets/img/atardecer.jpg',
      'assets/img/arcoiris.jpg',
      'assets/img/fachada.jpg',
      'assets/img/letras.jpg',
      'assets/img/explanada.jpg',
      'assets/img/casileros.jpg',
      'assets/img/cajero.jpg',
      'assets/img/mural.jpg',
      'assets/img/auditorio.jpg',
      'assets/img/estacionamiento.jpg',
      'assets/img/lab.jpg',
      'assets/img/labComputo.jpg',
      'assets/img/motos.jpg',
      'assets/img/uno.jpeg',
      'assets/img/dos.jpeg',
      'assets/img/tres.jpeg',
      'assets/img/cuatro.jpg',
    ],
    "Eventos Académicos": [
      'assets/img/conferencia.jpg',
      'assets/img/expo1.jpg',
      'assets/img/expo2.jpg',
      'assets/img/inauguranIA.jpg',
      'assets/img/icpc.jpg',
      'assets/img/genesis.jpg',
      'assets/img/icpcfinals.jpg',
      'assets/img/musica.jpg',
    ],
    "Actividades": [
      'assets/img/aniversario.jpg',
      'assets/img/beisbol.jpg',
      'assets/img/basquetbol.jpg',
      'assets/img/foto.jpg',
      'assets/img/baile.jpg',
      'assets/img/tiburon.jpg',
      'assets/img/taekwondo.PNG',
      'assets/img/tuna.jpg',
      'assets/img/teatro.jpg',
    ],
    "Vida Estudiantil": [
      'assets/img/tres.jpeg',
      'assets/img/auditorio.jpg',
      'assets/img/ia3.jpg',
      'assets/img/ia1.jpg',
      'assets/img/infra.jpg',
      'assets/img/rebelion.jpg',
      'assets/img/rebelion1.jpg',
      'assets/img/rebelion2.jpg',
      'assets/img/pingpong.jpg',
      'assets/img/navidad.jpg',
      'assets/img/rector.jpg',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Galería de Imágenes"),
        backgroundColor: Colors.blue.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: categories.entries.map((entry) {
            final String category = entry.key;
            final List<String> images = entry.value;
            final ScrollController scrollController = ScrollController();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título de la categoría
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Contenedor de imágenes con flechas
                SizedBox(
                  height: 150,
                  child: Row(
                    children: [
                      // Flecha izquierda
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          scrollController.animateTo(
                            scrollController.offset - 150,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                      // Lista horizontal de imágenes
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImageDetailScreen(
                                        imagePath: images[index]),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 8.0),
                                width: 150,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    images[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Flecha derecha
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          scrollController.animateTo(
                            scrollController.offset + 150,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ImageDetailScreen extends StatelessWidget {
  final String imagePath;

  const ImageDetailScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vista Detallada"),
      ),
      body: Center(
        child: Hero(
          tag: imagePath,
          child: Image.asset(imagePath, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
