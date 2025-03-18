import 'package:flutter/material.dart';

class PokemonDetailScreen extends StatelessWidget {
  final String name;
  final String imageUrl;
  final List<String> types;

  const PokemonDetailScreen({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.types,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(imageUrl, width: 150, height: 150),
            const SizedBox(height: 20),
            Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: types.map((type) {
                return Chip(
                  label: Text(type, style: const TextStyle(color: Colors.white)), // タイプ名
                  backgroundColor: _getTypeColor(type), // タイプごとの色を設定
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // タイプごとに色を設定（適宜追加可能）
  Color _getTypeColor(String type) {
    switch (type) {
      case 'ほのお': return Colors.red;
      case 'みず': return Colors.blue;
      case 'くさ': return Colors.green;
      case 'でんき': return Colors.yellow.shade700;
      default: return Colors.grey;
    }
  }
}
