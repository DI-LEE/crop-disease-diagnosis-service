import 'dart:io';
import 'dart:convert';

//requset용 package
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

String RequestUrl = "http://54.241.195.149:5000/api"; //request할 server URL

//get 함수
Future getData(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  var parsingData = jsonDecode(response.body); // get해온 데이터 json 형식으로 변경
  return parsingData;
}

//uploadImage 함수
uploadImage(File imageFile, String url) async {
  String base64Imgae = base64Encode(imageFile.readAsBytesSync()); // image file을 base64로 인코딩
  Response response = await Dio().post(
      url, //post할 url
      data : base64Imgae // upload할 파일
  );
  print(response);
}