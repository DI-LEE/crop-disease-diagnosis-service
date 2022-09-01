import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

class Network{
  //날씨 json data 받아오기
  final String url;
  Network(this.url);

  Future<dynamic> getJsonData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }
}