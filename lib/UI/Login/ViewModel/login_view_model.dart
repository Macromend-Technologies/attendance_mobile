import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:macro_attendance_app/Constant/app_strings.dart';
import 'package:macro_attendance_app/Core/application_base.dart';
import 'package:macro_attendance_app/Firebase/Functions/firebase_database_function.dart';
import 'package:macro_attendance_app/Firebase/Functions/firestore_functions.dart';

class LoginViewModel extends BaseModel {
  GoogleSignIn? googleSign;
  String uid = "";
  SharedPreferences? prefs;

  Future<bool> userAuth(
      {required String email,
      required String password,
      required BuildContext context}) async {
    prefs = spEngine!.prefs;
    bool result = false;
    super.setState(ViewState.inActive);
    try {
      await FireStoreFunctions().userChecking(email: email);
      await FirebaseDatabaseFunction()
          .userLogin(email: email, password: password)
          .then(
        (value) async {
          uid = value.uid;
          await prefs!.setString(AppStrings.userUid, value.uid);
          String message =
              await FirebaseDatabaseFunction().createSecureCode(uid: value.uid);
          if (message.isNotEmpty) {
            result = true;
            super.setState(ViewState.active);
          }
        },
      );
    } catch (e) {
      super.setState(ViewState.active);
      dialogueEngine!.showDialogueBox(msg: e.toString());
    }
    return result;
  }

  Future<bool> otpVerify({required String uid, required int otp}) async {
    prefs = spEngine!.prefs;
    bool result = false;
    super.setState(ViewState.busy);
    try {
      await FirebaseDatabaseFunction()
          .verifySecureCode(uid: uid, code: otp)
          .then(
        (value) async {
          if (value) {
            result = true;
            await prefs!.setBool(AppStrings.isLogin, true);
            super.setState(ViewState.ideal);
          }
        },
      );
    } catch (e) {
      super.setState(ViewState.busy);
      dialogueEngine!.showDialogueBox(msg: e.toString());
    }
    return result;
  }

  Future<void> googleSignIn() async {
    super.setState(ViewState.busy);
    try {
      googleSign = GoogleSignIn();
      await googleSign!.signOut();
      GoogleSignInAccount? googleSignInAccount = await googleSign!.signIn();
      if (googleSignInAccount == null) {
        throw "Google account sign in error";
      } else {
        DocumentSnapshot<Map<String, dynamic>> user = await FireStoreFunctions()
            .userChecking(email: googleSignInAccount.email);
        if (user.exists) {
          GoogleSignInAuthentication signInAuthentication =
              await googleSignInAccount.authentication;
          // Create new credential
          final credential = GoogleAuthProvider.credential(
            accessToken: signInAuthentication.accessToken,
            idToken: signInAuthentication.idToken,
          );
          // Sign in to Firebase
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);
          User userDetails = userCredential.user!;
          await FirebaseDatabaseFunction().storeUser(
              email: userDetails.email ?? "",
              uid: userDetails.uid,
              name: userDetails.displayName ?? "",
              phone: userDetails.phoneNumber ?? "");
          super.setState(ViewState.ideal);
        }
      }
    } on PlatformException catch (e) {
      super.setState(ViewState.ideal);
      dialogueEngine!.showDialogueBox(msg: e.message.toString());
    } catch (e) {
      super.setState(ViewState.ideal);
      dialogueEngine!.showDialogueBox(msg: e.toString());
    }
  }
}
