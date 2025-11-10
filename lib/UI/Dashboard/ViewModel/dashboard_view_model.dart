import 'package:geolocator/geolocator.dart';
import 'package:macro_attendance_app/Constant/app_strings.dart';
import 'package:macro_attendance_app/Core/application_base.dart';
import 'package:macro_attendance_app/Firebase/Functions/firestore_functions.dart';
import 'package:macro_attendance_app/UI/Dashboard/Model/dashboard_response_model.dart';
import 'package:macro_attendance_app/UI/Dashboard/Model/location_response_model.dart';

class DashboardViewModel extends BaseModel {
  SharedPreferences? preferences;
  TodayAttendance? attendance;
  UserDetails? user;
  String latitude = "";
  String longitude = "";
  List<Locations> locations = [];

  Future<void> getUserData() async {
    super.setState(ViewState.inActive);
    preferences = spEngine!.prefs;
    try {
      getOfficeLocations();
      String uId = preferences!.getString(AppStrings.userUid) ?? "";
      await FireStoreFunctions().getUserDetails(uId: uId).then(
        (value) {
          DashboardResponseModel entity =
              DashboardResponseModel.fromJson(value);
          user = entity.userDetails;
          attendance = entity.todayAttendance;
          super.setState(ViewState.active);
        },
      );
    } catch (e) {
      super.setState(ViewState.active);
      dialogueEngine!.showDialogueBox(msg: e.toString());
    }
  }

  Future<void> getOfficeLocations() async {
    try {
      await FireStoreFunctions().getLocations().then(
        (value) {
          LocationResponseModel entity =
              LocationResponseModel.fromJson({"locations": value});
          if (entity.locations!.isNotEmpty) {
            locations = entity.locations ?? [];
          } else {
            throw "No locations are found contact your HR or manager";
          }
        },
      );
    } catch (e) {
      dialogueEngine!.showDialogueBox(msg: e.toString());
    }
  }

  Future<void> makeAttendance(
      {required bool isCheckIn,
      required String time,
      required double officeLat,
      required double officeLong,
      required int radius}) async {
    super.setState(ViewState.busy);
    preferences = spEngine!.prefs;
    try {
      String uId = preferences!.getString(AppStrings.userUid) ?? "";
      bool result = await getCurrentLocation();
      if (result) {
        await FireStoreFunctions()
            .makeAttendance(
                uId: uId,
                isCheckIn: isCheckIn,
                time: time,
                location: "$latitude,$longitude",
                officeLat: officeLat,
                officeLong: officeLong,
                radius: radius)
            .then(
          (value) {
            if (value) {
              if (isCheckIn) {
                attendance!.checkIn = time;
              } else {
                attendance!.checkOut = time;
              }
            }
            super.setState(ViewState.active);
          },
        );
      }
    } catch (e) {
      super.setState(ViewState.active);
      dialogueEngine!.showDialogueBox(msg: e.toString());
    }
  }

  Future<bool> getCurrentLocation() async {
    bool result = false;
    try {
      await Geolocator.getCurrentPosition(
              locationSettings: LocationSettings(
                  accuracy: LocationAccuracy.best, distanceFilter: 0))
          .then(
        (value) {
          latitude = value.latitude.toString();
          longitude = value.longitude.toString();
          result = true;
        },
      );
    } catch (e) {
      throw e.toString();
    }
    return result;
  }
}
