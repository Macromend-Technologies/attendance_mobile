class DashboardResponseModel {
  UserDetails? userDetails;
  TodayAttendance? todayAttendance;

  DashboardResponseModel({this.userDetails, this.todayAttendance});

  DashboardResponseModel.fromJson(Map<String, dynamic> json) {
    userDetails = json['user_details'] != null
        ? UserDetails.fromJson(json['user_details'])
        : null;
    todayAttendance = json['today_attendance'] != null
        ? TodayAttendance.fromJson(json['today_attendance'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userDetails != null) {
      data['user_details'] = userDetails!.toJson();
    }
    if (todayAttendance != null) {
      data['today_attendance'] = todayAttendance!.toJson();
    }
    return data;
  }
}

class UserDetails {
  String? name;
  String? email;
  String? phone;

  UserDetails({this.name, this.email, this.phone});

  UserDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}

class TodayAttendance {
  String? checkIn;
  String? checkOut;
  String? checkInLocation;
  String? checkOutLocation;

  TodayAttendance(
      {this.checkIn,
      this.checkOut,
      this.checkInLocation,
      this.checkOutLocation});

  TodayAttendance.fromJson(Map<String, dynamic> json) {
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    checkInLocation = json['check_in_location'];
    checkOutLocation = json['check_out_location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['check_in'] = checkIn;
    data['check_out'] = checkOut;
    data['check_in_location'] = checkInLocation;
    data['check_out_location'] = checkOutLocation;
    return data;
  }
}
