// lib/services/youtube_api_service.dart

import 'dart:convert'; // Import dart:convert untuk menggunakan JSON decoding
import 'package:http/http.dart' as http; // Import http dari package:http untuk melakukan HTTP requests

Future<Map<String, dynamic>> fetchVideoDetails(String videoId) async {
  final apiKey = 'GOOGLEAPIS'; 
  final url = ' ';

  final response = await http.get(Uri.parse(url)); // Melakukan HTTP GET request ke URL yang disediakan

  if (response.statusCode == 200) { // Jika status code response adalah 200 (OK)
    return json.decode(response.body)['items'][0]; // Mengembalikan detail video pertama dari array 'items'
  } else {
    throw Exception('Gagal memuat detail video'); // Melemparkan exception jika gagal mendapatkan respons 200 OK
  }
}
