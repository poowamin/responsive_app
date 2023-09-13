import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:responsive_app/models/pokemon.dart';

class PokemonService {
  final Dio _dio = Dio();

  PokemonService() {
    _dio.interceptors
        .add(PrettyDioLogger(responseHeader: true, requestBody: true));
  }

  Future<List<Pokemon>> fetchPokemonList(int limit) async {
    try {
      final response =
          await _dio.get('https://pokeapi.co/api/v2/pokemon?limit=$limit');
      final List<dynamic> results = response.data['results'];
      List<Pokemon> pokemonList = [];

      for (var item in results) {
        final pokemon = await fetchPokemonDetails(item['name']);
        pokemonList.add(pokemon);
      }

      return pokemonList;
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }

  Future<Pokemon> fetchPokemonDetails(String name) async {
    try {
      final response =
          await _dio.get('https://pokeapi.co/api/v2/pokemon/$name');
      return Pokemon.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }
}
