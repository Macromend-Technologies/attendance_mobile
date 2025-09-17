import 'package:macro_attendance_app/Constant/app_strings.dart';
import 'package:macro_attendance_app/Core/application_base.dart';
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
      // '/LoginScreen': (context) => const LoginScreen(),
      // '/Dashboard': (context) => const DashboardScreen(),
    };
    // locator.registerFactory(() => SplashViewModel());
    // locator.registerFactory(() => DashboardViewModel());
    // locator.registerFactory(() => LoginViewModel());
    // locator.registerFactory(() => ViceDisplayViewModel());
    // locator.registerFactory(() => ReportViewModel());
  }
}
