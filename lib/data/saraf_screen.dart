import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'saraf_herb.dart'; // Sesuaikan dengan lokasi file SarafHerb
import 'saraf_herb_detail_screen.dart'; // Sesuaikan dengan lokasi file SarafHerbDetailScreen
import 'youtube_api_service.dart'; // Update with the correct path

class SarafScreen extends StatefulWidget {
  const SarafScreen({Key? key}) : super(key: key);

  @override
  _SarafScreenState createState() => _SarafScreenState();
}

class _SarafScreenState extends State<SarafScreen> {
  List<SarafHerb> herbs = [
    SarafHerb(
      name: 'Herb A',
      imageUrl: 'assets/herb_a.jpeg',
      description:
          'Deskripsi ramuan A untuk kesehatan saraf.',
      youtubeUrl: 'https://www.youtube.com/watch?v=example1',
    ),
    SarafHerb(
      name: 'Herb B',
      imageUrl: 'assets/herb_b.jpeg',
      description:
          'Deskripsi ramuan B untuk kesehatan saraf.',
      youtubeUrl: 'https://www.youtube.com/watch?v=example2',
    ),
    // Tambahkan ramuan herbal lainnya di sini
  ];

  List<SarafHerb> filteredHerbs = [];
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    filteredHerbs = herbs;
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void _filterHerbs(String query) {
    final filtered = herbs.where((herb) {
      final herbName = herb.name.toLowerCase();
      final searchQuery = query.toLowerCase();

      return herbName.contains(searchQuery);
    }).toList();

    setState(() {
      filteredHerbs = filtered;
    });
  }

  void _toggleFavorite(SarafHerb herb) {
    setState(() {
      herb.isFavorite = !herb.isFavorite;
    });

    _saveFavoritesToPrefs();
  }

  void _saveFavoritesToPrefs() {
    List<String> favoriteNames = [];

    for (var herb in herbs) {
      if (herb.isFavorite) {
        favoriteNames.add(herb.name);
      }
    }

    _prefs.setStringList('favoriteHerbs', favoriteNames);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ramuan Herbal untuk Kesehatan Saraf'),
        backgroundColor: Colors.blue, // Ganti warna AppBar sesuai tema
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Cari ramuan herbal...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              onChanged: _filterHerbs,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredHerbs.length,
              itemBuilder: (context, index) {
                return SarafHerbCard(
                  herb: filteredHerbs[index],
                  onFavoriteChanged: _toggleFavorite,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SarafHerbCard extends StatelessWidget {
  final SarafHerb herb;
  final Function(SarafHerb) onFavoriteChanged;

  const SarafHerbCard({
    Key? key,
    required this.herb,
    required this.onFavoriteChanged,
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
              builder: (context) => SarafHerbDetailScreen(herb: herb),
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
                      icon: Icon(
                        herb.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: herb.isFavorite ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        onFavoriteChanged(herb);
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