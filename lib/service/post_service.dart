import 'dart:convert';

import 'package:blogcom/models/postmodel.dart';
import 'package:http/http.dart' as http;

class PostService {
  final String URL = "https://dummyjson.com/posts";

  Future<Postmodel?> fetchPosts() async {
    var response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      return Postmodel.fromMap(jsonDecode(response.body));
    } else {
      print("Failed to load posts. Status code: ${response.statusCode}");
      return null;
    }
  }
}
