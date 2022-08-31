import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class Model {
  //condition에 따른 날씨 아이콘
  Widget? getWeatherIcon(int condition) {

    if (condition < 300) {
      return SvgPicture.asset(
        'assets/svg/climacon-colud_lightning.svg',
        color: Colors.black87,
        height: 60,
      );
    } else if (condition < 500) {
      return SvgPicture.asset(
        'assets/svg/climacon-cloud_rain.svg',
        color: Colors.black87,
        height: 60,
      );
    } else if (condition < 600) {
      return SvgPicture.asset(
        'assets/svg/climacon-cloud_snow_alt.svg',
        color: Colors.black87,
        height: 60,
      );
    } else if (condition == 800) {
      return SvgPicture.asset(
        'assets/svg/climacon-sun.svg',
        color: Colors.black87,
        height: 60,
      );
    } else if (condition <= 804) {
      return SvgPicture.asset(
        'assets/svg/climacon-cloud_sun.svg',
        color: Colors.black87,
        height: 60,
      );
    }
  }
}
