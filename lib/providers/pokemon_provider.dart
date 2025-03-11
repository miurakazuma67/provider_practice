import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonProvider with ChangeNotifier {
  List<Map<String, String>> _pokemonList = [];

  List<Map<String, String>> get pokemonList => _pokemonList;

  Future<void> fetchPokemonList() async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=20');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Map<String, String>> pokemonData = [];

      for (var pokemon in data['results']) {
        final speciesUrl = pokemon['url']; // 各ポケモンの詳細URL
        final speciesResponse = await http.get(Uri.parse(speciesUrl));

        if (speciesResponse.statusCode == 200) {
          final speciesData = json.decode(speciesResponse.body);
          final imageUrl = speciesData['sprites']['front_default']; // 画像URL
          final speciesDetailUrl = speciesData['species']['url']; // 種の詳細URL

          final detailResponse = await http.get(Uri.parse(speciesDetailUrl));
          if (detailResponse.statusCode == 200) {
            final detailData = json.decode(detailResponse.body);
            final jpName = detailData['names']
                .firstWhere((name) => name['language']['name'] == 'ja')['name'];
            pokemonData.add({
              'name': jpName,
              'imageUrl': imageUrl,
            });
          } else {
            pokemonData.add({
              'name': pokemon['name'],
              'imageUrl': imageUrl,
            });
          }
        }
      }

      _pokemonList = pokemonData;
      notifyListeners();
    } else {
      throw Exception('ポケモンリストの取得に失敗しました');
    }
  }
}
