

import 'package:flutter/material.dart';
import 'package:panda_period/contollers/GetAuth.dart';
import 'package:panda_period/contollers/utils.dart';
import 'package:panda_period/contraints/custom.dart';
import 'package:panda_period/pages/Events.dart';
import 'package:panda_period/pages/event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:get/get.dart';

import 'event.dart';

//creating the class for the calender app with the floting icon for ading events

class calenderwidget extends StatelessWidget {
  const calenderwidget({super.key});
  

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
      body: eve(),
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
}

class eve extends StatefulWidget {
  const eve({super.key});

  @override
  State<eve> createState() => _eveState();
}

class _eveState extends State<eve> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        body: SfCalendar(
          view: CalendarView.month,
         // dataSource: MeetingDataSource(_getDataSource()),
        // dataSource: PeriodDataSource(periodsEvents),
        // monthViewSettings: MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
           monthViewSettings: MonthViewSettings(showAgenda: true),

        ));
  }

  

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0); 
    final DateTime endTime = startTime.add(const Duration(hours: 48));
    
   // final DateTime endTime = to;

    meetings.add(Meeting(
      'period',
      startTime,
      endTime,
      Color.fromARGB(255, 236, 8, 8),
      true,
      
    ));
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
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
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;

}

// editting th epeiod and creating the event
class periodEditing extends StatefulWidget {
  final Period? period;

  const periodEditing({super.key, this.period});

  @override
  State<periodEditing> createState() => _periodEditingState();
}

class _periodEditingState extends State<periodEditing> {
  final _formKey = GlobalKey<FormState>();
  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState() {
    // TODO: implement initState

    if (widget.period == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
    }
  }

  



  //from date time picker  selects the date and time and  creates  the period

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date==null) {
     return date;
      
    }
    if (date.isAfter(toDate)) {
      toDate= DateTime(date.year,date.month,date.day);
      
    }
    setState(() {
      fromDate=date;
    });
  }

  // to date time picker simmilar to the from date time picker
  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(toDate, pickDate: pickDate,firstDate: pickDate? fromDate : null);
    if (date==null) {
      return;
      
    }
    if (date.isAfter(fromDate)) {
      toDate= DateTime(date.year,date.month,date.day);
      
    }
    setState(() {
      toDate=date;
    });
  }

  Future<DateTime?> pickDateTime(DateTime initialDate,
      {required bool pickDate,
       DateTime? firstDate}) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2003, 8),
        lastDate: DateTime(2029),
      );

      if (date == null) {
        return null;
      }

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } 
    else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));

      if (timeOfDay == null) {
        return null;
      }

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

      return date.add(time);
    }
  }

  Future SavePeriod() async{
    final period = Period(from: fromDate, to: toDate, background: Colors.purpleAccent , isAllDay: true);
    
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: CloseButton(),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.done),
              tooltip: 'save',
              onPressed: () {
                SavePeriod();
                Get.back();
               // PeriodList.instance.loadData('period', to, from, true, Colors.purpleAccent);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Stack(children: [
          SafeArea(
              child: Container(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 10,
                  offset: Offset(1, 1),
                  color: Colors.grey,
                )
              ],
              border: Border.all(
                color: Color.fromARGB(255, 11, 12, 10),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(11),
            ),
            alignment: Alignment.center,
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const SizedBox(height: 50),
                
                GestureDetector(
                  child: dateContainer(
                      datelabel: 'FROM',
                      datetxt: utils.toDate(fromDate),
                      txtColor: Colors.black87,
                      weight: FontWeight.w500,
                      size: 30,
                      style: FontStyle.italic),
                      onTap: () {
                       pickFromDateTime(pickDate: true);
                       // Get.offAllNamed('/first');
                       
                      }
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  child: dateContainer(
                      datelabel: 'TO',
                      datetxt: utils.toDate(toDate),
                      txtColor: Colors.black87,
                      weight: FontWeight.w500,
                      size: 30,
                      style: FontStyle.italic),
                  onTap: () {
                    pickToDateTime(pickDate: true);
                  },
                ),
                
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ))
        ])));
  }
}



class PeriodDataSource extends CalendarDataSource {
  PeriodDataSource(List<Period> periodsEvents) {
   appointments = periodsEvents ;
  }

  Period getPeriod(int index) => appointments![index] as Period;  

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
    return appointments![index].title;
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


// data model for the period event
class Period {
  final String title ='period';
  final DateTime from;
  final DateTime to;
  final Color background;
  final bool isAllDay;

  Period(
      {
        
      required this.from,
      required this.to,
      required this.background,
      required this.isAllDay});
}


