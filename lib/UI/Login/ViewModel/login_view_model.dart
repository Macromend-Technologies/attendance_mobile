import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:macro_attendance_app/Core/application_base.dart';
import 'package:macro_attendance_app/Firebase/Functions/firebase_database_function.dart';
import 'package:macro_attendance_app/Firebase/Functions/firestore_functions.dart';

class LoginViewModel extends BaseModel {
  GoogleSignIn? googleSign;

  Future<void> userAuth(
      {required String email, required String password}) async {
    super.setState(ViewState.inActive);
    try {
      await FireStoreFunctions().userChecking(email: email);
      await FirebaseDatabaseFunction()
          .userLogin(email: email, password: password)
          .then(
        (value) async {
          String message =
              await FirebaseDatabaseFunction().createSecureCode(uid: value.uid);
        },
      );
    } catch (e) {
      super.setState(ViewState.active);
      dialogueEngine!.showDialogueBox(msg: e.toString());
    }
  }

  Future<void> googleSignIn() async {
    super.setState(ViewState.inActive);
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
          super.setState(ViewState.active);
        }
      }
    } on PlatformException catch (e) {
      super.setState(ViewState.active);
      dialogueEngine!.showDialogueBox(msg: e.message.toString());
    } catch (e) {
      super.setState(ViewState.active);
      dialogueEngine!.showDialogueBox(msg: e.toString());
    }
  }
}
