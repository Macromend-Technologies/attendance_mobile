import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:macro_attendance_app/Constant/app_color.dart';
import 'package:macro_attendance_app/Constant/app_strings.dart';
import 'package:macro_attendance_app/Core/application_base.dart';
import 'package:macro_attendance_app/UI/Location/View/location_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? prefs;

  @override
  void initState() {
    prefs = spEngine!.prefs;
    startNavigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        toolbarHeight: 0.0,
        elevation: 0.0,
        backgroundColor: AppColor.backgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColor.backgroundColor,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          scale: 8.0,
        ),
      ),
    );
  }

  startNavigate() async {
    return Timer(
      Duration(seconds: 3),
      navigatePage,
    );
  }

  Future<void> navigatePage() async {
    prefs = spEngine!.prefs;
    bool isLog =
        prefs == null ? false : prefs!.getBool(AppStrings.isLogin) ?? false;
    LocationPermission permission = await Geolocator.checkPermission();
    bool isLocation = permission == LocationPermission.denied;
    Navigator.of(context).pushNamedAndRemoveUntil(
      isLocation
          ? "/Location"
          : isLog
              ? "/Dashboard"
              : "/LoginScreen",
      (route) => true,
    );
  }
}
