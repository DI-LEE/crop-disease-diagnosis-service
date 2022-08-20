import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'api.dart';
import 'package:toast/toast.dart';
import 'result_page.dart';
class Mainpage extends StatefulWidget {
  @override
  MainpageState createState() => MainpageState();
}

class MainpageState extends State<Mainpage> {
  File _image;

  //이미지 받아오기
  Future getImage(bool isCamera) async{
    File image;

    if(isCamera){
      image= await ImagePicker.pickImage(source: ImageSource.camera);
    }
    uploadImage(image,uploadUrl);
    Toast.show("이미지가 업로드 되었습니다.", context, duration: Toast.LENGTH_LONG,textColor: Colors.black,backgroundColor: Colors.white12,backgroundRadius: 15,gravity: Toast.BOTTOM);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 100.0,
        ),
        child: Column(
          // bottom margin
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '누구나 할 수 있는',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontFamily: 'notosansb',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '병해충 진단 서비스.',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.white,
                    fontFamily: 'notosansb',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '당신의 농작물을 지켜주세요',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontFamily: 'notosansL',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 45,
                right: 45,
              ),
              child: Row(
                children: [
                  //카메라버튼 설정
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        getImage(true);
                      },
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Icon(
                        Icons.camera_alt,
                        size: 24,
                      ),
                      //전방향 페딩
                      padding: EdgeInsets.all(24),
                      shape : CircleBorder(),
                    ),
                  ),
                  //result page 이동 버튼
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) => ResultPage(image:_image,))
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          '진단내용보기',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontFamily: 'notosansb',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.green),
                          shape:
                          MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ))
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // 배경사진 전체 적용
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/img/Appbackground.jpg')
        ),
      ),
    );
  }
}