import 'package:flutter/material.dart';
import 'package:install_test/Screen/weather_screen.dart';
import 'package:install_test/data/my_location.dart';
import 'package:install_test/data/network.dart';
const apiKey = '0d0cc1131b44cd6ea0027e60e69dc007';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  double? latitude3;
  double? longitude3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  void getLocation() async{
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;
    print(latitude3);
    print(longitude3);

    Network network = Network('https://api.openweathermap.org/data/2.5/weather'
        '?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric',
        'https://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longitude3&appid=$apiKey');

    var weatherData = await network.getJsonData();
    print(weatherData);

    var airData = await network.getAirData();
    print(airData);

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return WeatherScreen(parseWeatherData: weatherData,parseAirPollution: airData,);
    }));
  }

  // void fetchData() async{
  //
  //     var myJson = parsingData['weather'][0]['description'];
  //     print(myJson);
  //
  //     var wind = parsingData['wind']['speed'];
  //     print(wind);
  //
  //     var id =parsingData['id'];
  //     print(id);
  //   }else{
  //     print(response.statusCode);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              //배경설정
              Image.asset(
                'assets/images/Appbackground.jpg',
                //배경이미지 전체크기로 맞추기
                fit : BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20,0,0,0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 350.0,
                      ),
                      Text(
                        '누구나 할 수 있는',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontFamily: 'notosans',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '병해중 진단 서비스.',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontFamily: 'notosans',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '당신의 농작물을 지켜주세요.',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontFamily: 'notosans',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
    // return Scaffold(
    //   body: Center(
    //     child: RaisedButton(
    //       onPressed: null,
    //       child: Text(
    //         'Get my location',
    //         style: TextStyle(
    //             color: Colors.white
    //         ),
    //       ),
    //       color: Colors.blue,
    //     ),
    //   ),
    // );
  }
}
