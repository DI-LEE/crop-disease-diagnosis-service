import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

import '../ml_api/MlApi.dart';
import '../model/model.dart';
import 'Splash_page.dart';





class WeatherScreen extends StatefulWidget {
  // , this.parseAirPollution
  WeatherScreen({this.parseWeatherData});
  final dynamic parseWeatherData;

  // final dynamic parseAirPollution;

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  File? _image;
  //imagepicker pakage 변수 저장
  final picker = ImagePicker();

  //카메라 and 갤러리 열기
  Future getImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);
    final File? file = File(image!.path);

    //server로 이미지 업로드
    uploadImage(file!, RequestUrl);

    setState(() {
      _image = File(image.path);
    });
  }

  //변수 선언
  Model model = Model();
  String? cityName;
  int? temp;
  int? mintemp;
  int? maxtemp;
  String? des;
  Widget? icon;
  var date = DateTime.now();

  @override
  //페이가 시작되면 parsing 된 json파일이 update
  void initState() {
    // TODO: implement initState
    super.initState();
    updateData(widget.parseWeatherData);
  }
  //json data를 변수에 저장
  void updateData(dynamic weatherData) {
    double temp2 = weatherData['main']['temp'].toDouble();
    double mintemp2 = weatherData['main']['temp_min'].toDouble();
    double maxtemp2 = weatherData['main']['temp_max'].toDouble();
    temp = temp2.toInt();
    mintemp = mintemp2.toInt();
    maxtemp = maxtemp2.toInt();
    cityName = weatherData['name'];
    var condition = weatherData['weather'][0]['id'];
    des = weatherData['weather'][0]['description'];
    icon = model.getWeatherIcon(condition);
    if (des == 'broken clouds') {
      des = '구름많음';
    } else if (des == 'few clouds') {
      des = '구름조금';
    } else if (des == 'clear sky') {
      des = '날씨맑음';
    } else if (des == 'overcast clouds') {
      des = '구름많음';
    } else if (des == 'few clouds') {
      des = '구름조금';
    } else if (des == 'scattered clouds') {
      des = '흐림';
    } else if (des == 'shower rain') {
      des = '소나기';
    } else if (des == 'rain') {
      des = '비';
    } else if (des == 'thunderstorm') {
      des = '천둥';
    } else if (des == 'mist') {
      des = '안개';
    } else if (des == 'snow') {
      des = '눈';
    } else if (des == 'smoke') {
      des = '구름조금';
    } else if (des == 'moderate rain') {
      des = '약한비';
    }
  }

  //시간 클래스 선언
  String getSystemTime() {
    var now = new DateTime.now();
    return new DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //카메라 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImage(ImageSource.camera);
        },
        child: Icon(
          CupertinoIcons.camera,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),

      //하단 버튼 디자인
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color(0xffE8F4EB),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: (){
                  getImage(ImageSource.gallery); // 갤러리 버튼
                },
                icon: Icon(CupertinoIcons.folder)),
            IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      SplashScreen()));
                },
                icon: Icon(Icons.arrow_forward)),
          ],
        ),
      ),
      body : Container(
        //이미지 겹치기
        child: Stack(
          children: [
            //배경이미지 적용
            Image.asset(
              'assets/images/greenbackground2.jpg',
              //배경이미지 전체크기로 맞추기
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            //하단 박스 크기 조절
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 300.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),// 박스 라운드 조절
                    color: Color(0xffF6F7FC),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                        spreadRadius: 0.1,
                        blurRadius: 15,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  //상단 부분 디자인
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50.0,
                      ),
                      Text(
                        '$cityName',
                        style: TextStyle(
                            fontFamily: 'notosans',
                            fontSize: 30.0,
                            color : Colors.white
                        ),
                      ),

                      //현재시간표시 디자인 Row로 표시
                      Row(
                        children: [
                          // 1분마다 갱신
                          TimerBuilder.periodic(
                              Duration(minutes: 1),
                              builder: (context){
                                //print('${getSystemTime()}');
                                return Text(
                                  '${getSystemTime()}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'notosans',
                                    color : Colors.white,
                                  ),
                                );
                              }
                          ),
                          //날자 표시
                          Text(
                            DateFormat('- EEEE').format(date),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'notosans',
                                color : Colors.white
                            ),
                          ),
                          Text(
                            DateFormat('d MMM, yyyy').format(date),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'notosans',
                                color : Colors.white
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                  //온도 표시
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '$temp\u2103',
                        style: TextStyle(
                            fontFamily: 'notosans',
                            fontSize: 100.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // // 하단 디자인
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 100),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // 날씨 아이콘 온도 표시
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              icon!,
                              SizedBox(
                                width: 3,
                              ),
                              // SizedBox(
                              //   width: 150.0,
                              // ),
                              Text(
                                '$des',
                                style: TextStyle(
                                  fontFamily: 'notosans',
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '$mintemp\u2103/$maxtemp\u2103',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1.0,
                      color: Colors.black26,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // 위험 질병 아이콘과 질병 표시
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 40, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/warning.png',
                                width: 40,
                                height: 40,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '주의보',
                                style: TextStyle(
                                  fontFamily: 'notosans',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '잎마름병',
                            style: TextStyle(
                              fontFamily: 'notosans',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      thickness: 1.0,
                      color: Colors.black26,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 40, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/warning.png',
                                width: 40,
                                height: 40,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '주의보',
                                style: TextStyle(
                                  fontFamily: 'notosans',
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '탄저병',
                            style: TextStyle(
                              fontFamily: 'notosans',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
