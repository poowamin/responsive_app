class Pokemon {
  final String name;
  final String imageUrl;
  final int weight;
  final List<String> types;

  Pokemon({
    required this.name,
    required this.imageUrl,
    required this.weight,
    required this.types,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final types = json['types'] as List<dynamic>;
    final typeNames =
        types.map((type) => type['type']['name'] as String).toList();
    return Pokemon(
        name: json['name'],
        imageUrl: json['sprites']['front_default'],
        weight: json['weight'],
        types: typeNames,);
  }
}
