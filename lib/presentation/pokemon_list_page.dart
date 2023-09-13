// โจทย์ สร้าง Application ที่มี Responsive เป็นองค์ประกรอบ และใช้ Libary Dio สำหรับดึงข้อมูลจาก API //

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:responsive_app/models/pokemon.dart';
import 'package:responsive_app/presentation/pokemon_detail.dart';
import 'package:responsive_app/service/pokemon_service.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  final _pokemonService = PokemonService();
  final int _pokemonLimit = 6;
  List<Pokemon> _pokemonList = [];
  int _crossAxisCount = 2;

  void _fetchPokemonList() async {
    setState(() {
      _pokemonList = [];
    });

    try {
      final pokemonList = await _pokemonService.fetchPokemonList(_pokemonLimit);
      setState(() {
        _pokemonList = pokemonList;
      });
    } catch (error) {
      log('Error fetching Pokemon list: $error');
    }
  }

  int _calculateCrossAxisCount(BuildContext context) {
    // Calculate the screen orientation and adjust the number of columns accordingly
    final orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.landscape) {
      return 6; // 4 columns in landscape mode
    } else {
      return 3; // 3 columns in portrait mode
    }
  }

  void _showPokemonDetailPopup(Pokemon pokemon) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PokemonDetailPopup(pokemon: pokemon);
      },
    );
  }

  @override
  void initState() {
    _fetchPokemonList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _crossAxisCount = _calculateCrossAxisCount(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _pokemonList.isNotEmpty
                ? Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        _crossAxisCount = (constraints.maxWidth / 150).floor();
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: _crossAxisCount,
                          ),
                          itemCount: _pokemonList.length,
                          itemBuilder: (context, index) {
                            final pokemon = _pokemonList[index];
                            return GestureDetector(
                              onTap: () => _showPokemonDetailPopup(pokemon),
                              child: Card(
                                borderOnForeground: true,
                                elevation: 3,
                                child: Column(
                                  children: [
                                    Image.network(
                                      fit: BoxFit.cover,
                                      pokemon.imageUrl,
                                      height: 130,
                                    ),
                                    Text(
                                      'Name: ${pokemon.name}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                : const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
