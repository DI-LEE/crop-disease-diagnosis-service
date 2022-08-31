import 'package:flutter/material.dart';
import 'package:install_test/Screen/Loading.dart';

class LeafSpot extends StatelessWidget {
  const LeafSpot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '점무늬병',
          style: TextStyle(
            fontFamily: 'notosans',
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffA3BCAB),
        leading: IconButton(
          icon : Icon(
            Icons.arrow_back,
            size : 30.0,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                Loading()));
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/greenbackground.jpg',
            ),
            Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/leafspot.png'
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ), // 박스 라운드 조절
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
                // Container(
                //   height: 100,
                //   width: 350,
                //   child: Column(
                //     children: [
                //       Text(
                //         '- 고추와 오크라, 토마토, 가지, 오이 등이 병 발생 기주로 알려져 있습니다.',
                //         style: TextStyle(
                //           color: Colors.black87
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 350,
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: 380,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 30, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '발생환경',
                              style: TextStyle(
                                fontFamily: 'notosans',
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              '✔︎ 균은 작물의 잔재물이나 종자에서 생존합니다.',
                              style: TextStyle(
                                fontFamily: 'notosans',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '✔︎ 병원균은 선선하고 습한 조건하에서 감염하기 쉽습니다.',
                              style: TextStyle(
                                fontFamily: 'notosans',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '✔︎ 포자가 식물로 감염되려면 28℃ 이하의 온도와 바람이 동반된 빈번한 강우와 높은 상대습도가 필요합니다.',
                              style: TextStyle(
                                fontFamily: 'notosans',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 0, 30, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '방제방법',
                              style: TextStyle(
                                fontFamily: 'notosans',
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              '✔︎ 곡류나 옥수수와 같은 비기주 작물을 윤작하여 초기 전염원의 밀도를 줄입니다.',
                              style: TextStyle(
                                fontFamily: 'notosans',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '✔︎ 포장에서 감염된 잔재물은 경운하여 매몰합니다.',
                              style: TextStyle(
                                fontFamily: 'notosans',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '✔︎ 다소 건조하고 서늘한 조건에서 많이 발생하므로, 다른 병의 발생을 조장하지 않는한 온도와 습도를 높여줍니다.',
                              style: TextStyle(
                                fontFamily: 'notosans',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '✔︎ 무병종자를 사용합니다.',
                              style: TextStyle(
                                fontFamily: 'notosans',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '✔︎ 종자소독 후 파종합니다.',
                              style: TextStyle(
                                fontFamily: 'notosans',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );;
  }
}
