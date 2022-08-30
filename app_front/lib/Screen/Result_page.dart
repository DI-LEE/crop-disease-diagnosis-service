import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:install_test/ml_api/MlApi.dart';
import 'package:install_test/solution_page/Bacillus.dart';
import 'package:install_test/solution_page/Black_rot.dart';
import 'package:install_test/solution_page/Downy_mildew.dart';
import 'package:install_test/solution_page/Leaf_blight.dart';
import 'package:install_test/solution_page/Leaf_mold.dart';
import 'package:install_test/solution_page/Leaf_spot.dart';
import 'package:install_test/solution_page/powdery.dart';
import 'package:intl/intl.dart';

import 'loading.dart';

class ResultPage extends StatefulWidget {
  //const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String caption = '진단중입니다........';
  var data;
  var _obImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCaption();
    getObjimage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            //object detection display 화면
            Container(
              child: displayImage(_obImage),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 300.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                        spreadRadius: 0.1,
                        blurRadius: 15,
                        offset: Offset(
                          -5,
                          -5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //하단 진단 내용 디자인
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 485.0, // 텍스트 위치 조절
                        ),
                        Text(
                          '진단내용',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontFamily: 'notosans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Container(
                      height: 100,
                      width: 350,
                      padding: EdgeInsets.all(5),
                      child: Text(
                        caption,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'notosans',
                          fontWeight: FontWeight.w300,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Row(
                      children: [
                        MaterialButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Loading()));
                          },
                          color: Color(0xffA3BCAB),
                          textColor: Colors.white,
                          child: Icon(
                            Icons.arrow_back,
                            size: 24,
                          ),
                          padding:
                          EdgeInsets.all(15),
                          shape: CircleBorder(),
                        ),
                        ElevatedButton(
                          onPressed: (){
                            if(caption.contains('탄저병')){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  Bacillus()));
                            } else if (caption.contains('흰가루')){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  Powdery()));
                            } else if (caption.contains('검은무늬병')){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  BlackRot()));
                            } else if (caption.contains('노균병')){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  DownyMildew()));
                            } else if (caption.contains('잎마름병')){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  LeafBlight()));
                            } else if (caption.contains('잎곰팡이병')){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  LeafMold()));
                            } else if (caption.contains('점무늬병')){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  LeafSpot()));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(60, 15, 60, 15),
                            child: Text(
                              '상세보기',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontFamily: 'notosans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Color(0xff20A24F)),
                              shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ))
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Expanded(
                  //       child: Padding(
                  //         padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  //         child: ElevatedButton(
                  //           onPressed: (){
                  //             //'여기다 if문 사용해서 페이지 매칭시키기'
                  //             if(caption.contains('고추탄저병')){
                  //               Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  //               page1()));
                  //             }
                  //           },
                  //           child: Text(
                  //             '솔루션 페이지로 이동',
                  //             style: TextStyle(
                  //               fontSize: 24.0,
                  //               fontFamily: 'notosansb',
                  //               fontWeight: FontWeight.w700,
                  //             ),
                  //           ),
                  //           style: ButtonStyle(
                  //               backgroundColor:
                  //               MaterialStateProperty.all(Colors.green),
                  //               shape:
                  //               MaterialStateProperty.all(RoundedRectangleBorder(
                  //                 borderRadius: BorderRadius.circular(40.0),
                  //               ))
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future getCaption() async{
    data=await getData(RequestUrl);
    setState(() {
      caption = data['captions'];
    });
  }

  Future getObjimage() async{
    data = await getData(RequestUrl);
    String obimage = data['detections'];
    print(obimage);
    // var decoImage = base64.decode(obImage);
    Uint8List obImage = base64Decode(obimage);
    // Io.File obImage = Io.File.fromRawPath(decoimage);
    print(obImage);
    // print(decoimage);
    //Uint8List base64Decode(String obImage) => base64.decode(obImage);

    setState(() {
      _obImage = obImage;
    });
  }

  //objectditection display widget
  //Uint8List file
  Widget displayImage(Uint8List file) {
    return new SizedBox(
      height: 450.0,
      width: MediaQuery.of(context).size.width,
      child: file == null ? Container() : Image.memory(file, fit: BoxFit.fill,),
    );
  }
}
