import 'package:flutter/material.dart';

class AppColor extends Color {
  AppColor._(final String hex) : super(_getColor(hex));

  static int _getColor(String hex) {
    hex = hex.toUpperCase().replaceAll("#", "");
    if (hex.length == 6) {
      hex = "FF$hex";
    }
    return int.parse(hex, radix: 16);
  }

  static AppColor primaryColor = AppColor._("#F8BD03");
  static AppColor blackColor = AppColor._("#000000");
  static AppColor secondaryColor = AppColor._("#E10C13");
  static AppColor whiteColor = AppColor._("#FFFFFF");
  static AppColor greyColor = AppColor._("#CCCCCC");
  static AppColor disableColor = AppColor._("#E2E2E2");
  static AppColor hintColor = AppColor._("#727272");
  static AppColor backgroundColor = AppColor._("#F6F7F8");
}
