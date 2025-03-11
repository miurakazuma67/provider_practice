import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pokemon_provider.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<PokemonProvider>(context, listen: false)
        .fetchPokemonList());
  }

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ポケモン一覧'),
      ),
      body: pokemonProvider.pokemonList.isEmpty
          ? const Center(child: CircularProgressIndicator()) // ローディング中
          : ListView.builder(
              itemCount: pokemonProvider.pokemonList.length,
              itemBuilder: (context, index) {
                final pokemon = pokemonProvider.pokemonList[index];

                return ListTile(
                  leading: Image.network(
                    pokemon['imageUrl'] ?? '',
                    width: 50,
                    height: 50,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image_not_supported),
                  ),
                  title: Text(pokemon['name'] ?? ''),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PokemonDetailScreen(
                          name: pokemon['name']!,
                          imageUrl: pokemon['imageUrl']!,
                          types: pokemon['types'] ?? [], // ポケモンのタイプ情報を渡す
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
