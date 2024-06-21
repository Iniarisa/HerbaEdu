import 'package:flutter/material.dart';

class TulangSendiHerb {
  final String name;
  final String imageUrl;
  final String description;
  final String youtubeUrl;
  bool isFavorite;

  TulangSendiHerb({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.youtubeUrl,
    this.isFavorite = false,
  });
}
