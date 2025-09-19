import 'package:flutter/services.dart';
import 'package:macro_attendance_app/Constant/app_color.dart';
import 'package:macro_attendance_app/Core/application_base.dart';
import 'package:macro_attendance_app/Utils/decorations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHide = true;

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
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Text(
              "Welcome Back👋",
              style: TextStyle(
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 22.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "We happy to see you again! to use your\naccount, you should sign in first.",
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            loginSection(context),
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.disableColor),
                borderRadius: BorderRadius.circular(35.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/google_icon.png"),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    "Continue wth google",
                    style: TextStyle(fontSize: 16.0, color: AppColor.hintColor),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "I don't have a account? ",
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                "Sign up",
                style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w700,
                    color: AppColor.primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginSection(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: textDecorator(
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                child: Image.asset(
                  "assets/images/mail_icon.png",
                  color: AppColor.hintColor,
                ),
              ),
              hint: "Enter your work mail id"),
        ),
        SizedBox(
          height: 20.0,
        ),
        TextFormField(
          obscureText: isHide,
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 20.0, letterSpacing: 5.0),
          decoration: textDecorator(
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                child: Image.asset(
                  "assets/images/password_icon.png",
                  color: AppColor.hintColor,
                ),
              ),
              suffixIcon: InkResponse(
                radius: 5.0,
                onTap: () {
                  setState(() {
                    isHide = !isHide;
                  });
                },
                child: Icon(
                  size: 28.0,
                  isHide
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColor.hintColor,
                ),
              ),
              hint: "Enter your password"),
        ),
        SizedBox(
          height: 25.0,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 20.0),
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(35.0),
          ),
          child: Text(
            "Sign In",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
                color: AppColor.whiteColor),
          ),
        ),
      ],
    );
  }
}
