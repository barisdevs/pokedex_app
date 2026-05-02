import 'package:flutter/material.dart';
import 'models/pokemon.dart';
import 'services/pokemon_service.dart';
import 'screens/pokemon_detail_page.dart';

void main() {
  runApp(const PokedexApp());
}

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PokemonListPage(),
    );
  }
}

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  List<Pokemon> pokemonlar = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadPokemonList();
  }

  void loadPokemonList() async {
    try {
      final data = await PokemonService().fetchPokemon();

      setState(() {
        pokemonlar = data;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        errorMessage = "Bir hata oluştu";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pokedex")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(child: Text(errorMessage!))
          : ListView.builder(
              itemCount: pokemonlar.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PokemonDetailPage(pokemon: pokemonlar[index]),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(12),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Image.network(
                            pokemonlar[index].image,
                            width: 80,
                            height: 80,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            pokemonlar[index].name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
