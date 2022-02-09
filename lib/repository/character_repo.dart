import 'dart:convert';
import 'package:http/http.dart' as http;

class CharacterRepo {
  Future<List> getCharacter(int page) async {
    final response =
        await http.get(Uri.parse('https://rickandmortyapi.com/api/character?page=$page'));
    if (response.statusCode == 200) {
    Map data = jsonDecode(response.body);
    List result = data["results"];
      return result;
    }else{
      throw Exception('Error');
    }
  }
}