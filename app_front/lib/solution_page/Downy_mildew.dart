import 'package:flutter/material.dart';
import 'package:install_test/Screen/Loading.dart';

class DownyMildew extends StatelessWidget {
  const DownyMildew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '노균병',
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
                          'assets/images/downy.png'
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
                              '✔︎ 노균병은 거의 모든 박과 채소에 발생하지만 특히 오이에 피해가 큰 중요 병해로서 보통 생육 중기 이후부터 잎에 발생합니다.',
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
                              '✔︎ 시설재배지와 가을 날씨가 건조할 때 심하게 발생합니다.',
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
                              '✔︎ 생육 후기에 저온 다습하면 아랫잎부터 발생하여 큰 피해를 주는데, 최소 6시간 동안 100%의 상대습도가 유지되어야만 병원균의 포자낭이 형성되고, 발병온도 범위는 5～30℃이며, 발병적온은 15～20℃입니다.',
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
                              '✔︎ 병원균은 병든 식물체의 조직속에서 난포자 상태로 겨울을 지내고 새로운 식물체가 파종되어 생장하면 다시 발아하여 지상부로 침입하고, 잎 뒷면에서 다량의 포자를 형성하여 공기 중으로 쉽게 전반됩니다.',
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
                              '✔︎ 병원균의 균사가 잎의 기공이나 수공으로 침입하여 세포간극에서 생장하며 흡기를 내어 세포의 영양을 흡수합니다.',
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
                              '✔︎ 병든 잎은 조기에 제거하여 불에 태우거나 땅속 깊이 묻습니다.',
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
                              '✔︎ 포장을 청결히 하고 잎에 물방울이 장시간 맺혀 있지 않도록 관리합니다.',
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
                              '✔︎ 환기를 철저히 하고 토양이 과습하지 않도록 합니다.',
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
