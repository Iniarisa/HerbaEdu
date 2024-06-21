import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'saraf_herb.dart'; // Sesuaikan dengan lokasi file hormonal_herb.dart

class SarafHerbDetailScreen extends StatelessWidget {
  final SarafHerb herb;

  const SarafHerbDetailScreen({Key? key, required this.herb}) : super(key: key);

  Future<void> _launchYoutubeUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak dapat membuka $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(herb.name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: InkWell(
                onTap: () => _launchYoutubeUrl(herb.youtubeUrl),
                child: Image.asset(
                  herb.imageUrl,
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              herb.description,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
