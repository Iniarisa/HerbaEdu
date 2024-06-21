import 'package:flutter/material.dart';
import 'info_screen.dart';
import 'tulang_sendi_screen.dart';
import 'perawatan_screen.dart';
import 'hormonal_screen.dart';
import 'semua_penyakit_screen.dart';
import 'saraf_screen.dart';
import 'profile_screen.dart';
import 'favorit_screen.dart'; // Mengimpor favorite_screen.dart

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda'), // Judul AppBar
        backgroundColor: Colors.green, // Warna AppBar
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Container untuk bar pencarian
          Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.green.shade200, // Warna hijau yang lebih cerah
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.white), // Ikon pencarian
                const SizedBox(width: 8.0),
                Expanded(
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Cari...', // Placeholder teks
                      hintStyle: const TextStyle(color: Colors.white),
                      border: InputBorder.none, // Tidak ada border
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchText = value.toLowerCase(); // Update state pencarian
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16), // Spasi antara bar pencarian dan tombol menu
          Expanded(
            // Expanded untuk membuat GridView memenuhi sisa ruang
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                crossAxisCount: 2, // Jumlah kolom dalam grid
                crossAxisSpacing: 16.0, // Spasi horizontal antara tombol
                mainAxisSpacing: 16.0, // Spasi vertikal antara tombol
                children: <Widget>[
                  // Filter dan tampilkan tombol menu sesuai dengan pencarian
                  ...buildFilteredMenuButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu, size: 28), // Ikon berukuran lebih besar
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 28), // Ikon berukuran lebih besar
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, size: 28), // Ikon berukuran lebih besar
            label: 'Favorit',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 1:
              // Navigasi ke halaman profil saat tombol profil ditekan
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
              break;
            case 2:
              // Tampilkan layar favorit
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoriteScreen()),
              );
              break;
            default:
              break;
          }
        },
      ),
    );
  }

  // Fungsi untuk membangun tombol menu berdasarkan filter pencarian
  List<Widget> buildFilteredMenuButtons() {
    // Daftar menu yang bisa difilter berdasarkan pencarian
    final List<Map<String, dynamic>> menuItems = [
      {'label': 'Info', 'imagePath': 'assets/informasi.jpg', 'screen': const InfoScreen()},
      {'label': 'Tulang dan Sendi', 'imagePath': 'assets/tulang sendi.jpg', 'screen': const TulangSendiScreen()},
      {'label': 'Perawatan', 'imagePath': 'assets/perawatan.jpg', 'screen': const PerawatanScreen()},
      {'label': 'Hormonal', 'imagePath': 'assets/hormonal.jpg', 'screen': const HormonalScreen()},
      {'label': 'Semua Penyakit', 'imagePath': 'assets/semua penyakit.jpg', 'screen': const SemuaPenyakitScreen()},
      {'label': 'Saraf', 'imagePath': 'assets/saraf.jpg', 'screen': const SarafScreen()},
    ];

    // Filter berdasarkan pencarian
    List<Map<String, dynamic>> filteredMenu = searchText.isEmpty
        ? menuItems
        : menuItems.where((item) => item['label'].toLowerCase().contains(searchText)).toList();

    // Bangun widget untuk setiap menu yang telah difilter
    return filteredMenu.map((item) {
      return buildMenuButton(
        context,
        item['label'],
        item['imagePath'],
        item['screen'],
      );
    }).toList();
  }

  // Fungsi untuk membangun tombol menu
  Widget buildMenuButton(BuildContext context, String label, String imagePath, Widget screen) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.green),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.green.shade900; // Warna saat tombol ditekan
            }
            return Colors.green; // Warna saat tidak ditekan
          },
        ),
      ),
      onPressed: () {
        // Navigasi ke layar yang sesuai ketika tombol ditekan
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Gambar ikon untuk tombol menu
          Image.asset(
            imagePath,
            height: 164,
            width: 164,
          ),
          const SizedBox(height: 8),
          // Label untuk tombol menu
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
