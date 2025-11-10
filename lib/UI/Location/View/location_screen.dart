import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:macro_attendance_app/Constant/app_color.dart';
import 'package:macro_attendance_app/Constant/app_strings.dart';
import 'package:macro_attendance_app/Core/application_base.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  SharedPreferences? prefs;

  @override
  void initState() {
    prefs = spEngine!.prefs;
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/location_icon.png",
                scale: 2.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Activate Location",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "Enable your location access in your phone settings to use this application.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              InkResponse(
                radius: 5.0,
                onTap: () => allowAccess(),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  child: Text(
                    "Allow Access",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                        color: AppColor.whiteColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> allowAccess() async {
    if (await Geolocator.isLocationServiceEnabled()) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        LocationPermission per = await Geolocator.requestPermission();
        if (per == LocationPermission.always ||
            per == LocationPermission.whileInUse) {
          navigate();
        }
      } else if (permission == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
      } else if (permission == LocationPermission.whileInUse) {
        navigate();
      }
    } else {
      Geolocator.openLocationSettings();
    }
  }

  navigate() {
    prefs = spEngine!.prefs;
    bool isLog =
        prefs == null ? false : prefs!.getBool(AppStrings.isLogin) ?? false;
    Navigator.of(context).pushNamedAndRemoveUntil(
      isLog ? "/Dashboard" : "/LoginScreen",
      (route) => true,
    );
  }
}
