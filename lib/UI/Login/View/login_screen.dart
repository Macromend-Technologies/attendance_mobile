import 'package:flutter/services.dart';
import 'package:macro_attendance_app/Constant/app_color.dart';
import 'package:macro_attendance_app/Core/application_base.dart';
import 'package:macro_attendance_app/UI/Login/View/otp_screen.dart';
import 'package:macro_attendance_app/UI/Login/ViewModel/login_view_model.dart';
import 'package:macro_attendance_app/UI/Register/View/register_screen.dart';
import 'package:macro_attendance_app/Utils/decorations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHide = true;
  TextEditingController mailCtrl = TextEditingController();
  TextEditingController pwdCtrl = TextEditingController();
  final loginKey = GlobalKey<FormState>();
  LoginViewModel? model;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BaseView<LoginViewModel>(
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
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  loginSection(context),
                  SizedBox(
                    height: 20.0,
                  ),
                  InkResponse(
                    radius: 5.0,
                    onTap: () async {
                      if (model.state != ViewState.inActive) {
                        await model.googleSignIn();
                      }
                    },
                    child: Container(
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
                    ),
                  )
                ],
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: InkResponse(
                radius: 5.0,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "I don't have an account? ",
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Text(
                        "Sign in",
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
      ),
    );
  }

  Widget loginSection(BuildContext context) {
    return Form(
      key: loginKey,
      child: Column(
        children: [
          TextFormField(
            controller: mailCtrl,
            enabled: model!.state != ViewState.inActive,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Mail id is required";
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
            controller: pwdCtrl,
            obscureText: isHide,
            enabled: model!.state != ViewState.inActive,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
                letterSpacing: 5.0),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Password is required";
              } else {
                return null;
              }
            },
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
          model!.state == ViewState.inActive
              ? CircularProgressIndicator()
              : InkResponse(
                  radius: 5.0,
                  onTap: () {
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
                      "Sign In",
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
    FocusScope.of(context).unfocus();
    if (loginKey.currentState!.validate()) {
      await model!
          .userAuth(
              email: mailCtrl.text, password: pwdCtrl.text, context: context)
          .then(
        (value) {
          if (value) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OtpScreen(model: model, uid: model!.uid),
              ),
            );
          }
        },
      );
    }
  }
}
