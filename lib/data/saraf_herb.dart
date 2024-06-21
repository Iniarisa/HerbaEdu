import 'package:flutter/material.dart';

class SarafHerb {
  final String name;
  final String imageUrl;
  final String description;
  final String youtubeUrl;
  bool isFavorite;

  SarafHerb({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.youtubeUrl,
    this.isFavorite = false,
  });
}
