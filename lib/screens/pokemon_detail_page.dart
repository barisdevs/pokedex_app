import 'package:flutter/material.dart';
import '../models/pokemon_detail.dart';
import '../services/pokemon_service.dart';

class PokemonDetailPage extends StatefulWidget {
  final String pokemonName;

  const PokemonDetailPage({super.key, required this.pokemonName});

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  PokemonDetail? pokemonDetail;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadPokemonDetail();
  }

  void loadPokemonDetail() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final detail = await PokemonService().fetchPokemonDetail(
        widget.pokemonName,
      );

      setState(() {
        pokemonDetail = detail;
        isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());

      setState(() {
        errorMessage = "Pokemon detayı yüklenirken bir hata oluştu";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.pokemonName)),
        body: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 12),
              Text("Pokemon detayı yükleniyor..."),
            ],
          ),
        ),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.pokemonName)),
        body: Center(child: Text(errorMessage!)),
      );
    }

    if (pokemonDetail == null) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.pokemonName)),
        body: const Center(child: Text("Pokemon detayı bulunamadı.")),
      );
    }

    final pokemon = pokemonDetail!;

    return Scaffold(
      appBar: AppBar(title: Text(pokemon.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "#${pokemon.id} ${pokemon.name.toUpperCase()}",
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                Image.network(pokemon.image, width: 170, height: 170),

                const SizedBox(height: 20),

                Text("Height: ${pokemon.height}"),
                Text("Weight: ${pokemon.weight}"),

                const SizedBox(height: 20),

                const Text(
                  "Types",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(pokemon.types.join(", ")),

                const SizedBox(height: 20),

                const Text(
                  "Abilities",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(pokemon.abilities.join(", ")),

                const SizedBox(height: 20),

                const Text(
                  "Stats",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                ...pokemon.stats.map(
                  (stat) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(stat.name),
                        Text(
                          stat.value.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
