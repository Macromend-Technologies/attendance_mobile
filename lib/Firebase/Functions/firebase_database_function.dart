import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseFunction {
  FirebaseFirestore? fireStore;
  FirebaseAuth? firebaseAuth;
  FirebaseDatabase? firebaseDatabase;

  Future<String> createUser(
      {required String email,
      required String password,
      required String name,
      String? phone}) async {
    fireStore = FirebaseFirestore.instance;
    firebaseAuth = FirebaseAuth.instance;
    firebaseDatabase = FirebaseDatabase.instance;
    try {
      UserCredential user = await firebaseAuth!
          .createUserWithEmailAndPassword(email: email, password: password);
      String uid = await storeUser(
          email: user.user!.email ?? "",
          name: user.user!.displayName ?? "",
          uid: user.user!.uid,
          phone: user.user!.phoneNumber ?? "");
      return uid;
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> storeUser(
      {required String uid,
      required String name,
      required String email,
      String? phone}) async {
    try {
      DatabaseReference db = firebaseDatabase!.ref('Staffs/$uid');
      DataSnapshot snapshot = await db.get();
      if (!snapshot.exists) {
        await db.set({
          'uid': uid,
          'email': email,
          'name': name,
          'phone': phone,
          'registered_at': DateTime.now().toIso8601String()
        });
        return uid;
      } else {
        throw "This mail is already registered...";
      }
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<User> userLogin(
      {required String email, required String password}) async {
    firebaseAuth = FirebaseAuth.instance;
    firebaseDatabase = FirebaseDatabase.instance;
    try {
      UserCredential user = await firebaseAuth!
          .signInWithEmailAndPassword(email: email, password: password);
      DatabaseReference db = firebaseDatabase!.ref('Staffs/${user.user!.uid}');
      await db.update({"login_time": DateTime.now().toIso8601String()});
      return user.user!;
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> createSecureCode({required String uid}) async {
    try {
      firebaseDatabase = FirebaseDatabase.instance;
      DatabaseReference db = firebaseDatabase!.ref('SecureCodes/$uid');
      DataSnapshot snapshot = await db.get();
      Random random = Random();
      int code = 1000 + random.nextInt(900000);
      if (!snapshot.exists) {
        await db.update({
          'code': code,
          'is_delete': false,
          'created_at': DateTime.now().toIso8601String()
        });
      } else {
        await db.set({
          'code': code,
          'is_delete': false,
          'created_at': DateTime.now().toIso8601String()
        });
      }
      return "code generated to the login staff.";
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString();
    }
  }
}
