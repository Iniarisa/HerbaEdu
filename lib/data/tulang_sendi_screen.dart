import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'tulang_sendi_herb.dart'; // Update with the correct path
import 'tulang_sendi_herb_detail_screen.dart'; // Update with the correct path
import 'youtube_api_service.dart'; // Update with the correct path

class TulangSendiScreen extends StatefulWidget {
  const TulangSendiScreen({Key? key}) : super(key: key);

  @override
  _TulangSendiScreenState createState() => _TulangSendiScreenState();
}

class _TulangSendiScreenState extends State<TulangSendiScreen> {
  List<TulangSendiHerb> herbs = [
    TulangSendiHerb(
      name: 'Osteoarthritis',
      imageUrl: 'assets/Osteoarthritis.jpg',
      description:
          'Osteoarthritis: Penyakit degeneratif yang menyebabkan kerusakan pada tulang rawan sendi. Ramuan Herbal: Gunakan jahe dan kunyit. Cara: Tumbuk jahe segar dan kunyit, kemudian rebus dalam air hingga mendidih. Tambahkan madu untuk memperbaiki rasa. Minum ramuan ini secara teratur untuk mengurangi peradangan dan meningkatkan mobilitas sendi.',
      youtubeUrl: 'https://youtu.be/lZZmlJM7osE?si=y2NKZLFaQF8QavyJ',
    ),
    TulangSendiHerb(
      name: 'Pohon Asam',
      imageUrl: 'assets/pohon_asam.jpeg',
      description:
          'Pohon asam dikenal dengan khasiatnya dalam mengatasi masalah hormonal pada pria. Ekstrak daunnya dapat membantu meningkatkan kadar testosteron alami.',
      youtubeUrl: 'https://www.youtube.com/watch?v=example2',
    ),
    // Add more herbs here
  ];

  List<TulangSendiHerb> filteredHerbs = [];
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

  void _toggleFavorite(TulangSendiHerb herb) {
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
        title: const Text('Ramuan Herbal untuk Tulang dan Sendi'),
        backgroundColor: Colors.pink,
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
                return TulangSendiHerbCard(
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

class TulangSendiHerbCard extends StatelessWidget {
  final TulangSendiHerb herb;
  final Function(TulangSendiHerb) onFavoriteChanged;

  const TulangSendiHerbCard({
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
              builder: (context) => TulangSendiHerbDetailScreen(herb: herb),
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
