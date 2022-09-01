import 'package:geolocator/geolocator.dart';

class MyLocation{
  //내 위도 경도 받아오기
  double? latitude2;
  double? longitude2;

  Future<void> getMyCurrentLocation() async{
    try {
      Position position =  await Geolocator.
      getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitude2 = position.latitude;
      longitude2 = position.longitude;
    }catch(e){
      print('There was a problem with the internet connection.');
    }
  }
}