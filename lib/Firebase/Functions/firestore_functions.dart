import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:macro_attendance_app/Core/application_base.dart';

class FireStoreFunctions {
  FirebaseFirestore? fireStore;
  FirebaseAuth? firebaseAuth;
  FirebaseDatabase? firebaseDatabase;

  Future<DocumentSnapshot<Map<String, dynamic>>> userChecking(
      {required String email}) async {
    fireStore = FirebaseFirestore.instance;
    firebaseAuth = FirebaseAuth.instance;
    firebaseDatabase = FirebaseDatabase.instance;
    DocumentSnapshot<Map<String, dynamic>>? user;
    try {
      user = await fireStore!.collection('Staffs').doc(email).get();
      if (!user.exists) {
        throw "Your mail is not register in company.Please contact manager or hr.";
      } else {
        return user;
      }
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }
}
