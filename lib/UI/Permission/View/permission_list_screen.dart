import 'package:macro_attendance_app/Constant/app_color.dart';
import 'package:macro_attendance_app/Core/application_base.dart';

class PermissionListScreen extends StatefulWidget {
  const PermissionListScreen({super.key});

  @override
  State<PermissionListScreen> createState() => _PermissionListScreenState();
}

class _PermissionListScreenState extends State<PermissionListScreen> {
  String selectedStatus = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0.0,
        leading: InkResponse(
          radius: 5.0,
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.arrow_back,
            color: AppColor.hintColor,
          ),
        ),
        titleSpacing: 0.0,
        title: Text(
          "Permission",
          style: TextStyle(
              color: AppColor.blackColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ["All", "Waiting", "Approved", "Cancelled"]
                    .asMap()
                    .entries
                    .map(
                  (e) {
                    return InkResponse(
                      radius: 5.0,
                      onTap: () {
                        setState(() {
                          selectedStatus = e.value;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            right: 15.0, left: e.key == 0 ? 15.00 : 0.0),
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20.0),
                        decoration: BoxDecoration(
                          color: selectedStatus == e.value
                              ? AppColor.primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              color: selectedStatus == e.value
                                  ? Colors.transparent
                                  : AppColor.disableColor),
                        ),
                        child: Text(
                          e.value,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: selectedStatus == e.value
                                  ? AppColor.whiteColor
                                  : AppColor.blackColor),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsetsDirectional.symmetric(horizontal: 15.0),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.disableColor),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Arun Gugan",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                "From Time : 10:00 AM",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: AppColor.redColor,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                "To Time : 11:00 AM",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: AppColor.redColor,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 25.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sick",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 8.0),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade50,
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Waiting",
                                    style: TextStyle(
                                        color: Colors.amber,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Image.asset(
                                    "assets/images/waiting_icon.png",
                                    height: 15.0,
                                    width: 15.0,
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
