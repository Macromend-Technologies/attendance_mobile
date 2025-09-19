import 'package:macro_attendance_app/Constant/app_color.dart';
import 'package:macro_attendance_app/Core/application_base.dart';

InputDecoration textDecorator(
    {String? hint, Widget? suffixIcon, Widget? prefixIcon}) {
  return InputDecoration(
    hintText: hint ?? "",
    hintStyle: TextStyle(
        fontSize: 14.0,
        color: AppColor.hintColor,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.0),
    counterText: "",
    contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 18.0),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: AppColor.disableColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: AppColor.disableColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: AppColor.disableColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: AppColor.redColor),
    ),
  );
}
