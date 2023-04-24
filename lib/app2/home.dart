import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:panda_period/app2/ListAcc.dart';
import 'package:panda_period/app2/Form.dart';
import 'package:panda_period/app2/ProfilleAcc.dart';
import 'package:panda_period/app2/splah.dart';
import 'package:panda_period/app2/usermodel.dart';
import 'package:panda_period/app2/water.dart';
import 'package:panda_period/contollers/fireget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'HistoyTab.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime _startDate = DateTime.now();
  late  int _periodLength = 5;
  late int _cycleLength = 30;
  final email = FirebaseAuth.instance.currentUser?.email;
  final repo = Get.put(FireRepo());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late Future<UserData> _userDataFuture;

  @override
  void initState() {
    super.initState();
    // load start date and period length from firebase
    _userDataFuture = FireRepo.instance.getUserData(email.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserProfileScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage(email: email.toString())),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.timelapse),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DrinkingWaterReminder()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<UserData>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen() ;
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final userModel = snapshot.data!;
            _startDate = userModel.startDate;
            _periodLength = userModel.periodLength;
            _cycleLength = userModel.periodCycle;

            return SfCalendar(
              view: CalendarView.month,
              dataSource: _getCalendarDataSource(),
              monthViewSettings: MonthViewSettings(showAgenda: true),
              onTap: (CalendarTapDetails details) {
                if (details.targetElement == CalendarElement.calendarCell) {
                  final selectedDate = details.date!;
                  // navigate to add event screen with selectedDate
                }
              },
            );
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
     
   
  final cycleLength = _cycleLength;
  final ovulationDay = _startDate.add(Duration(days: (cycleLength - 14)));
  final unsafeStartDay = _startDate.add(Duration(days: (cycleLength - 18)));
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
        endTime: date,
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
          endTime: date.add(const Duration(hours: 14)),
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

