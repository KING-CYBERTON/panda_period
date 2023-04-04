import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:panda_period/pages/event.dart';

class MyCalendar extends StatefulWidget {
  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: MeetingDataSource(_getDataSource()),
        monthViewSettings: MonthViewSettings(showAgenda: true),
      ),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Conference',
        startTime,
        endTime,
        const Color(0xFF0F8644),
        false));

    final DateTime startTime1 =
        DateTime(today.year, today.month, today.day, 11, 0, 0);
    final DateTime endTime1 = startTime1.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Planning',
        startTime1,
        endTime1,
        const Color(0xFFD22525),
        false));

    final DateTime startTime2 =
        DateTime(today.year, today.month, today.day, 14, 0, 0);
    final DateTime endTime2 = startTime2.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Support',
        startTime2,
        endTime2,
        const Color(0xFF1E90FF),
        false));
    return meetings;
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



class SfCalendarWidget extends StatelessWidget {
  final eventsController = Get.put(EventsController());
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
       appBar: AppBar(
            leading: IconButton(
          icon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          onPressed: () {
            Get.toNamed('/Profile');
          },
        )),
      body: Column(
        children: <Widget>[
          Obx(() => Text(eventsController.events.length.toString())),
          SizedBox(height: 20,),
          
          SfCalendar(
            view: CalendarView.month,
            dataSource: _getCalendarDataSource(),
            monthViewSettings:const MonthViewSettings(showAgenda: true),
            onTap: (CalendarTapDetails details) {
              // Handle tap events here
            },
            onLongPress: (CalendarLongPressDetails details) {
              // Handle long press events here
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.purpleAccent,
          ),
          onPressed: () {
            Get.toNamed('/PeriodEdit');
          }),
    );
  }

  _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];
    for (var event in eventsController.events) {
      appointments.add(Appointment(
          startTime: event.date,
          endTime: event.date.add(Duration(hours: 2)),
          subject: event.title,
          color: Colors.blue,
          notes: event.description)
          
          );
    }

    eventsController.addEvent(Event(
  title: 'Meeting with clients',
  description: 'Discuss project details',
  date: DateTime.now() ,
));


    return AppointmentDataSource(appointments: appointments);
  }
}

class Event {
  String title;
  String description;
  DateTime date;

  Event({required this.title, required this.description,required this.date});
}




class EventsController extends GetxController {

  static EventsController instance =Get.find();
  RxList<Event> events = RxList<Event>([]);

  void addEvent(Event event) {
    events.add(event);
  }

  void removeEvent(Event event) {
    events.remove(event);
  }
}



class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource({List<Appointment>? appointments}) {
    appointments = appointments ?? [];
    this.appointments = appointments;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endTime;
  }

  @override
  String getSubject(int index) {
    return appointments![index].subject;
  }

  @override
  String getNotes(int index) {
    return appointments![index].notes;
  }

  @override
  Color getColor(int index) {
    return appointments![index].color;
  }
}
