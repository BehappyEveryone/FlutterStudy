import 'package:flutter/material.dart';

class CalendarApp extends StatelessWidget {
  const CalendarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xff1f1f1f),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      child: ClipOval(
                        child: Image.network(
                          "https://cdnimg.melon.co.kr/cm2/artistcrop/images/002/61/143/261143_20210325180240_500.jpg?61e575e8653e5920470a38d1482d7312/melon/resize/416/quality/80/optimize",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text(
                      String.fromCharCode(Icons.add.codePoint),
                      style: TextStyle(
                        inherit: false,
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: Icons.add.fontFamily,
                        fontWeight: FontWeight.w700,
                        package: Icons.add.fontPackage,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  'MONDAY 16',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CalendarDayText(
                      isToday: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        width: 10.0,
                        height: 10.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffac277c),
                        ),
                      ),
                    ),
                    CalendarDayText(
                      day: "17",
                      isToday: false,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    CalendarDayText(
                      day: "18",
                      isToday: false,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    CalendarDayText(
                      day: "19",
                      isToday: false,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    CalendarDayText(
                      day: "20",
                      isToday: false,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    CalendarDayText(
                      day: "21",
                      isToday: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const CalendarPlannerBox(
                backgroundColor: Color(0xfffef754),
                startHour: "11",
                startMin: "30",
                endHour: "12",
                endMin: "20",
                title: 'DESIGN\nMEETING',
                attendees: ["ALEX", "HELENA", "NANA"],
              ),
              const SizedBox(
                height: 10,
              ),
              const CalendarPlannerBox(
                backgroundColor: Color(0xff9c6bce),
                startHour: "12",
                startMin: "35",
                endHour: "14",
                endMin: "10",
                title: 'DAILY\nPROJECT',
                attendees: [
                  "ME",
                  "RICHARD",
                  "CIRY",
                  "DUMMY1",
                  "DUMMY2",
                  "DUMMY3",
                  "DUMMY4"
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const CalendarPlannerBox(
                backgroundColor: Color(0xffbcee4b),
                startHour: "15",
                startMin: "00",
                endHour: "16",
                endMin: "30",
                title: 'WEEKLY\nPLANNING',
                attendees: ["DEN", "NANA", "MARK"],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CalendarPlannerBox extends StatelessWidget {
  static const _myNameText = "ME";
  final Color backgroundColor;
  final String startHour, startMin, endHour, endMin, title;
  final List<String> attendees;

  const CalendarPlannerBox({
    super.key,
    required this.startHour,
    required this.startMin,
    required this.endHour,
    required this.endMin,
    required this.title,
    required this.attendees,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  startHour,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  startMin,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  child: Container(
                    color: Colors.black,
                    width: 1,
                    height: 20,
                  ),
                ),
                Text(
                  endHour,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  endMin,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        height: 0.85,
                        fontSize: 55,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: getAttendeesWidget(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getAttendeesWidget() {
    List<Widget> widget = [];

    attendees.take(3).forEach((name) {
      widget.add(getAttendeesTextWidget(name));
      widget.add(const SizedBox(
        width: 20,
      ));
    });

    if (attendees.length > 3) {
      var moreSize = attendees.length - 3;
      widget.add(getAttendeesMoreWidget(moreSize));
    }

    return widget;
  }

  Widget getAttendeesTextWidget(String name) {
    var textColor = isAttendeeMe(name) ? Colors.black : Colors.grey;
    return Text(
      name,
      style: TextStyle(
          color: textColor, fontSize: 15, fontWeight: FontWeight.w500),
    );
  }

  Widget getAttendeesMoreWidget(int moreSize) {
    return Text(
      "+$moreSize",
      style: const TextStyle(
          color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w500),
    );
  }

  bool isAttendeeMe(String name) {
    return name == _myNameText;
  }
}

class CalendarDayText extends StatelessWidget {
  final String day;
  final bool isToday;

  late final String _dayText;

  CalendarDayText({super.key, this.day = "", required this.isToday}) {
    _dayText = isToday ? "TODAY" : day;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _dayText,
      style: TextStyle(
        fontSize: 40,
        color: isToday ? Colors.white : Colors.white.withOpacity(0.6),
        fontWeight: FontWeight.w700,
      ),
    );
  }
}