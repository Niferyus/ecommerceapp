import 'dart:convert';
import 'package:blogcom/models/productmodel.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final String URL = "https://dummyjson.com/products";

  Future<Productmodel?> fetchProducts() async {
    var response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      print("başarılı");
      return Productmodel.fromMap(jsonDecode(response.body));
    } else {
      print("başarısız");
      return null;
    }
  }
}