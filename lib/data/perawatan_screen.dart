import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'perawatan_herb.dart'; // Sesuaikan dengan lokasi file perawatan_herb.dart
import 'perawatan_herb_detail_screen.dart'; // Sesuaikan dengan lokasi file perawatan_herb_detail_screen.dart
import 'youtube_api_service.dart'; // Update with the correct path

class PerawatanScreen extends StatefulWidget {
  const PerawatanScreen({Key? key}) : super(key: key);

  @override
  _PerawatanScreenState createState() => _PerawatanScreenState();
}

class _PerawatanScreenState extends State<PerawatanScreen> {
  List<PerawatanHerb> herbs = [
    PerawatanHerb(
      name: 'Masker Wajah untuk Kulit Berminyak',
      imageUrl: 'assets/kulitminyak.jpg',
      description:
          'Rekomendasi Herbal: Lidah Buaya (Aloe Vera)'
'Cara Pengolahan:'
'1. Ambil satu batang lidah buaya, cuci bersih.'
'2. Kupas kulit lidah buaya dan ambil gelnya.'
'3. Haluskan gel lidah buaya dan aplikasikan langsung pada wajah.'
'4. Diamkan selama 20 menit, kemudian bilas dengan air bersih.'

'- Scrub Wajah untuk Kulit Kering'
'Rekomendasi Herbal: Oatmeal dan Madu'
'Cara Pengolahan:;'
'1. Campurkan 2 sendok makan oatmeal dengan 1 sendok makan madu.'
'2. Tambahkan sedikit air hangat hingga campuran menjadi pasta.'
'3. Aplikasikan pada wajah dengan gerakan melingkar selama 5-10 menit.'
'4. Bilas dengan air hangat.',
youtubeUrl: 'https://youtu.be/QtfZ2PZI3Ng?si=cW2O3vScPzimWoG1',
    ),
    PerawatanHerb(
      name: 'Perawatan Rambut',
      imageUrl: 'assets/rawatrambut.jpg',
      description:
          '- Masker Rambut untuk Rambut Rontok'
'Rekomendasi Herbal: Minyak Kelapa dan Kemiri'
'Cara Pengolahan:'
'1. Panaskan 2 sendok makan minyak kelapa.'
'2. Tumbuk 2-3 biji kemiri hingga halus, campurkan dengan minyak kelapa.'
'3. Oleskan campuran pada kulit kepala dan rambut.'
'4. Pijat kulit kepala selama 5-10 menit, diamkan selama 30 menit, lalu bilas dengan sampo.'

'- Kondisioner Alami untuk Rambut Kering'
'Rekomendasi Herbal: Alpukat dan Minyak Zaitun'
'Cara Pengolahan:'
'1. Haluskan 1 buah alpukat matang.'
'2. Campurkan dengan 2 sendok makan minyak zaitun.;'
'3. Aplikasikan pada rambut yang sudah dicuci, fokus pada ujung rambut.'
'4. Diamkan selama 20 menit, kemudian bilas hingga bersih.',
      youtubeUrl: 'https://youtu.be/3eLSPOWELzw?si=OKxqIBiUZllgo1k1',
    ),
    // Tambahkan ramuan herbal lainnya di sini
  ];

  List<PerawatanHerb> filteredHerbs = [];
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

  void _toggleFavorite(PerawatanHerb herb) {
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
        title: const Text('Ramuan Herbal untuk Perawatan'),
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
                return PerawatanHerbCard(
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

class PerawatanHerbCard extends StatelessWidget {
  final PerawatanHerb herb;
  final Function(PerawatanHerb) onFavoriteChanged;

  const PerawatanHerbCard({
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
              builder: (context) => PerawatanHerbDetailScreen(herb: herb),
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
