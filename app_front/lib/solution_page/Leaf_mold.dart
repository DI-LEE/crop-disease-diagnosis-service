import 'package:flutter/material.dart';

import '../Screen/Loading.dart';

class LeafMold extends StatelessWidget {
  const LeafMold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '잎곰팡이병',
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
                          'assets/images/leafmold.png'
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
                              '✔︎ 병원균은 병든 잎이나 종자 등에서 겨울을 지내고 1차 전염원이 되나, 시설재배에서는 병원균이 각종 농자재에 붙어 겨울을 지내기도 합니다.',
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
                              '✔︎ 2차 전염은 병반상에 형성된 포자가 전반되어 잎의 기공을 통하여 침입하여 발병됩니다.',
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
                              '✔︎ 20～25℃ 의 온도조건하에서 피해가 크며, 특히 시설재배지에서 심하게 발생합니다.',
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
                              '✔︎ 병든 잎을 신속히 제거합니다.',
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
                              '✔︎ 90%이상의 상대습도가 유지되지 않도록 합니다.',
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
                              '✔︎ 통풍이 잘되게 하고 밀식하지 않습니다.',
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
                              '✔︎ 건전한 종자를 사용하고, 깨끗한 자재를 사용합니다.',
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
                              '✔︎ 질소질 비료의 과용을 피합니다.',
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
    );
  }
}
