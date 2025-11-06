import 'package:flutter/services.dart';
import 'package:macro_attendance_app/Constant/app_color.dart';
import 'package:macro_attendance_app/Core/application_base.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 0.0,
        backgroundColor: AppColor.backgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColor.backgroundColor,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: Column(
        children: [
          Text(
            "OTP code verification",
            style: TextStyle(
                color: AppColor.blackColor,
                fontWeight: FontWeight.w700,
                fontSize: 25.0),
          ),
          PinCodeTextField(
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            pinTheme: PinTheme(
                // borderRadius: BorderRadius.circular(8.0),
                fieldWidth: 75.0,
                fieldHeight: 75.0,
                shape: PinCodeFieldShape.box),
            appContext: context,
            length: 4,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Code is required.";
              } else {
                return null;
              }
            },
          )
        ],
      ),
    );
  }
}
