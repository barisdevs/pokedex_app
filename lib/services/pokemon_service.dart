import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex_app/models/pokemon_page.dart';
import 'package:pokedex_app/models/pokemon_detail.dart';
import 'package:pokedex_app/models/pokemon_list_item.dart';

class PokemonService {
  Future<PokemonPage> fetchPokemonPage({
    required int limit,
    required int offset,
  }) async {
    final response = await http.get(
      Uri.parse(
        "https://pokeapi.co/api/v2/pokemon?limit=$limit&offset=$offset",
      ),
    );

    if (response.statusCode != 200) {
      throw Exception("Pokemon listesi alınamadı");
    }

    final data = json.decode(response.body);

    final futures = (data['results'] as List).map<Future<PokemonListItem>>((
      item,
    ) async {
      final detailResponse = await http.get(Uri.parse(item['url']));

      if (detailResponse.statusCode != 200) {
        throw Exception("Pokemon detayı alınamadı");
      }

      final detailData = json.decode(detailResponse.body);
      return PokemonListItem.fromJson(detailData);
    }).toList();

    final List<PokemonListItem> pokemons = await Future.wait(futures);

    return PokemonPage(count: data['count'], pokemons: pokemons);
  }

  Future<PokemonDetail> fetchPokemonDetail(String name) async {
    final response = await http.get(
      Uri.parse("https://pokeapi.co/api/v2/pokemon/$name"),
    );

    if (response.statusCode != 200) {
      throw Exception("Pokemon detayi alinamadi");
    }

    final data = json.decode(response.body);

    return PokemonDetail.fromJson(data);
  }
}
