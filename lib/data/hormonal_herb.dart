class HormonalHerb {
  final String name;
  final String imageUrl;
  final String description;
  final String youtubeUrl;
  bool isFavorite;

  HormonalHerb({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.youtubeUrl,
    this.isFavorite = false,
  });

  // Method to convert HormonalHerb to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'youtubeUrl': youtubeUrl,
      'isFavorite': isFavorite,
    };
  }

  // Method to create HormonalHerb from a Map
  factory HormonalHerb.fromMap(Map<String, dynamic> map) {
    return HormonalHerb(
      name: map['name'],
      imageUrl: map['imageUrl'],
      description: map['description'],
      youtubeUrl: map['youtubeUrl'],
      isFavorite: map['isFavorite'] ?? false,
    );
  }
}
