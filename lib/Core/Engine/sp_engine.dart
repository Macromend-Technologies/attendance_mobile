import 'package:macro_attendance_app/Core/application_base.dart';

class SpEngine {
  SharedPreferences? prefs;

  SpEngine() {
    startEngine();
  }

  void startEngine() async {
    prefs = await SharedPreferences.getInstance();
  }
}
