import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'hormonal_herb.dart';
import 'hormonal_herb_detail_screen.dart';
import 'youtube_api_service.dart'; // Sesuaikan dengan lokasi file SemuaPenyakitHerbDetailScreen

class HormonalScreen extends StatefulWidget {
  const HormonalScreen({Key? key}) : super(key: key);

  @override
  _HormonalScreenState createState() => _HormonalScreenState();
}

class _HormonalScreenState extends State<HormonalScreen> {
  List<HormonalHerb> herbs = [
    HormonalHerb(
      name: 'Sindrom Pra-Menstruasi (PMS)',
      imageUrl: 'assets/Kunyit.jpeg',
      description:
          'Pengolahan: Rebus 1 sendok teh kencur dalam 1 cangkir air selama 10-15 menit. Saring dan minum sekali sehari selama dua minggu sebelum menstruasi.',
      youtubeUrl: 'https://youtu.be/qCNBCtft2Nc?si=hyiIfhG8lUP9AHVG',
    ),
    HormonalHerb(
      name: 'Sindrom Ovarium Polikistik (PCOS)',
      imageUrl: 'assets/temulawak.jpeg',
      description:
          'Campurkan setengah sendok teh temulawak bubuk ke dalam segelas air hangat. Tambahkan madu secukupnya untuk menambah rasa. Minum ramuan ini secara teratur, idealnya di pagi hari, untuk membantu mengatur siklus menstruasi dan meredakan gejala PCOS.',
      youtubeUrl: 'https://youtube.com/shorts/sPeaD--SMKo?si=404RHAZWM7cDM9IT',
    ),
    // Tambahkan ramuan herbal lainnya di sini
  ];

  List<HormonalHerb> filteredHerbs = [];
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

  void _toggleFavorite(HormonalHerb herb) {
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
        title: const Text('Ramuan Herbal untuk Keseimbangan Hormonal'),
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
                return HormonalHerbCard(
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

class HormonalHerbCard extends StatelessWidget {
  final HormonalHerb herb;
  final Function(HormonalHerb) onFavoriteChanged;

  const HormonalHerbCard({
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
