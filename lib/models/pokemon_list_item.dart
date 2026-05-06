class PokemonListItem {
  final String name;
  final String image;

  PokemonListItem({required this.name, required this.image});

  factory PokemonListItem.fromJson(Map<String, dynamic> json) {
    return PokemonListItem(
      name: json['name'],
      image: json['sprites']['front_default'],
    );
  }
}
