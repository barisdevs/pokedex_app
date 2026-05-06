import 'package:flutter/material.dart';
import 'models/pokemon_list_item.dart';
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
  List<PokemonListItem> pokemonlar = [];

  bool isLoading = true;
  String? errorMessage;

  final int limit = 21;
  int offset = 0;
  int currentPage = 1;
  int totalCount = 0;

  @override
  void initState() {
    super.initState();
    loadPokemonList();
  }

  void loadPokemonList() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });
      await Future.delayed(const Duration(milliseconds: 700));

      final page = await PokemonService().fetchPokemonPage(
        limit: limit,
        offset: offset,
      );

      setState(() {
        pokemonlar = page.pokemons;
        totalCount = page.count;
        isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());

      setState(() {
        errorMessage = "Pokemonlar yüklenirken bir hata oluştu";
        isLoading = false;
      });
    }
  }

  void nextPage() {
    if (offset + limit < totalCount) {
      setState(() {
        offset += limit;
        currentPage++;
      });

      loadPokemonList();
    }
  }

  void previousPage() {
    if (offset > 0) {
      setState(() {
        offset -= limit;
        currentPage--;
      });

      loadPokemonList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final int totalPage = totalCount == 0 ? 1 : (totalCount / limit).ceil();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/images/appbar.png', height: 45),
      ),
      body: isLoading
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text("Pokemonlar yükleniyor..."),
                ],
              ),
            )
          : errorMessage != null
          ? Center(child: Text(errorMessage!))
          : Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.85,
                        ),
                    itemCount: pokemonlar.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PokemonDetailPage(
                                pokemonName: pokemonlar[index].name,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  pokemonlar[index].image,
                                  width: 65,
                                  height: 65,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  pokemonlar[index].name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
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
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: offset > 0 ? previousPage : null,
                        child: const Text("Previous"),
                      ),
                      Text(
                        "Sayfa $currentPage / $totalPage",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: offset + limit < totalCount
                            ? nextPage
                            : null,
                        child: const Text("Next"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
