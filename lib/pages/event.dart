import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:get/get.dart';




class eve extends StatefulWidget {
  const eve({super.key});

  @override
  State<eve> createState() => _eveState();
}

class _eveState extends State<eve> {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
  leading :IconButton(
      icon:const Icon(
        Icons.person,
        color: Colors.white,
      ),
      onPressed: () {
        Get.toNamed('/Profile');
      },
    )
  
),
        body: SfCalendar(
          view: CalendarView.month,
          dataSource: MeetingDataSource(_getDataSource()),
          monthViewSettings: MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        ));
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 48));
    
    meetings.add(
        Meeting(
        'period', 
        startTime,
         endTime,
          Color.fromARGB(255, 236, 8, 8),
           true,
           RecurrenceType.monthly
               
           ));
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay, RecurrenceType month);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  
}
