import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Redes extends StatelessWidget {
  final List<Map<String, String>> socialMediaLinks = [
    {
      'name': 'Facebook',
      'url': 'https://www.facebook.com/ESCOM.IPN.Oficial',
      'icon': 'assets/img/facebook.png',
    },
    {
      'name': 'Twitter',
      'url': 'https://x.com/ESCOM_IPN',
      'icon': 'assets/img/x.png',
    },
    {
      'name': 'Instagram',
      'url': 'https://www.instagram.com/escom.ipn',
      'icon': 'assets/img/instagram.png',
    },
    {
      'name': 'YouTube',
      'url': 'https://www.youtube.com/ESCOMIPN',
      'icon': 'assets/img/youtube.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redes Sociales'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Síguenos en nuestras redes sociales',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: socialMediaLinks.length,
                itemBuilder: (context, index) {
                  final socialMedia = socialMediaLinks[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 12.0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.blueGrey.shade200, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            socialMedia['icon']!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(
                        socialMedia['name']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: const Text(
                        'Haz clic para abrir en tu navegador',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      trailing: ElevatedButton.icon(
                        onPressed: () => _launchURL(socialMedia['url']!),
                        icon: const Icon(Icons.link),
                        label: const Text('Abrir'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      onTap: () => _launchURL(socialMedia['url']!),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para abrir URLs externas
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'No se pudo abrir el enlace: $url';
    }
  }
}
