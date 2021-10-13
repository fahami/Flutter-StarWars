import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:starwars/models/people.dart';
import 'package:starwars/models/peoples.dart';

class ApiService {
  static final String _baseUrl = 'https://swapi.dev/api/people';

  Future<Peoples> fetchPeoples() async {
    final response = await http.get(Uri.parse('$_baseUrl'));
    return response.statusCode == 200
        ? Peoples.fromJson(jsonDecode(response.body))
        : throw Exception('Failed to load list of poeples');
  }

  Future<People> fetchDetails(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));
    return response.statusCode == 200
        ? People.fromJson(jsonDecode(response.body))
        : throw Exception('Failed to load detail of people');
  }
}
