import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import paket url_launcher

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'), // Judul AppBar
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        children: [
          buildProfileCard(
            name: 'Arisa Rizatul Zahra',
            npm: '22082010055',
            phone: '08993546250',
            address: 'Jl. Kenangan No. 123, Surabaya',
            institution: 'Universitas Pembangunan Veteran Jawa Timur',
            email: 'iniarisa15@gmail.com',
            imageAsset: 'assets/arisa.jpg',
          ),
          const SizedBox(height: 20),
          buildProfileCard(
            name: 'Arifatus Fitriani',
            npm: '22082010084',
            phone: '0812987654321',
            address: 'Jl. Bahagia No. 456, Sidoarjo',
            institution: 'Universitas Pembangunan Veteran Jawa Timur',
            email: 'Arifa@gmail.com',
            imageAsset: 'assets/arifa1.jpg',
          ),
        ],
      ),
    );
  }

  Widget buildProfileCard({
    required String name,
    required String npm,
    required String phone,
    required String address,
    required String institution,
    required String email,
    required String imageAsset,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(imageAsset),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                name, // Nama pengguna
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
            ),
            const SizedBox(height: 10),
            Divider(color: Colors.teal[200], thickness: 1.0),
            buildInfoRow(Icons.account_circle, 'NPM', npm),
            buildInfoRow(Icons.phone, 'No. Telp', phone),
            buildInfoRow(Icons.location_on, 'Alamat', address),
            buildInfoRow(Icons.school, 'Instansi', institution),
            GestureDetector(
              onTap: () => launchUrl(Uri.parse('mailto:$email')),
              child: buildInfoRow(Icons.email, 'Email', email, isLink: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(IconData icon, String label, String info, {bool isLink = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal),
          const SizedBox(width: 10),
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              info,
              style: TextStyle(
                fontSize: 18,
                color: isLink ? Colors.blue : Colors.black,
                decoration: isLink ? TextDecoration.underline : TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> launchUrl(Uri url) async {
  if (!await canLaunch(url.toString())) {
    throw 'Could not launch $url';
  }
  await launch(url.toString());
}
