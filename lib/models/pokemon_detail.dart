class PokemonDetail {
  final int id;
  final String name;
  final String image;
  final int height;
  final int weight;
  final List<String> types;
  final List<String> abilities;
  final List<PokemonStat> stats;

  PokemonDetail({
    required this.id,
    required this.name,
    required this.image,
    required this.height,
    required this.weight,
    required this.types,
    required this.abilities,
    required this.stats,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
      id: json['id'],
      name: json['name'],
      image: json['sprites']['front_default'] ?? '',
      height: json['height'],
      weight: json['weight'],
      types: (json['types'] as List)
          .map((item) => item['type']['name'].toString())
          .toList(),
      abilities: (json['abilities'] as List)
          .map((item) => item['ability']['name'].toString())
          .toList(),
      stats: (json['stats'] as List)
          .map((item) => PokemonStat.fromJson(item))
          .toList(),
    );
  }
}

class PokemonStat {
  final String name;
  final int value;

  PokemonStat({required this.name, required this.value});

  factory PokemonStat.fromJson(Map<String, dynamic> json) {
    return PokemonStat(name: json['stat']['name'], value: json['base_stat']);
  }
}
