import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:macro_attendance_app/Core/application_base.dart';
import 'package:macro_attendance_app/Firebase/Functions/firebase_database_function.dart';
import 'package:macro_attendance_app/Firebase/Functions/firestore_functions.dart';

class RegisterViewModel extends BaseModel {
  Future<void> registerUser(
      {required String name,
      required String phone,
      required String email,
      required String password}) async {
    super.setState(ViewState.inActive);
    try {
      DocumentSnapshot<Map<String, dynamic>> user =
          await FireStoreFunctions().userChecking(email: email);
      if (user.exists) {
        String userUid = await FirebaseDatabaseFunction().createUser(
            email: email, password: password, name: name, phone: phone);
        super.setState(ViewState.active);
      }
    } catch (e) {
      super.setState(ViewState.active);
      dialogueEngine!.showDialogueBox(msg: e.toString());
    }
  }
}
