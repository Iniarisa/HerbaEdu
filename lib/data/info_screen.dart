import 'package:flutter/material.dart';

// Model Plant untuk merepresentasikan informasi tentang tumbuhan herbal
class Plant {
  final String name;
  final String imageUrl;
  bool isFavorite; // Variabel untuk menandai apakah tumbuhan favorit

  // Konstruktor Plant
  Plant({required this.name, required this.imageUrl, this.isFavorite = false});

  // Metode untuk toggle status favorit
  void toggleFavorite() {
    isFavorite = !isFavorite;
  }
}


// Kelas InfoScreen sebagai StatefulWidget yang menampilkan informasi tentang tumbuhan herbal
class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  List<Plant> plants = [
    Plant(name: 'Kunyit', imageUrl: 'assets/kunyit.jpeg'),
    Plant(name: 'Jahe', imageUrl: 'assets/jahe.jpeg'),
    Plant(name: 'Temulawak', imageUrl: 'assets/temulawak.jpeg'),
    Plant(name: 'Kencur', imageUrl: 'assets/kencur.jpeg'),
    // Tambahkan lebih banyak tumbuhan di sini
  ];

  List<Plant> filteredPlants = [];

  @override
  void initState() {
    super.initState();
    filteredPlants = plants;
  }

  void _filterPlants(String query) {
    final filtered = plants.where((plant) {
      final plantName = plant.name.toLowerCase();
      final searchQuery = query.toLowerCase();

      return plantName.contains(searchQuery);
    }).toList();

    setState(() {
      filteredPlants = filtered;
    });
  }

  // Callback untuk memperbarui status favorit di daftar plants
  void _updateFavoriteStatus(Plant updatedPlant) {
    final index = plants.indexWhere((plant) => plant.name == updatedPlant.name);
    if (index != -1) {
      setState(() {
        plants[index].isFavorite = updatedPlant.isFavorite;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jenis Tumbuhan Herbal'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Cari tumbuhan...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              onChanged: _filterPlants,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPlants.length,
              itemBuilder: (context, index) {
                return PlantCard(
                  plant: filteredPlants[index],
                  onFavoriteChanged: _updateFavoriteStatus, // Mengirim callback untuk mengupdate status favorit
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Kelas PlantCard sebagai StatefulWidget yang menampilkan kartu tumbuhan herbal
class PlantCard extends StatefulWidget {
  final Plant plant;
  final Function(Plant) onFavoriteChanged; // Callback untuk mengupdate status favorit

  const PlantCard({Key? key, required this.plant, required this.onFavoriteChanged}) : super(key: key);

  @override
  _PlantCardState createState() => _PlantCardState();
}

class _PlantCardState extends State<PlantCard> {
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
              builder: (context) => PlantDetailScreen(plant: widget.plant),
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
                  widget.plant.imageUrl,
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
                      widget.plant.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    IconButton(
                      icon: Icon(
                        widget.plant.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: widget.plant.isFavorite ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.plant.toggleFavorite();
                          widget.onFavoriteChanged(widget.plant); // Panggil callback untuk memberitahu perubahan favorit
                        });
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

// Halaman Detail Tumbuhan
class PlantDetailScreen extends StatelessWidget {
  final Plant plant;

  const PlantDetailScreen({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(plant.name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Image.asset(
                plant.imageUrl,
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '"Kunyit, atau Curcuma longa, adalah rempah-rempah yang berasal dari Indonesia, dengan akar kuning cerah yang menjadi ciri khasnya. Dikenal secara luas dalam pengobatan tradisional dan kuliner, kunyit telah menjadi bagian penting dari warisan budaya Indonesia. Ramuan herbal yang terbuat dari kunyit sering digunakan untuk meningkatkan kesehatan dan kebugaran secara alami. Dalam pengobatan tradisional, kunyit dianggap memiliki sifat antiinflamasi, antioksidan, dan antibakteri yang kuat. Ramuan kunyit sering digunakan untuk meredakan peradangan, meningkatkan sistem kekebalan tubuh, dan membantu pencernaan. Selain itu, kunyit juga dipercaya dapat membantu mengurangi risiko beberapa penyakit kronis, seperti penyakit jantung dan kanker. Sebagai tambahan dalam kuliner, kunyit memberikan rasa dan aroma yang khas pada masakan. Biasanya digunakan dalam bentuk bubuk atau sebagai bahan segar, kunyit dapat menambahkan warna kuning cerah dan cita rasa yang kaya pada berbagai hidangan, mulai dari kari hingga minuman herbal tradisional. Dengan kombinasi manfaat kesehatan dan kelezatan kuliner, ramuan herbal berbahan dasar kunyit menjadi pilihan yang populer bagi mereka yang menghargai keseimbangan antara gaya hidup sehat dan kenikmatan kuliner tradisional Indonesia." ${plant.name}', // Ganti ini dengan deskripsi nyata dari tumbuhan
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: InfoScreen(),
  ));
}
