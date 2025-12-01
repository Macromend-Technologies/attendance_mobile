import 'package:macro_attendance_app/Core/application_base.dart';
import 'package:macro_attendance_app/Firebase/Functions/firestore_functions.dart';

class LeaveViewModel extends BaseModel {
  List<String> leaves = [];

  Future<void> getLeaveType() async {
    await FireStoreFunctions().getLeaveTypes().then(
      (value) {
        leaves = value;
      },
    );
  }
}
