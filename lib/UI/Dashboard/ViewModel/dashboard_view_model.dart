import 'package:macro_attendance_app/Constant/app_strings.dart';
import 'package:macro_attendance_app/Core/application_base.dart';
import 'package:macro_attendance_app/Firebase/Functions/firestore_functions.dart';

class DashboardViewModel extends BaseModel {
  SharedPreferences? preferences;

  Future<void> getUserData() async {
    super.setState(ViewState.inActive);
    preferences = spEngine!.prefs;
    try {
      String uId = preferences!.getString(AppStrings.userUid) ?? "";
      await FireStoreFunctions().getUserDetails(uId: uId);
    } catch (e) {
      super.setState(ViewState.active);
      dialogueEngine!.showDialogueBox(msg: e.toString());
    }
  }
}
