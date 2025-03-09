import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/pokemon_provider.dart';
import 'screens/pokemon_list_screen.dart';

void main() {
  runApp(
    // ChangeNotifierProvider で PokemonProvider をアプリ全体に適用
    // MultiProvider を使うことで、今後他の Provider も追加しやすい
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PokemonProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokémon List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PokemonListScreen(),
    );
  }
}
