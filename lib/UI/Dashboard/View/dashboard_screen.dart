import 'package:intl/intl.dart';
import 'package:macro_attendance_app/Constant/app_color.dart';
import 'package:macro_attendance_app/Constant/app_strings.dart';
import 'package:macro_attendance_app/Core/application_base.dart';
import 'package:macro_attendance_app/UI/Dashboard/ViewModel/dashboard_view_model.dart';
import 'package:macro_attendance_app/UI/Leave/View/leave_list_screen.dart';
import 'package:macro_attendance_app/UI/Permission/View/permission_list_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardViewModel? model;
  SharedPreferences? prefs;
  String location = "";
  double lat = 0.00, lon = 0.00;
  int radius = 0;

  @override
  void initState() {
    prefs = spEngine!.prefs;
    getAttendanceLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardViewModel>(
      prepareModel: (model) {
        this.model = model;
        model.getUserData();
      },
      builder: (context, model, child) {
        if (model.state == ViewState.inActive) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: AppColor.backgroundColor,
            appBar: AppBar(
              backgroundColor: AppColor.backgroundColor,
              elevation: 0.0,
              automaticallyImplyLeading: false,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi, ${model.user!.name}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20.0,
                        color: AppColor.blackColor),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Welcome to Macromend",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: AppColor.hintColor, fontSize: 14.0),
                  )
                ],
              ),
              actions: [
                Container(
                  margin: EdgeInsets.only(top: 3.0, bottom: 3.0, right: 15.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: AppColor.shadowColor, shape: BoxShape.circle),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.asset(
                        "assets/images/notification_icon.png",
                        height: 30.0,
                        width: 30.0,
                        color: AppColor.hintColor,
                      ),
                      Container(
                        margin: EdgeInsets.all(2.0),
                        height: 10.0,
                        width: 10.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: AppColor.redColor),
                      )
                    ],
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  checkInWidget(),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "Actions",
                    style: TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  InkResponse(
                    radius: 5.0,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LeaveListScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: AppColor.disableColor),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: AppColor.shadowColor,
                                shape: BoxShape.circle),
                            child: Image.asset(
                              "assets/images/leave_icon.png",
                              height: 30.0,
                              width: 30.0,
                            ),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Leaves",
                                        style: TextStyle(
                                            color: AppColor.blackColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18.0),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        "Manage leaves and request",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios_rounded)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  InkResponse(
                    radius: 5.0,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PermissionListScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: AppColor.disableColor),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                color: AppColor.shadowColor,
                                shape: BoxShape.circle),
                            child: Image.asset(
                              "assets/images/permission_icon.png",
                              height: 30.0,
                              width: 30.0,
                            ),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Permission",
                                        style: TextStyle(
                                            color: AppColor.blackColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18.0),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        "Manage permission and request",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios_rounded)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  /*Container(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: AppColor.disableColor),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: AppColor.shadowColor, shape: BoxShape.circle),
                    child: Image.asset(
                      "assets/images/holiday_icon.png",
                      height: 30.0,
                      width: 30.0,
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Holiday",
                                style: TextStyle(
                                    color: AppColor.blackColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.0),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "View your holidays",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  )
                ],
              ),
            )*/
                ],
              ),
            ),
            /*bottomNavigationBar: Container(
        child: Row(
          children: [

          ],
        ),
      ),*/
          );
        }
      },
    );
  }

  Widget checkInWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: AppColor.disableColor),
      ),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: model!.attendance!.checkIn != "",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 5.0),
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: AppColor.lightGreenColor,
                          shape: BoxShape.circle),
                      child: Icon(
                        Icons.check,
                        size: 15.0,
                        color: AppColor.primaryColor,
                      ),
                    ),
                    Text(
                      "Clock In",
                      style: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Text(
                  model!.attendance!.checkIn ?? "",
                  style: TextStyle(
                      color: AppColor.blackColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          Visibility(
            visible: model!.attendance!.checkOut != "",
            child: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5.0),
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              shape: BoxShape.circle),
                          child: Icon(
                            Icons.check,
                            size: 15.0,
                            color: AppColor.redColor,
                          ),
                        ),
                        Text(
                          "Clock Out",
                          style: TextStyle(
                              color: AppColor.blackColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Text(
                      model!.attendance!.checkOut ?? "",
                      style: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Text(
                "Date ",
                style: TextStyle(
                    color: AppColor.hintColor, fontWeight: FontWeight.w400),
              ),
              Text(
                DateFormat('MM dd, yyyy').format(DateTime.now()),
                // "Aug 13, 2025",
                style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            "Attendance Location",
            style: TextStyle(
                color: AppColor.hintColor, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            location,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: AppColor.blackColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 18.0,
          ),
          model!.state == ViewState.active
              ? Visibility(
                  visible: model!.attendance!.checkIn!.isEmpty ||
                      model!.attendance!.checkOut!.isEmpty,
                  child: Column(
                    children: [
                      InkResponse(
                        radius: 5.0,
                        onTap: () async {
                          if (model!.attendance!.checkIn!.isEmpty) {
                            if (model!.locations.isNotEmpty) {
                              if (model!.locations.length > 1) {
                                chooseLocationSheet(context);
                              } else {
                                setState(() {
                                  location = model!.locations[0].name ?? "";
                                  lat = model!.locations[0].latitude ?? 0.00;
                                  lon = model!.locations[0].longitude ?? 0.00;
                                  radius = model!.locations[0].radius ?? 0;
                                });
                                await prefs!.setString(
                                    AppStrings.lastUpdateDate,
                                    DateFormat("dd-MM-yyyy")
                                        .format(DateTime.now()));
                                await model!.makeAttendance(
                                    isCheckIn: true,
                                    time: DateFormat('hh:mm a')
                                        .format(DateTime.now()),
                                    officeLong:
                                        model!.locations[0].longitude ?? 0.00,
                                    officeLat:
                                        model!.locations[0].latitude ?? 0.00,
                                    radius: model!.locations[0].radius ?? 0);
                              }
                            } else {
                              dialogueEngine!.showDialogueBox(
                                  msg:
                                      "No locations are found contact your HR or manager");
                            }
                          } else {
                            await model!.makeAttendance(
                                isCheckIn: false,
                                time: DateFormat('hh:mm a')
                                    .format(DateTime.now()),
                                officeLong: lon,
                                officeLat: lat,
                                radius: radius);
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 18.0),
                          decoration: BoxDecoration(
                            color: model!.attendance!.checkIn == ""
                                ? AppColor.primaryColor
                                : AppColor.redColor,
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                          child: Text(
                            model!.attendance!.checkIn == ""
                                ? "Check In"
                                : "Check Out",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColor.whiteColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 18.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                )
              : Center(child: CircularProgressIndicator()),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Attendance List",
                style: TextStyle(
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 15.0),
              ),
              Icon(
                Icons.arrow_right_rounded,
                color: AppColor.primaryColor,
              )
            ],
          )
        ],
      ),
    );
  }

  void chooseLocationSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      isDismissible: false,
      context: context,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Choose Location",
                        style: TextStyle(
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0),
                      ),
                      InkResponse(
                        radius: 5.0,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: AppColor.redColor, shape: BoxShape.circle),
                          child: Icon(
                            Icons.clear,
                            color: AppColor.whiteColor,
                            size: 20.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 0.0,
                  thickness: 1.5,
                ),
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: model!.locations.length,
                    itemBuilder: (context, index) {
                      return InkResponse(
                        radius: 5.0,
                        onTap: () async {
                          Navigator.of(context).pop();
                          await prefs!.setString(AppStrings.attendanceLocation,
                              model!.locations[index].name ?? "");
                          await prefs!.setDouble(AppStrings.attendanceLat,
                              model!.locations[index].latitude ?? 0.00);
                          await prefs!.setDouble(AppStrings.attendanceLog,
                              model!.locations[index].longitude ?? 0.00);
                          await prefs!.setInt(AppStrings.attendanceRad,
                              model!.locations[index].radius ?? 0);
                          await prefs!.setString(AppStrings.lastUpdateDate,
                              DateFormat("dd-MM-yyyy").format(DateTime.now()));
                          setState(() {
                            setState(() {
                              location = prefs!.getString(
                                      AppStrings.attendanceLocation) ??
                                  "";
                              lat =
                                  prefs!.getDouble(AppStrings.attendanceLat) ??
                                      0.00;
                              lon =
                                  prefs!.getDouble(AppStrings.attendanceLog) ??
                                      0.00;
                              radius =
                                  prefs!.getInt(AppStrings.attendanceRad) ?? 0;
                            });
                          });

                          await model!.makeAttendance(
                              isCheckIn: true,
                              time:
                                  DateFormat('hh:mm a').format(DateTime.now()),
                              officeLong:
                                  model!.locations[index].longitude ?? 0.00,
                              officeLat:
                                  model!.locations[index].latitude ?? 0.00,
                              radius: model!.locations[index].radius ?? 0);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 15.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: AppColor.greyColor, width: 0.5),
                            ),
                          ),
                          child: Text(
                            model!.locations[index].name ?? "",
                            style: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> getAttendanceLocation() async {
    if (prefs != null) {
      prefs = spEngine!.prefs;
      String lastUpdate = prefs!.getString(AppStrings.lastUpdateDate) ?? "";
      String today = DateFormat('dd-MM-yyyy').format(DateTime.now());
      if (today == lastUpdate) {
        String attLoc = prefs!.getString(AppStrings.attendanceLocation) ?? "";
        double attLat = prefs!.getDouble(AppStrings.attendanceLat) ?? 0.00;
        double attLon = prefs!.getDouble(AppStrings.attendanceLog) ?? 0.00;
        int attRad = prefs!.getInt(AppStrings.attendanceRad) ?? 0;
        setState(() {
          location = attLoc;
          lat = attLat;
          lon = attLon;
          radius = attRad;
        });
      }
    }
  }
}
