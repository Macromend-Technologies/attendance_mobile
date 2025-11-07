import 'package:flutter/services.dart';
import 'package:macro_attendance_app/Constant/app_color.dart';
import 'package:macro_attendance_app/Core/application_base.dart';
import 'package:macro_attendance_app/UI/Login/ViewModel/login_view_model.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  final LoginViewModel? model;
  final String uid;

  const OtpScreen({super.key, this.model, required this.uid});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpFrom = GlobalKey<FormState>();
  TextEditingController otpCtrl = TextEditingController();
  bool isLoad = false;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Form(
          key: otpFrom,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text(
                "OTP code verification",
                style: TextStyle(
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 25.0),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text(
                "Verification code generated for your login get the code from HR or manager to verify.",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColor.hintColor, fontSize: 16.0),
              ),
              SizedBox(
                height: 115.0,
                child: PinCodeTextField(
                  appContext: context,
                  length: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "OTP is required.";
                    } else {
                      return null;
                    }
                  },
                  controller: otpCtrl,
                  autoFocus: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  obscureText: true,
                  // obscuringCharacter: "",
                  pinTheme: PinTheme(
                      fieldWidth: 65.0,
                      fieldOuterPadding: EdgeInsets.zero,
                      fieldHeight: MediaQuery.of(context).size.height * 0.09,
                      shape: PinCodeFieldShape.underline,
                      inactiveColor: AppColor.disableColor,
                      activeColor: AppColor.primaryColor,
                      selectedColor: AppColor.blackColor),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              isLoad
                  ? CircularProgressIndicator()
                  : InkResponse(
                      radius: 5.0,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        validInputs();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        child: Text(
                          "Verify OTP",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20.0,
                              color: AppColor.whiteColor),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void validInputs() {
    if (otpFrom.currentState!.validate()) {
      setState(() {
        isLoad = true;
      });
      widget.model!
          .otpVerify(uid: widget.uid, otp: int.parse(otpCtrl.text))
          .then(
        (value) {
          if (value) {
            setState(() {
              isLoad = false;
            });
            Navigator.of(context).pushNamedAndRemoveUntil(
              "/Dashboard",
              (route) => true,
            );
          }
        },
      );
    }
  }
}
