import 'package:flutter/services.dart';
import 'package:macro_attendance_app/Constant/app_color.dart';
import 'package:macro_attendance_app/Core/application_base.dart';
import 'package:macro_attendance_app/UI/Register/ViewModel/register_view_model.dart';
import 'package:macro_attendance_app/Utils/decorations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isHide = true, isShow = true;
  RegisterViewModel? model;
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController mailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController pwdCtrl = TextEditingController();
  TextEditingController cPwdCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
      prepareModel: (model) {
        this.model = model;
      },
      builder: (context, model, child) {
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
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 22.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Please sign up first to continue the services.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                registerSection(context),
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
                        style: TextStyle(
                            fontSize: 16.0, color: AppColor.hintColor),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: InkResponse(
              radius: 5.0,
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "I have an account? ",
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
          ),
        );
      },
    );
  }

  Widget registerSection(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameCtrl,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Name is required";
              } else {
                return null;
              }
            },
            decoration: textDecorator(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                  child: Image.asset(
                    "assets/images/user_icon.png",
                    color: AppColor.hintColor,
                  ),
                ),
                hint: "Enter your name"),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: mailCtrl,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Mail is required";
              } else {
                return null;
              }
            },
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
            controller: phoneCtrl,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLines: 1,
            maxLength: 10,
            keyboardType: TextInputType.phone,
            decoration: textDecorator(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                  child: Image.asset(
                    "assets/images/phone_icon.png",
                    color: AppColor.hintColor,
                  ),
                ),
                hint: "Enter your mobile number"),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: pwdCtrl,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password is required";
              } else {
                return null;
              }
            },
            obscureText: isHide,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
                letterSpacing: 5.0),
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
          TextFormField(
            controller: cPwdCtrl,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Confirm password is required";
              } else if (pwdCtrl.text != value) {
                return "Miss matched password";
              } else {
                return null;
              }
            },
            obscureText: isShow,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
                letterSpacing: 5.0),
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
                      isShow = !isShow;
                    });
                  },
                  child: Icon(
                    size: 28.0,
                    isShow
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColor.hintColor,
                  ),
                ),
                hint: "Enter confirm password"),
          ),
          SizedBox(
            height: 25.0,
          ),
          InkResponse(
            radius: 5.0,
            onTap: () {
              FocusScope.of(context).unfocus();
              validateInputs();
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(35.0),
              ),
              child: Text(
                "Sign Up",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                    color: AppColor.whiteColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> validateInputs() async {
    if (formKey.currentState!.validate()) {
      await model!.registerUser(
          name: nameCtrl.text,
          phone: phoneCtrl.text,
          email: mailCtrl.text,
          password: pwdCtrl.text);
    }
  }
}
