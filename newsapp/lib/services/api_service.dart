import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class ApiService {
  static const String url = 'https://jsonplaceholder.typicode.com/posts';

  static Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => Article.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }
}