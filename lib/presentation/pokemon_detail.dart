import 'package:flutter/material.dart';
import 'package:responsive_app/models/pokemon.dart';

class PokemonDetailPopup extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailPopup({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pokemon Details'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.network(
              pokemon.imageUrl,
              height: 100,
              fit: BoxFit.cover,
            ),
            Text(
              'Name: ${pokemon.name}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Types: ${pokemon.types.join(", ")}', // Display types
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Weight: ${pokemon.weight} kg', // Display weight
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            // Add more Pokemon details here
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
