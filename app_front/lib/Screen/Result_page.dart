import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

import '../ml_api/MlApi.dart';
import '../solution_page/Bacillus.dart';
import '../solution_page/Black_rot.dart';
import '../solution_page/Downy_mildew.dart';
import '../solution_page/Leaf_blight.dart';
import '../solution_page/Leaf_mold.dart';
import '../solution_page/Leaf_spot.dart';
import '../solution_page/powdery.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //display 화면
            Expanded(
              child: Container(
                child: displayImage(_obImage),
              ),
            ),

            Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //하단 박스 디자인
                    Container(
                      height: 300.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
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

                //하단 텍스트 디자인
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '진단내용',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontFamily: 'notosans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 200, 30, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
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
                      ],
                    ),
                  ),
                )
              ],
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
    Uint8List obImage = base64Decode(obimage);
    print(obImage);

    setState(() {
      _obImage = obImage;
    });
  }

  //
  Widget displayImage(Uint8List file) {
    return new SizedBox(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      child: file == null ? Container() : Image.memory(file, fit: BoxFit.fill,),
    );
  }
}
