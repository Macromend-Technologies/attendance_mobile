import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:macro_attendance_app/Constant/app_color.dart';
import 'package:macro_attendance_app/Core/AppModel/app_profile.dart';
import 'Core/application_base.dart' as core;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppProfile debugProfile = AppProfile(appName: "Macromend", baseUrl: "");

  AppProfile releaseProfile = AppProfile(appName: "Macromend", baseUrl: "");
  core.initApplication(const Macro(),
      debugProfile: debugProfile, releaseProfile: releaseProfile);
}

class Macro extends StatefulWidget {
  const Macro({super.key});

  @override
  State<Macro> createState() => _MacroState();
}

class _MacroState extends State<Macro> {
  @override
  Widget build(BuildContext context) {
    // Set landscape orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: false, colorSchemeSeed: AppColor.primaryColor),
        initialRoute: core.applicationCore!.initialRoute,
        routes: core.applicationCore!.routes,
        navigatorKey: core.applicationCore!.navigatorKey);
  }
}
