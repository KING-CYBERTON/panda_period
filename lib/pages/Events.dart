import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MyCalendar extends StatefulWidget {
  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  List<Meeting> _meetings = <Meeting>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: MeetingDataSource(_meetings),
        monthViewSettings: MonthViewSettings(showAgenda: true),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewMeeting,
        child: Icon(Icons.add),
      ),
    );
  }

  void _addNewMeeting() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );
    if (selectedDate != null) {
      final Meeting newMeeting = Meeting(
        'New Meeting',
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 9, 0, 0),
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 10, 0, 0),
        Colors.blue,
        false,
      );
      setState(() {
        _meetings.add(newMeeting);
      });
    }
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
