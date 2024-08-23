import 'dart:convert';

import 'package:http/http.dart' as http;

import '../screen/home/model/home_model.dart';

class APIHelper {
  static APIHelper apiHelper = APIHelper._();
  APIHelper._();
  Future<List<Song>?> getData() async {
    String link = "https://viditsavaliya19.github.io/JSON/music.json";
    var response = await http.get(
      Uri.parse(link),
    );
    if (response.statusCode == 200) {
      List json = jsonDecode(response.body);
      List<Song> homeModel = json.map((e) => Song.mapToModel(e)).toList();
      return homeModel;
    }
    return null;
  }
}
