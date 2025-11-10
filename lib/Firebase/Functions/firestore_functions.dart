import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
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

  Future<Map<String, dynamic>> getUserDetails({required String uId}) async {
    fireStore = FirebaseFirestore.instance;
    firebaseDatabase = FirebaseDatabase.instance;
    final now = DateTime.now();
    String date = DateFormat('dd-MM-yyyy').format(now);
    try {
      DatabaseReference db = firebaseDatabase!.ref('Staffs/$uId');
      DataSnapshot snapshot = await db.get();
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
        Map<String, dynamic> response = {
          "user_details": userDetails.toJson(),
          "today_attendance": {
            "check_in": "",
            "check_out": "",
            "check_in_location": "",
            "check_out_location": "",
          }
        };
        return response;
      } else {
        Map<String, dynamic> data = attendance.data() ?? {};
        if (data.containsKey(date)) {
          Map<String, dynamic> todayData =
              Map<String, dynamic>.from(data[date] as Map);
          return {
            "user_details": userDetails.toJson(),
            "today_attendance": todayData
          };
        } else {
          Map<String, dynamic> response = {
            "user_details": userDetails.toJson(),
            "today_attendance": {
              "check_in": "",
              "check_out": "",
              "check_in_location": "",
              "check_out_location": "",
            }
          };
          return response;
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
          "check_out_location": "",
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

  Future<bool> makeAttendance(
      {required String uId,
      required bool isCheckIn,
      required String time,
      required String location,
      required int radius,
      required double officeLat,
      required double officeLong}) async {
    final now = DateTime.now();
    String date = DateFormat('dd-MM-yyyy').format(now);
    bool result = false;
    fireStore = FirebaseFirestore.instance;
    try {
      String year = DateTime.now().year.toString();
      String monthName = DateFormat('MMMM').format(DateTime.now());
      List<String> parts = location.split(',');
      if (await isWithinOfficeArea(
          currentLat: double.parse(parts[0]),
          currentLong: double.parse(parts[1]),
          officeLat: officeLat,
          officeLng: officeLong,
          radiusInMeters: radius)) {
        DocumentReference<Map<String, dynamic>> db = fireStore!
            .collection('Attendance')
            .doc(year)
            .collection(monthName)
            .doc(uId);
        Map<String, dynamic> updateData = {};
        if (isCheckIn) {
          updateData.addAll({
            date: {
              "check_in":
                  time.isEmpty ? DateFormat('hh:mm a').format(now) : time,
              "check_in_location": location,
            }
          });
        } else {
          updateData.addAll({
            date: {
              "check_out":
                  time.isEmpty ? DateFormat('hh:mm a').format(now) : time,
              "check_out_location": location,
            }
          });
        }
        await db.set(updateData, SetOptions(merge: true));
        result = true;
      } else {
        throw "You are not at office location ❌";
      }
    } on FirebaseException catch (e) {
      throw e.message ?? "";
    } catch (e) {
      throw e.toString();
    }
    return result;
  }

  Future<bool> isWithinOfficeArea({
    required double currentLat,
    required double currentLong,
    required double officeLat,
    required double officeLng,
    int radiusInMeters = 100, // adjust radius as needed
  }) async {
    final distance = Geolocator.distanceBetween(
      currentLat,
      currentLong,
      officeLat,
      officeLng,
    );

    return distance <= radiusInMeters;
  }

  Future<List<Map<String, dynamic>>> getLocations() async {
    fireStore = FirebaseFirestore.instance;
    List<Map<String, dynamic>> locations = [];
    try {
      // Fetch all documents under "Locations"
      QuerySnapshot snapshot = await fireStore!.collection('Locations').get();
      // Convert to list
      for (var doc in snapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;
        var geoPoints = data['geo_points'];
        if (geoPoints != null && geoPoints is Map<String, dynamic>) {
          locations.add({
            'name': doc.id,
            'latitude': geoPoints['latitude'],
            'longitude': geoPoints['longitude'],
            'radius': geoPoints['radius'],
          });
        } else {
          print('⚠️ Missing or invalid geo_points in document: ${doc.id}');
        }
      }
    } on FirebaseException catch (e) {
      throw e.message ?? "";
    } catch (e) {
      throw e.toString();
    }
    return locations;
  }
}
