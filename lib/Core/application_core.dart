import 'package:macro_attendance_app/Constant/app_strings.dart';
import 'package:macro_attendance_app/Core/application_base.dart';
import 'package:macro_attendance_app/UI/Dashboard/View/dashboard_screen.dart';
import 'package:macro_attendance_app/UI/Dashboard/ViewModel/dashboard_view_model.dart';
import 'package:macro_attendance_app/UI/Leave/ViewModel/leave_view_model.dart';
import 'package:macro_attendance_app/UI/Location/View/location_screen.dart';
import 'package:macro_attendance_app/UI/Login/View/login_screen.dart';
import 'package:macro_attendance_app/UI/Login/View/otp_screen.dart';
import 'package:macro_attendance_app/UI/Login/ViewModel/login_view_model.dart';
import 'package:macro_attendance_app/UI/Register/ViewModel/register_view_model.dart';
import 'package:macro_attendance_app/UI/Splash/View/splash_screen.dart';

class ApplicationCore extends AppBase {
  String initialRoute = "/";
  Map<String, Widget Function(BuildContext)> routes = {};

  ApplicationCore() {
    super.applicationName = AppStrings.appName;
    setUps();
  }

  setUps() {
    routes = {
      '/': (context) => const SplashScreen(),
      '/LoginScreen': (context) => const LoginScreen(),
      '/Dashboard': (context) => const DashboardScreen(),
      '/Location': (context) => const LocationScreen(),
    };
    locator.registerFactory(() => RegisterViewModel());
    locator.registerFactory(() => LoginViewModel());
    locator.registerFactory(() => DashboardViewModel());
    locator.registerFactory(() => LeaveViewModel());
    // locator.registerFactory(() => ReportViewModel());
  }
}
