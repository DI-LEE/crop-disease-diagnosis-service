import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:install_test/Screen/Result_page.dart';
import 'package:install_test/ml_api/MlApi.dart';
import 'package:install_test/model/model.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';



class WeatherScreen extends StatefulWidget {
  WeatherScreen({this.parseWeatherData, this.parseAirPollution});
  final dynamic parseWeatherData;

  final dynamic parseAirPollution;

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late File _image;

  Future getImage(bool isCamera) async {
    File image;

    //카메라와 캘러리 열기
    if(isCamera){
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    //server로 이미지 업로드
    uploadImage(image, RequestUrl);

    setState(() {
      _image = File(image.path);
    });
  }


  Model model = Model();
  String? cityName;
  int? temp;
  int? mintemp;
  int? maxtemp;
  String? des;
  Widget? icon;
  Widget? pollution;
  Widget? quality;
  double? air;
  double? air2;
  var date = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateData(widget.parseWeatherData, widget.parseAirPollution);
  }

  void updateData(dynamic weatherData, dynamic airData) {
    double temp2 = weatherData['main']['temp'].toDouble();
    double mintemp2 = weatherData['main']['temp_min'].toDouble();
    double maxtemp2 = weatherData['main']['temp_max'].toDouble();
    temp = temp2.toInt();
    mintemp = mintemp2.toInt();
    maxtemp = maxtemp2.toInt();
    cityName = weatherData['name'];
    var condition = weatherData['weather'][0]['id'];
    var grade = airData['list'][0]['main']['aqi'];
    var index = airData['list'][0]['main']['aqi'];
    des = weatherData['weather'][0]['description'];
    icon = model.getWeatherIcon(condition);
    pollution = model.getAirIcon(grade);
    quality = model.airIndex(index);
    air = airData['list'][0]['components']['pm2_5'];
    air2 = airData['list'][0]['components']['pm10'];
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

  String getSystemTime() {
    var now = new DateTime.now();
    return new DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar를 body 뒤에 위치 시키기
      extendBodyBehindAppBar: true,
      // 상단표식
      appBar : AppBar(
        backgroundColor: Colors.transparent, // appbar 투명으로 만들기
        elevation: 0.0,
        centerTitle: true,
        // 오른쪽에 아이콘
        leading: IconButton(
          icon : Icon(
            Icons.near_me,
            size: 30.0,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        //왼쪽 아이콘
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(
              Icons.location_searching,
              size: 30.0,
              color: Colors.white,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImage(true);
        },
        child: Icon(
          CupertinoIcons.camera,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color(0xffE8F4EB),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: (){
                  getImage(false);
                },
                icon: Icon(CupertinoIcons.folder)),
            IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      ResultPage()));
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
                        // offset: Offset(
                        //   -5,
                        //   -5,
                        // ),
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
                  SizedBox(
                    height: 30,
                  ),
                  //온도 표시
                  Column(

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
                      //하단 아이콘 텍스트 위치 조절
                      SizedBox(
                        height: 105.0,
                      ),
                      // 하단 디자인
                      Column(
                        children: [
                          // 날씨 아이콘 온도 표시
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                SizedBox(
                                  width: 75,
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
                            height: 0,
                          ),
                          // VerticalDivider(
                          //   thickness: 2,
                          //   color: Colors.grey,
                          // ),
                          // 위험 질병 아이콘과 질병 표시
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 15, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                SizedBox(
                                  width: 110,
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

                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/warning.png',
                                  width: 40,
                                  height: 40,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                // SizedBox(
                                //   width: 150.0,
                                // ),
                                Text(
                                  '주의보',
                                  style: TextStyle(
                                    fontFamily: 'notosans',
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
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
                          // Row(
                          //   children: [
                          //     MaterialButton(
                          //         onPressed: (){
                          //           getImage(false);
                          //         },
                          //       color: Color(0xffB1CDBA),
                          //       textColor: Colors.white,
                          //       child: Icon(
                          //         Icons.camera_alt,
                          //         size: 24,
                          //       ),
                          //       padding:
                          //       EdgeInsets.all(20),
                          //       shape: CircleBorder(),
                          //     ),
                          //     ElevatedButton(
                          //       onPressed: (){
                          //         Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          //               ResultPage()));
                          //       },
                          //       child: Padding(
                          //         padding: const EdgeInsets.fromLTRB(50, 15, 50, 15),
                          //         child: Text(
                          //           '진단보러가기',
                          //           style: TextStyle(
                          //             fontSize: 24.0,
                          //             fontFamily: 'notosansb',
                          //             fontWeight: FontWeight.w700,
                          //           ),
                          //         ),
                          //       ),
                          //       style: ButtonStyle(
                          //           backgroundColor:
                          //           MaterialStateProperty.all(Color(0xffB1CDBA)),
                          //           shape:
                          //           MaterialStateProperty.all(RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(20.0),
                          //           ))
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          //누르면 Result_page로 이동
                          // ElevatedButton(onPressed: (){
                          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          //       ResultPage()));
                          // },
                          //     child: Text(
                          //       '검사페이지'
                          //     ),
                          // ),
                          // ElevatedButton(
                          //   onPressed: (){
                          //     getImage(false);
                          //   },
                          //   child: Padding(
                          //     padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
                          //     child: Text(
                          //       '진단하기',
                          //       style: TextStyle(
                          //         fontSize: 12.0,
                          //         fontFamily: 'notosansb',
                          //         fontWeight: FontWeight.w700,
                          //       ),
                          //     ),
                          //   ),
                          //   style: ButtonStyle(
                          //       backgroundColor:
                          //       MaterialStateProperty.all(Colors.green),
                          //       shape:
                          //       MaterialStateProperty.all(RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(40.0),
                          //       ))
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // return Scaffold(
    //   extendBodyBehindAppBar: true,
    //   appBar: AppBar(
    //     //title: Text('Weather app'),
    //     backgroundColor: Colors.transparent,
    //     elevation: 0.0,
    //     centerTitle: true,
    //     leading: IconButton(
    //       icon: Icon(
    //         Icons.near_me,
    //         size: 30.0,
    //         color: Colors.white,
    //       ),
    //       onPressed: () {},
    //     ),
    //     actions: [
    //       IconButton(
    //         icon: Icon(
    //           Icons.location_searching,
    //           size: 30.0,
    //           color: Colors.white,
    //         ),
    //         onPressed: () {},
    //       )
    //     ],
    //   ),
    //   body: Container(
    //       child: Stack(
    //     children: [
    //       Image.asset(
    //         'images/background.jpg',
    //         fit: BoxFit.cover,
    //         height: double.infinity,
    //         width: double.infinity,
    //       ),
    //       Container(
    //         padding: EdgeInsets.all(20.0),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Expanded(
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       SizedBox(
    //                         height: 150.0,
    //                       ),
    //                       Text(
    //                         '$cityName',
    //                         style: GoogleFonts.lato(
    //                             fontSize: 35.0,
    //                             fontWeight: FontWeight.bold,
    //                             color: Colors.white),
    //                       ),
    //                       SizedBox(
    //                         height: 10,
    //                       ),
    //                       Row(
    //                         children: [
    //                           TimerBuilder.periodic(Duration(minutes: 1),
    //                               builder: (context) {
    //                             print("${getSystemTime()}");
    //                             return Text(
    //                               "${getSystemTime()}",
    //                               style: GoogleFonts.lato(
    //                                   fontSize: 16.0,
    //                                   //fontWeight: FontWeight.bold,
    //                                   color: Colors.white),
    //                             );
    //                           }),
    //                           Text(
    //                             DateFormat('- EEEE,').format(date),
    //                             textAlign: TextAlign.left,
    //                             style: GoogleFonts.lato(
    //                                 fontSize: 16.0,
    //                                 //fontWeight: FontWeight.bold,
    //                                 color: Colors.white),
    //                           ),
    //                           Text(
    //                             DateFormat('d MMM, yyyy').format(date),
    //                             textAlign: TextAlign.left,
    //                             style: GoogleFonts.lato(
    //                                 fontSize: 16.0,
    //                                 //fontWeight: FontWeight.bold,
    //                                 color: Colors.white),
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(
    //                         '$temp\u2103',
    //                         style: GoogleFonts.lato(
    //                             fontSize: 85.0,
    //                             fontWeight: FontWeight.w300,
    //                             color: Colors.white),
    //                       ),
    //                       Row(
    //                         children: [
    //                           icon!,
    //                           SizedBox(
    //                             width: 10,
    //                           ),
    //                           Text(
    //                             '$des',
    //                             style: GoogleFonts.lato(
    //                                 fontSize: 15.0,
    //                                 //fontWeight: FontWeight.bold,
    //                                 color: Colors.white),
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   )
    //                 ],
    //               ),
    //             ),
    //             Column(
    //               children: [
    //                 Container(
    //                   margin: EdgeInsets.symmetric(vertical: 40.0),
    //                   decoration: BoxDecoration(
    //                       border: Border.all(color: Colors.white30)),
    //                 ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Column(
    //                       children: [
    //                         Text(
    //                           'AQI(대기질 지수)',
    //                           style: GoogleFonts.lato(
    //                               fontSize: 14.0,
    //                               fontWeight: FontWeight.bold,
    //                               color: Colors.white),
    //                         ),
    //                         SizedBox(
    //                           height: 10.0,
    //                         ),
    //                         pollution!,
    //                         SizedBox(
    //                           height: 5.0,
    //                         ),
    //                         quality!,
    //                         // Text(
    //                         //   '$air',
    //                         //   style: GoogleFonts.lato(
    //                         //       fontSize: 24.0,
    //                         //       fontWeight: FontWeight.bold,
    //                         //       color: Colors.white),
    //                         // ),
    //                         // Text(
    //                         //   '㎍/m3',
    //                         //   style: GoogleFonts.lato(
    //                         //       fontSize: 14.0,
    //                         //       fontWeight: FontWeight.bold,
    //                         //       color: Colors.white),
    //                         // ),
    //                       ],
    //                     ),
    //                     Column(
    //                       children: [
    //                         Text(
    //                           '미세먼지',
    //                           style: GoogleFonts.lato(
    //                               fontSize: 14.0,
    //                               fontWeight: FontWeight.bold,
    //                               color: Colors.white),
    //                         ),
    //                         SizedBox(
    //                           height: 10.0,
    //                         ),
    //                         Text(
    //                           '$air2',
    //                           style: GoogleFonts.lato(
    //                               fontSize: 24.0,
    //                               fontWeight: FontWeight.bold,
    //                               color: Colors.white),
    //                         ),
    //                         Text(
    //                           '㎍/m3',
    //                           style: GoogleFonts.lato(
    //                               fontSize: 14.0,
    //                               fontWeight: FontWeight.bold,
    //                               color: Colors.white),
    //                         ),
    //                       ],
    //                     ),
    //                     Column(
    //                       children: [
    //                         Text(
    //                           '초미세먼지',
    //                           style: GoogleFonts.lato(
    //                               fontSize: 14.0,
    //                               fontWeight: FontWeight.bold,
    //                               color: Colors.white),
    //                         ),
    //                         SizedBox(
    //                           height: 10,
    //                         ),
    //                         Text(
    //                           '$air',
    //                           style: GoogleFonts.lato(
    //                               fontSize: 24.0,
    //                               fontWeight: FontWeight.bold,
    //                               color: Colors.white),
    //                         ),
    //                         Text(
    //                           '㎍/m3',
    //                           style: GoogleFonts.lato(
    //                               fontSize: 14.0,
    //                               fontWeight: FontWeight.bold,
    //                               color: Colors.white),
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 )
    //               ],
    //             )
    //           ],
    //         ),
    //       ),
    //     ],
    //   )),
    // );
  }
}
