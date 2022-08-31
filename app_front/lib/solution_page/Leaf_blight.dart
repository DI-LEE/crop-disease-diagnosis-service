import 'package:flutter/material.dart';
import 'package:install_test/Screen/Loading.dart';

class LeafBlight extends StatelessWidget {
  const LeafBlight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '잎마름병',
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
                          'assets/images/leafblight.png',
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
                              '✔︎ 병원균은 병든 부위에서 균사나 분생포자의 형태로 겨울을 지낸 후, 분생포자를 형성하여 공기전염 합니다.',
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
                              '✔︎ 감염은 16～32℃ 에서 일어나며, 병 발생 적온은 20～28℃입니다.',
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
                              '✔︎ 이 병은 참깨, 콩 등의 다른 작물에서도 발생합니다.',
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
                        padding: const EdgeInsets.fromLTRB(10, 0, 30, 0),
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
                              '✔︎ 건전한 종자를 선별하고, 소독하여 파종합니다.',
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
                              '✔︎ 퇴비를 시용하여 작물의 초세를 좋게 합니다.',
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
                              '✔︎ 재배 시 균형시비를 합니다.',
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
