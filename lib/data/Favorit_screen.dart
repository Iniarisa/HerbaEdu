import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'hormonal_herb.dart'; // Sesuaikan dengan lokasi file hormonal_herb.dart
import 'hormonal_herb_detail_screen.dart'; // Sesuaikan dengan lokasi file hormonal_herb_detail_screen.dart
import 'saraf_herb.dart';
import 'saraf_herb_detail_screen.dart';
import 'perawatan_herb.dart';
import 'perawatan_herb_detail_screen.dart';
import 'tulang_sendi_herb.dart';
import 'tulang_sendi_herb_detail_screen.dart';
import 'semua_penyakit_herb.dart';
import 'semua_penyakit_detail_screen.dart';


class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late SharedPreferences _prefs;
  List<HormonalHerb> favoriteHerbs = [];

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadFavoriteHerbs();
  }

  void _loadFavoriteHerbs() {
    List<String>? favoriteNames = _prefs.getStringList('favoriteHerbs');
    if (favoriteNames != null) {
      setState(() {
        favoriteHerbs = favoriteNames
            .map((name) => HormonalHerb(
                  name: name,
                  imageUrl: 'assets/kencur.jpeg',// Sesuaikan jika diperlukan
                  description: '', // Sesuaikan jika diperlukan
                  youtubeUrl: '', // Sesuaikan jika diperlukan
                  isFavorite: true,
                ))
            .toList();
      });
    }
  }

  void _removeFavorite(HormonalHerb herb) {
    setState(() {
      herb.isFavorite = false;
      favoriteHerbs.removeWhere((element) => element.name == herb.name);
    });

    _saveFavoritesToPrefs();
  }

  void _saveFavoritesToPrefs() {
    List<String> favoriteNames =
        favoriteHerbs.map((herb) => herb.name).toList();
    _prefs.setStringList('favoriteHerbs', favoriteNames);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ramuan Favorit'),
        backgroundColor: Colors.pink,
      ),
      body: favoriteHerbs.isEmpty
          ? Center(
              child: Text('Belum ada data favorit sama sekali!'),
            )
          : ListView.builder(
              itemCount: favoriteHerbs.length,
              itemBuilder: (context, index) {
                return FavoriteHerbCard(
                  herb: favoriteHerbs[index],
                  onFavoriteRemoved: _removeFavorite,
                );
              },
            ),
    );
  }
}

class FavoriteHerbCard extends StatelessWidget {
  final HormonalHerb herb;
  final Function(HormonalHerb) onFavoriteRemoved;

  const FavoriteHerbCard({
    Key? key,
    required this.herb,
    required this.onFavoriteRemoved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HormonalHerbDetailScreen(herb: herb),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  herb.imageUrl,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      herb.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      herb.description,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        onFavoriteRemoved(herb);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
