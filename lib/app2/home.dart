import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:panda_period/app2/account.dart';
import 'package:panda_period/app2/profile2.dart';
import 'package:panda_period/app2/water.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'HistoyTab.dart';

class HomePage extends StatefulWidget {
  
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  late DateTime _startDate;
  late int _periodLength;

  @override
  void initState() {
    super.initState();
    // load start date and period length from firebase
    _startDate = DateTime.now() ; // replace with value from firebase
    _periodLength = 5; // replace with value from firebase
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        leading:IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>const AccontProfile()),
              );
            },
          ), 
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>const HistoryTab()),
              );
            },
          ),IconButton(
            icon:const Icon(Icons.timelapse),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>const DrinkingWaterReminder()),
              );
            },
          ),
        ],
      ),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: _getCalendarDataSource(),
        monthViewSettings: MonthViewSettings(showAgenda: true),
        onTap: (CalendarTapDetails details) {
          if (details.targetElement == CalendarElement.calendarCell) {
            final selectedDate = details.date!;
            // navigate to add event screen with selectedDate
          }
        },
      ), 
    );
  }

  CalendarDataSource _getCalendarDataSource() {


    final events = <Appointment>[];
    final endDate = _startDate.add(Duration(days: _periodLength -2));
    final dateFormat = DateFormat('yyyy-MM-dd');
    final rand = Random();
     
   
  final cycleLength = 30;
  final ovulationDay = _startDate.add(Duration(days: (cycleLength - 14)));
  final unsafeStartDay = _startDate.add(Duration(days: (cycleLength - 20)));
  final unsafeEndDay = _startDate.add(Duration(days: cycleLength));
  RecurrenceProperties recurrence =
      RecurrenceProperties(startDate: _startDate );
   recurrence.recurrenceType = RecurrenceType.daily;
   recurrence.interval = cycleLength;
  recurrence.recurrenceRange = RecurrenceRange.noEndDate;
  events.add(
    Appointment(
      startTime: ovulationDay,
      endTime: ovulationDay,
      subject: 'Ovulation Day',
      color: Colors.orange,
      isAllDay: true,
      resourceIds: ['ovulation'],
      recurrenceRule: SfCalendar.generateRRule(recurrence,
             _startDate, _startDate.add(Duration(hours: 2)))
     
    ),
  );
  events.add( Appointment(
      startTime: unsafeStartDay,
      endTime: unsafeEndDay,
      subject: 'Unsafe Days',
      color: Colors.pink,
      isAllDay: true,
      resourceIds: ['unsafe'],
      recurrenceRule: SfCalendar.generateRRule(recurrence,
             DateTime.now(), DateTime.now().add(Duration(hours: 2)))
      
    ),);


    for (var date = _startDate; date.isBefore(endDate); date = date.add(Duration(days: 1))) {
      events.add(Appointment(
        startTime: date,
        endTime: endDate,
        subject: 'Period Day',
        color: Colors.red,
        isAllDay: true,
        resourceIds: ['period'],
        recurrenceRule: SfCalendar.generateRRule(recurrence,
             DateTime.now(), DateTime.now().add(Duration(hours: 2))) 
      ));
      if (rand.nextDouble() < 0.8) {
        events.add(Appointment(
          startTime: date.add(const Duration(hours: 14)),
          endTime: endDate,
          subject: 'Mood Swing',
          color: Colors.green,
          isAllDay: false,
          resourceIds: ['mood'],
          recurrenceRule: SfCalendar.generateRRule(recurrence,
             DateTime.now(), DateTime.now().add(Duration(hours: 2)))
         
        ));
      }
    }
    return _CalendarDataSource(events);
  }
}

class _CalendarDataSource extends CalendarDataSource {
  _CalendarDataSource(List<Appointment> source) {
    appointments = source;
  }
}

