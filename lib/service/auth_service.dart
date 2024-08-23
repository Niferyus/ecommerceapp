import 'dart:convert';
import 'dart:io';

// byyarim@gmail.com

import 'package:blogcom/models/usermodel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String URL = "https://dummyjson.com/auth/login";
  final String tokenURL = "https://dummyjson.com/user/me";

  Future<bool> loginUser(String username, String password) async {
    var response = await http.post(Uri.parse(URL),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'username': username, 'password': password, 'expiresInMins': 30}));
    if (response.statusCode == 200) {
      print("200 başarılı");
      final data = jsonDecode(response.body);
      final token = data['token'];
      final refreshToken = data['refreshToken'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('refreshtoken', refreshToken);

      return true;
    } else
      print(response.statusCode);
    print("başarısızz istekk");
    return false;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('refreshtoken');
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<User?> getProfileInfos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("profil bilgileri geliyor");
    var response = await http.get(
      Uri.parse(tokenURL),
      headers: {
        'Authorization': 'Bearer ' + prefs.getString('token').toString()
      },
    );
    if (response.statusCode == 200) {
      print("başarılı istekk ${response.body}");
      return User.fromMap(jsonDecode(response.body));
    } else {
      print("başarısız istek" + response.statusCode.toString());
      return null;
    }
  }
}
