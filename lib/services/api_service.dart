import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<String> fetchData(int limit, String tags, int page) async {
    String baseUrl = "safebooru.org";

    final url = Uri.parse(
        'https://$baseUrl?page=dapi&s=post&q=index&limit=$limit&tags=$tags&pid=$page');

    final response = await http.get(url);

    debugPrint(url.toString());

    if (response.statusCode == 200) {
      return response.body;
    } else {
      debugPrint('Ошибка: ${response.statusCode}');
      return 'Ошибка: ${response.statusCode}';
    }
  }
}
