import 'package:flutter/material.dart'; // Import modul flutter material
import 'package:flutter_application_2/data/splash_screen.dart'; // Pastikan path benar

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Daftar Resep Herbal', // Judul aplikasi yang akan ditampilkan
      theme: ThemeData(
        primarySwatch: Colors.green, // Tema utama aplikasi dengan warna primer diatur ke hijau
      ),
      home: const SplashScreen(), // Menampilkan SplashScreen sebagai halaman beranda aplikasi
    );
  }
}
