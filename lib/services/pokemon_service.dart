import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex_app/models/pokemon.dart';

class PokemonService {
  Future<List<Pokemon>> fetchPokemon() async {
    final response = await http.get(
      Uri.parse("https://pokeapi.co/api/v2/pokemon"),
    );

    if (response.statusCode != 200) {
      throw Exception("API hatası");
    }

    final data = json.decode(response.body);

    final futures = (data['results'] as List).map<Future<Pokemon>>((
      item,
    ) async {
      final response = await http.get(Uri.parse(item['url']));

      if (response.statusCode != 200) {
        throw Exception("Detay API hatası");
      }

      final detailData = json.decode(response.body);
      return Pokemon.fromJson(detailData);
    }).toList();

    final List<Pokemon> pokemonList = await Future.wait(futures);

    return pokemonList;
  }
}
