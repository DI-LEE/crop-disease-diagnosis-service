import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'api.dart';

class ResultPage extends StatefulWidget{
  final File image;
  ResultPage({Key key, @required this.image}):super( key : key );
  
  @override
  State<StatefulWidget> createState() => ResultPageState(image);
}

class ResultPageState extends State<ResultPage>{
  String captions="진단내용.....";
  var data;
  File image;
  FlutterTts ftts=FlutterTts();

  ResultPageState(this.image);

  Widget build(BuildContext context) {
    return Container(
      //decoration: BoxDecoration(
        //gradient: LinearGradient(
          //begin: Alignment.topRight,
          //end: Alignment.bottomLeft,
          //stops: [0.1, 0.5, 0.7, 0.9],
          //colors: [
          //  Colors.yellow[800],
          //  Colors.yellow[700],
          //  Colors.yellow[600],
            //Colors.yellow[400],
          //],
        //),
      //),
      child: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Container(
              //color: Colors.white,
              //margin: EdgeInsets.all(5),
              //padding: EdgeInsets.all(10),
              //decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(20),
              //color: Colors.white,
                //     ),
              //child: Text(
                //  "캡셔닝",
                  //style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.black),
                //),
              //),
            //SizedBox(height: 30,),
            Container(
              //decoration: BoxDecoration(
                //border: Border.all(color:Colors.white,width:3),
              //),
              child: displayImage(image), 
            ),
            //SizedBox(height: 20,),
            Container(
              //height: 100,
              //width: 200, //기존사이즈
              height : 150,
              width : MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(1),
                    spreadRadius: 0.1,
                    blurRadius: 15,
                    offset: Offset(
                        -18,
                        -18,
                    ),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '진단내용',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    captions,style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                    onPressed: (){},
                  child: Icon(Icons.add),
                )
              ],
            )

            //Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            //children: <Widget>[
            //RaisedButton(
              //child: Text("Refresh",style: TextStyle(color: Colors.black,),),
              //elevation: 5.0,
              //color: Colors.white,
              //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              //onPressed: () => getCaption(),
            //),
            //SizedBox(width: 25,),
            //RaisedButton(
              //child: Text("Audio",style: TextStyle(color: Colors.black,),),
              //elevation: 5.0,
              //color: Colors.white,
              //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              //onPressed: () => speakCaption(),
            //),
              //],
            //)

          ],
        ),
      ),
      /*
      floatingActionButton: FloatingActionButton.extended(
                onPressed: () => Navigator.pushNamed(context, "/"),
                icon: Icon(
                Icons.arrow_back,color: Colors.black,size: 30,
                ),
                label: Text("Back",style: TextStyle(color: Colors.black),),
                ),
      */
    ),
      
  );
  }

  Future getCaption() async{
    data=await getData(uploadUrl);
    
    setState(() {
     captions=data['captions'];
    });
  }
  
  speakCaption() async{
    await ftts.setLanguage("en-US");
    await ftts.setPitch(1);
    await ftts.speak(captions);
  }

  //이미지 디스플레이 사이즈 조절
  Widget displayImage(File file) {
    return new SizedBox(
      height: 450.0,
      width: MediaQuery.of(context).size.width,
      child: file == null ? Container() : Image.file(file),
    );
  }
}