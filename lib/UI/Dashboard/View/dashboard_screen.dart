import 'package:intl/intl.dart';
import 'package:macro_attendance_app/Constant/app_color.dart';
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
            "Position",
            style: TextStyle(
                color: AppColor.hintColor, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            // "Senior Mobile Application Developer",
            model!.user!.name ?? "",
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
                  child: InkResponse(
                    radius: 5.0,
                    onTap: () async {
                      await model!.makeAttendance(
                        isCheckIn: model!.attendance!.checkIn == "",
                        time: DateFormat('hh:mm a').format(DateTime.now()),
                      );
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
                )
              : Center(child: CircularProgressIndicator()),
          SizedBox(
            height: 15.0,
          ),
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
}
