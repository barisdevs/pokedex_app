import 'package:flutter/material.dart';
import 'services/pokemon_service.dart';

void main() {
  runApp(MyWidget());
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List pokemonlar = [];

  @override
  void initState() {
    super.initState();
    veriGetir();
  }

  void veriGetir() async {
    final data = await PokemonService().fetchPokemon();

    setState(() {
      pokemonlar = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Pokedex")),
        body: ListView.builder(
          itemCount: pokemonlar.length,
          itemBuilder: (context, index) {
            return Card(
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
                      pokemonlar[index]['image'],
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      pokemonlar[index]['name'].toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
