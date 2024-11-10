import 'package:flutter/material.dart';

class AppWidget {
  static TextStyle boldTextStyle() {
    return const TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold);
  }

  static TextStyle headLineTextStyle(){
    return const TextStyle(
        color: Colors.black,
        fontSize: 24.0,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold);
  }

  static TextStyle headLineText2Style(){
    return const TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
        fontSize: 30.0,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold);
  }

  static TextStyle lightTextStyle(){
    return const TextStyle(
        color: Colors.black38,
        fontSize: 15.0,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold);
  }

  static TextStyle semiBoldTextStyle(){
    return const TextStyle(
        color: Colors.black,
        fontSize: 18.0,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500);
  }

  static TextStyle buttonBoldTextStyle(){
    return const TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500);
  }

   static TextStyle buttonBoldText2Style(){
    return const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500);
  }

  static TextStyle semiBoldText2Style(){
    return const TextStyle(
        color: Colors.black,
        fontSize: 16.0,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500);
  }
}
