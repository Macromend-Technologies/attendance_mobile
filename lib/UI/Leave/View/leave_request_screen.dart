import 'package:intl/intl.dart';
import 'package:macro_attendance_app/Constant/app_color.dart';
import 'package:macro_attendance_app/Core/application_base.dart';

class LeaveRequestScreen extends StatefulWidget {
  final List<String> leaves;

  const LeaveRequestScreen({super.key, required this.leaves});

  @override
  State<LeaveRequestScreen> createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  DateTime _focusedMonth = DateTime.now();
  DateTime? _selectedDate;
  int allowedLeaveDays = 4; // your rule 3
  DateTime today = DateTime.now();
  DateTime? rangeStart;
  DateTime? rangeEnd;

  List<LeaveRange> leaves = [
    LeaveRange(
      from: DateTime(2025, 11, 10),
      to: DateTime(2025, 11, 12),
      color: Colors.red,
    ),
    LeaveRange(
      from: DateTime(2025, 11, 18),
      to: DateTime(2025, 11, 20),
      color: Colors.blue,
    ),
  ];

  bool isInRange(DateTime date, LeaveRange range) {
    return (date.isAtSameMomentAs(range.from) ||
        date.isAtSameMomentAs(range.to) ||
        (date.isAfter(range.from) && date.isBefore(range.to)));
  }

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
          "Leaves Request",
          style: TextStyle(
              color: AppColor.blackColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w800),
        ),
      ),
      body: Column(
        children: [
          buildHeader(),
          SizedBox(
            height: 15.0,
          ),
          buildWeekDays(),
          Expanded(child: buildCalendarGrid())
        ],
      ),
    );
  }

  // ---------------- HEADER (Month + Arrows) ----------------
  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          splashRadius: 5.0,
          icon: Icon(Icons.chevron_left, size: 32),
          onPressed: () {
            if (!(_focusedMonth.year == today.year &&
                _focusedMonth.month == today.month)) {
              setState(() {
                _focusedMonth =
                    DateTime(_focusedMonth.year, _focusedMonth.month - 1);
              });
            }
          },
        ),
        Text(
          DateFormat.yMMMM().format(_focusedMonth),
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        IconButton(
          splashRadius: 5.0,
          icon: Icon(Icons.chevron_right, size: 32),
          onPressed: () {
            DateTime nextAllowedMonth = DateTime(
                today.year, today.month + 1); // only next month allowed

            if (!(_focusedMonth.year == nextAllowedMonth.year &&
                _focusedMonth.month == nextAllowedMonth.month)) {
              setState(() {
                _focusedMonth =
                    DateTime(_focusedMonth.year, _focusedMonth.month + 1);
              });
            }
          },
        ),
      ],
    );
  }

  // ---------------- WEEKDAY ROW ----------------
  Widget buildWeekDays() {
    final days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    return Row(
      children: days
          .map(
            (d) => Expanded(
              child: Text(
                d,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey[600]),
              ),
            ),
          )
          .toList(),
    );
  }

  // Check if date is inside selected range
  bool isWithinRange(DateTime date) {
    if (rangeStart == null || rangeEnd == null) return false;

    return date.isAtSameMomentAs(rangeStart!) ||
        date.isAtSameMomentAs(rangeEnd!) ||
        (date.isAfter(rangeStart!) && date.isBefore(rangeEnd!));
  }

  // Build full calendar grid
  Widget buildCalendarGrid() {
    final firstDay = DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final lastDay = DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0);

    int startWeekDay = firstDay.weekday % 7;
    int totalDays = lastDay.day;

    List<Widget> dayWidgets = [];

    // Empty boxes before month start
    for (int i = 0; i < startWeekDay; i++) {
      dayWidgets.add(Container());
    }

    DateTime today = DateTime.now();
    DateTime nextMonthLimit = DateTime(today.year, today.month + 1, 31);

    // Generate days
    for (int day = 1; day <= totalDays; day++) {
      DateTime currentDate =
          DateTime(_focusedMonth.year, _focusedMonth.month, day);

      bool inRange = isWithinRange(currentDate);
      bool isStartOrEnd =
          (rangeStart == currentDate || rangeEnd == currentDate);

      dayWidgets.add(
        InkResponse(
          radius: 5.0,
          onTap: () {
            DateTime today = DateTime.now();
            DateTime onlyDateToday =
                DateTime(today.year, today.month, today.day);
            DateTime selectedOnlyDate =
                DateTime(currentDate.year, currentDate.month, currentDate.day);

            // ❌ BLOCK selecting yesterday or past dates
            if (selectedOnlyDate.isBefore(onlyDateToday)) {
              return;
            }
            // BLOCK previous month
            if (_focusedMonth.year == today.year &&
                _focusedMonth.month < today.month) {
              return;
            }

            // BLOCK beyond next month
            if (currentDate.isAfter(nextMonthLimit)) return;

            setState(() {
              // FIRST TAP → start date
              if (rangeStart == null) {
                rangeStart = currentDate;
                rangeEnd = null;
              }

              // SECOND TAP → end date
              else if (rangeEnd == null) {
                // int diff = currentDate.difference(rangeStart!).inDays.abs() + 1;

                // Validate number of days
                // if (diff > 4) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text(
                //           "You can select only ${4} days."),
                //     ),
                //   );
                //   return;
                // }

                // Apply range
                if (currentDate.isAfter(rangeStart!)) {
                  rangeEnd = currentDate;
                } else {
                  rangeEnd = rangeStart;
                  rangeStart = currentDate;
                }
              }
              // THIRD TAP → restart selection
              else {
                rangeStart = currentDate;
                rangeEnd = null;
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
                color: isStartOrEnd
                    ? AppColor.primaryColor
                    : inRange
                        ? Colors.green.shade50
                        : null,
                shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text(
              "$day",
              style: TextStyle(
                fontWeight: isStartOrEnd ? FontWeight.bold : FontWeight.normal,
                fontSize: 18.0,
                color: isStartOrEnd
                    ? AppColor.whiteColor
                    : inRange
                        ? Colors.green
                        : Colors.black,
              ),
            ),
          ),
        ),
      );
    }

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 7,
      mainAxisSpacing: 15.0,
      crossAxisSpacing: 5.0,
      padding: EdgeInsets.all(5.0),
      children: dayWidgets,
    );
  }
}

class LeaveRange {
  final DateTime from;
  final DateTime to;
  final Color color;

  LeaveRange({required this.from, required this.to, required this.color});
}
