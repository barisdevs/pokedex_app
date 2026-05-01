import 'dart:convert';
import 'package:http/http.dart' as http;

class PokemonService {
  Future fetchPokemon() async {
    final response = await http.get(
      Uri.parse("https://pokeapi.co/api/v2/pokemon"),
    );
    final data = json.decode(response.body);
    List pokemonList = [];
    for (var item in data['results']) {
      final detailResponse = await http.get(Uri.parse(item['url']));
      final detailData = json.decode(detailResponse.body);

      pokemonList.add({
        'name': item['name'],
        'image': detailData['sprites']['front_default'],
      });
    }
    return pokemonList;
  }
}
