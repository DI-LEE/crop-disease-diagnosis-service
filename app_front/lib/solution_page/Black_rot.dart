import 'package:flutter/material.dart';

import '../Screen/Loading.dart';

class BlackRot extends StatelessWidget {
  const BlackRot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '검은무늬병',
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
                          'assets/images/blackrot.png'
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
                              '✔︎ 병든 식물체의 잔재에서 균사나 분생포자의 형태로 겨울을 지나 1차 전염원이 됩니다.',
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
                              '✔︎ 우리나라에서는 매우 널리 분포되어 있는 병으로 5월부터 11월까지 발생하나, 특히 7～8월 경 비가 자주 올 때 심하게 발생합니다.',
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
                              '✔︎ 비료분이 부족하여 후기 생육이 불량할 때 많이 발생한다.',
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
                              '✔︎ 고추와 오크라, 토마토, 가지, 오이 등이 병 발생 기주로 알려져 있습니다.',
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
                              '✔︎ 건전종자를 파종합니다.',
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
                              '✔︎ 병에 잘 걸리지 않는 품종을 선택하여 재배합니다.',
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
                              '✔︎ 작물의 생육중에 비료가 부족하지 않도록 주의하고, 균형시비를 합니다.',
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
                              '✔︎ 등록약제를 이용하여 방제합니다.',
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
