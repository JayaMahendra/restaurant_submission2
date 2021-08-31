import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sub2/data/model/restaurant.dart';

class ApiService {
  static final String _apiKey = 'https://restaurant-api.dicoding.dev/';

  Future<Welcome> topHeadlines() async {
    final response = await http.get(Uri.parse(_apiKey + 'list'));
    if (response.statusCode == 200) {
      return Welcome.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
