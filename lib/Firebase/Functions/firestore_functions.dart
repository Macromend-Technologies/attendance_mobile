import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:macro_attendance_app/Core/application_base.dart';
import 'package:macro_attendance_app/Firebase/Model/user_details_response_model.dart';

class FireStoreFunctions {
  FirebaseFirestore? fireStore;
  FirebaseAuth? firebaseAuth;
  FirebaseDatabase? firebaseDatabase;

  Future<DocumentSnapshot<Map<String, dynamic>>> userChecking(
      {required String email}) async {
    fireStore = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>>? user;
    try {
      user = await fireStore!.collection('Staffs').doc(email).get();
      if (!user.exists) {
        throw "Your mail is not register in company.Please contact manager or hr.";
      } else {
        return user;
      }
    } on FirebaseException catch (e) {
      throw e.message ?? "";
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> getUserDetails({required String uId}) async {
    fireStore = FirebaseFirestore.instance;
    firebaseDatabase = FirebaseDatabase.instance;

    try {
      DatabaseReference db = firebaseDatabase!.ref('Staffs/$uId');
      DataSnapshot snapshot = await db.get();

      if (snapshot.exists) {
        Map<String, dynamic> data =
            Map<String, dynamic>.from(snapshot.value as Map);
        UserDetailsResponseModel userDetails =
            UserDetailsResponseModel.fromJson(data);

        String year = DateTime.now().year.toString();
        String monthName = DateFormat('MMMM').format(DateTime.now());

        DocumentSnapshot<Map<String, dynamic>> attendance = await fireStore!
            .collection('Attendance')
            .doc(year)
            .collection(monthName)
            .doc(uId)
            .get();
        // ✅ If not exists → generate automatically
        if (!attendance.exists) {
          await generateAttendance(uId: uId);
        }
      }
    } on FirebaseException catch (e) {
      throw e.message ?? "";
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> generateAttendance({required String uId}) async {
    final now = DateTime.now();
    String year = now.year.toString();
    String monthName = DateFormat('MMMM').format(now);

    try {
      final db = fireStore!
          .collection('Attendance')
          .doc(year)
          .collection(monthName)
          .doc(uId);

      final firstDayOfMonth = DateTime(now.year, now.month, 1);
      final nextMonth = DateTime(now.year, now.month + 1, 1);
      final daysInMonth = nextMonth.difference(firstDayOfMonth).inDays;

      Map<String, dynamic> attendanceData = {};
      for (int day = 1; day <= daysInMonth; day++) {
        String date =
            DateFormat('dd-MM-yyyy').format(DateTime(now.year, now.month, day));
        attendanceData[date] = {
          "check_in": "",
          "check_out": "",
          "check_in_location": "",
        };
      }

      // ✅ This automatically creates missing documents & subcollections
      await db.set(attendanceData, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw e.message ?? "";
    } catch (e) {
      throw e.toString();
    }
  }
}
