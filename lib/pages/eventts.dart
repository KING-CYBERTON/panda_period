// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';


// class MyCalendarController extends GetxController {
//   var events = <Appointment>[].obs;

//   CalendarDataSource _getDataSource() {
//     return MonthlyAppointmentDataSource(appointments: events);
//   }

//   void addEvent(DateTime fromDate, DateTime toDate, String subject, Color color) {
//     final Appointment newEvent = Appointment(
//       startTime: fromDate,
//       endTime: toDate,
//       subject: subject,
//       color: color,
//       recurrenceRule: 'FREQ=MONTHLY',
//     );

//     events.add(newEvent);
//   }
// }

// class MyCalendarScreen extends StatelessWidget {
//   final MyCalendarController controller = Get.put(MyCalendarController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('My Calendar')),
//       body: SfCalendar(
//         view: CalendarView.month,
//         dataSource: controller._getDataSource(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           // Show the event creation screen.
//           Get.to(CreateEventScreen()).then((result) {
//             // If the user created a new event, add it to the calendar.
//             if (result != null) {
//               controller.addEvent(result.fromDate, result.toDate, result.subject, result.color);
//             }
//           });
//         },
//       ),
//     );
//   }
// }



// class MonthlyAppointmentDataSource extends CalendarDataSource {
//   MonthlyAppointmentDataSource({List<Appointment>? appointments}) {
//     appointments = appointments ?? [];
//     this.appointments = appointments;
//   }

//   @override
//   DateTime getStartTime(int index) {
//     return appointments![index].startTime;
//   }

//   @override
//   DateTime getEndTime(int index) {
//     return appointments![index].subject;
//   }

//   @override
//   String getNotes(int index) {
//     return appointments![index].notes;
//   }

//   @override
//   Color getColor(int index) {
//     return appointments![index].color;
//   }

//   @override
//   bool isSameAppointment(Appointment a, Appointment b) {
//     return a.subject == b.subject &&
//         a.startTime == b.startTime &&
//         a.endTime == b.endTime &&
//         a.recurrenceRule == b.recurrenceRule;
//   }

//   @override
//   List<Appointment> getOccurrencesInRange(
//       DateTime startDate, DateTime endDate) {
//     final List<Appointment> recurringAppointments = [];

//     for (final Appointment appointment in appointments!) {
//       if (appointment.recurrenceRule == null) {
//         if (appointment.startTime.isAfter(startDate) &&
//             appointment.endTime.isBefore(endDate)) {
//           recurringAppointments.add(appointment);
//         }
//       } else {
//         final DateTimeRange recurrenceRange =
//             getRecurrenceRange(startDate, endDate, appointment.recurrenceRule);

//         for (DateTime occurrenceDate in
//             getRecurrenceOccurrences(recurrenceRange, appointment)) {
//           final Appointment occurrence = Appointment(
//               startTime: occurrenceDate,
//               endTime: occurrenceDate.add(appointment.endTime.difference(appointment.startTime)),
//               subject: appointment.subject,
//               notes: appointment.notes,
//               color: appointment.color,
//               recurrenceRule: appointment.recurrenceRule);

//           if (occurrence.startTime.isAfter(startDate) &&
//               occurrence.endTime.isBefore(endDate)) {
//             recurringAppointments.add(occurrence);
//           }
//         }
//       }
//     }

//     return recurringAppointments;
//   }

//   DateTimeRange getRecurrenceRange(
//       DateTime startDate, DateTime endDate, recurrenceRule) {
//     final RecurrenceHelper helper = RecurrenceHelper();
//     final DateTime firstDate = helper.getRecurrenceDateTime(
//         recurrenceRule,
//         DateTime(
//             startDate.year, startDate.month, startDate.day, 0, 0, 0, 0, 0),
//         false);
//     final DateTime lastDate = helper.getRecurrenceDateTime(
//         recurrenceRule,
//         DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59, 999, 999),
//         true);

//     return DateTimeRange(start: firstDate, end: lastDate);
//   }

//   List<DateTime> getRecurrenceOccurrences(
//       DateTimeRange recurrenceRange, Appointment appointment) {
//     final RecurrenceHelper helper = RecurrenceHelper();
//     final List<DateTime> occurrences = [];
//     DateTime occurrenceDate =
//         helper.getRecurrenceDateTime(appointment.recurrenceRule, appointment.startTime, false);

//     while (occurrenceDate.isBefore(recurrenceRange.end)) {
//       if (occurrenceDate.isAfter(recurrenceRange.start)) {
//         occurrences.add(occurrenceDate);
//       }

//       occurrenceDate = helper.getRecurrenceDateTime(
//           appointment.recurrenceRule, occurrenceDate, false);
//     }

//     return occurrences;
//   }
// }

// class RecurrenceHelper {
//   static List<DateTime> getRecurrenceDates(
//       String recurrenceRule, DateTime startDate, DateTime endDate) {
//     RecurrenceProperties properties =
//         SfCalendar.parseRRule(recurrenceRule, startDate);
//     if (properties == null) {
//       return [];
//     }
//     RecurrenceGenerator recurrenceGenerator = RecurrenceGenerator(
//       properties: properties,
//       startDate: startDate,
//       endDate: endDate,
//     );
//     List<DateTime> recurrenceDates = recurrenceGenerator.generateOccurrences().toList();
//     return recurrenceDates;
//   }
// }


