import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../contollers/fireget.dart';

class PeriodPage extends StatefulWidget {
  const PeriodPage({Key? key}) : super(key: key);

  @override
  _PeriodPageState createState() => _PeriodPageState();
}

class _PeriodPageState extends State<PeriodPage> {
  late List<DateTime> _periods;

  @override
  void initState() {
    super.initState();
    // load period dates from firebase
    _periods = [
      DateTime.now().subtract(const Duration(days: 6)),
      DateTime.now().subtract(const Duration(days: 27)),
      DateTime.now().subtract(const Duration(days: 58)),
      DateTime.now().subtract(const Duration(days: 89)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Period History'),
      ),
      body: _periods.isEmpty
          ?const Center(
              child: Text('No periods logged'),
            )
          : ListView.builder(
              itemCount: _periods.length,
              itemBuilder: (context, index) {
                final period = _periods[index];
                final startDate = period.subtract(const Duration(days: 4));
                final endDate = period.add(const Duration(days: 3));
                final formatter = DateFormat('dd/MMM');
                final formattedStartDate = formatter.format(startDate);
                final formattedEndDate = formatter.format(endDate);
                final formattedPeriodDate = '$formattedStartDate - $formattedEndDate';
                final isPast = period.isBefore(DateTime.now());
                return ListTile(
                  title: Text(formattedPeriodDate),
                  leading: Checkbox(
                    value: isPast,
                    onChanged: null,
                  ),
                );
              },
            ),
    );
  }
}

class HistoryTab extends StatefulWidget {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  late List<DateTime> _periods;

  @override
  void initState() {
    super.initState();
    // load periods from firebase or local storage
    _periods = [
      DateTime.now().subtract(Duration(days: 30)),
      DateTime.now().subtract(Duration(days: 60)),
      DateTime.now().subtract(Duration(days: 90)),
      DateTime.now().subtract(Duration(days: 120)),
      DateTime.now().subtract(Duration(days: 150)),
      DateTime.now().subtract(Duration(days: 180)),
      DateTime.now().subtract(Duration(days: 210)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Period History'),
      ),
      body: ListView(
        children: [
         const SizedBox(height: 10,),
        
          PeriodList(periods: _periods),
        ],
      ),
    );
  }
}

class PeriodList extends StatelessWidget {
  final List<DateTime> periods;

  const PeriodList({Key? key, required this.periods}) : super(key: key);
     @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._buildPastPeriods(context),
        ..._buildFuturePeriods(context),
      ],
    );
  }

  List<Widget> _buildPastPeriods(BuildContext context) {
    List<Widget> widgets = [];

    for (int i = 0; i < periods.length; i++) {
      if (i == 0) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
            child: Text(
              'Past Periods',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        );
      }

      if (i < periods.length - 1) {
        widgets.add(
          Container(
            decoration: BoxDecoration(
            border: Border.all(
              color: Colors.pink,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
            child: ListTile(
              title: Text(
                '${DateFormat('dd MMMM').format(periods[i])} - ${DateFormat('dd MMMM').format(periods[i + 1])}',
                style: TextStyle(fontSize: 16.0),
              ),
              leading:const Icon(Icons.favorite,
              color: Colors.pinkAccent,),
              trailing:const Icon(Icons.check,
              color: Colors.greenAccent,),
            ),
          ),
        );
      }
    }

    return widgets;
  }

 List<Widget> _buildFuturePeriods(BuildContext context) {
  List<Widget> widgets = [];

  DateTime nextPeriod = periods[0].add(Duration(days: 30));

  for (int i = 0; i < 6; i++) {
    if (i == 0) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
          child: Text(
            'Next Periods',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      );
    }

    widgets.add(
      Container(
         decoration: BoxDecoration(
            border: Border.all(
              color: Colors.redAccent,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
        child: ListTile(
          title: Text(
            '${DateFormat('dd MMM').format(nextPeriod.subtract(Duration(days: 5)))} - ${DateFormat('dd MMM').format(nextPeriod.add(Duration(days: 5)))}',
            style: TextStyle(fontSize: 16.0),
          ),
          leading:const Icon(Icons.favorite_border,
          color: Colors.redAccent,
          ),
        ),
      ),
    );

    nextPeriod = nextPeriod.add(Duration(days: 30));
  }

  return widgets;
}

}



// class PeriodHistoryTab extends StatefulWidget {
//   final String email;

//   PeriodHistoryTab({required this.email});

//   @override
//   _PeriodHistoryTabState createState() => _PeriodHistoryTabState();
// }

// class _PeriodHistoryTabState extends State<PeriodHistoryTab> {
//   late DateTime _startDate= DateTime.now();
//   late int _periodLength =5;

//   @override
//   void initState() {
//     super.initState();
//     _fetchPeriodData();
//   }

//   Future<void> _fetchPeriodData() async {
//     final periodData = await FireRepo.instance.getPeriodData(widget.email);
//     setState(() {
//       _startDate = DateTime.parse(periodData['startDate']);
//       _periodLength = periodData['periodLength'];
//     });
//   }

// List<DateTime> _getPeriodDates(DateTime startDate, int periodLength) {
//   var periodDates = <DateTime>[];
//   final dateFormat = DateFormat('dd/MM/yyyy');

//   // Calculate the start of the first period
//   DateTime periodStart = startDate;
//   while (periodStart.isAfter(DateTime.now().subtract(Duration(days: 180)))) {
//     periodStart = periodStart.subtract(Duration(days: periodLength));
//   }

//   // Calculate the past period dates
//   for (int i = 0; i < 6; i++) {
//     final periodEnd = periodStart.add(Duration(days: periodLength - 1));
//     if (periodEnd.isBefore(DateTime.now())) {
//       periodDates.add(periodStart);
//     } else {
//       break;
//     }
//     periodStart = periodStart.subtract(Duration(days: 28));
//   }
//   periodDates.add(_startDate.subtract(Duration(days: 1))); // Add last period before start date

//   // Reverse the list to display the dates in chronological order
//   final periodDatesR = periodDates.reversed.toList();

//   // Calculate the upcoming period dates
//   periodStart = _startDate;
//   while (periodStart.isBefore(DateTime.now().add(Duration(days: 180)))) {
//     periodDates.add(periodStart);
//     periodStart = periodStart.add(Duration(days: 28));
//   }
//   periodDates.removeWhere((date) => date.isBefore(DateTime.now())); // Remove past dates
//   periodDates = periodDates.sublist(0, min(periodDates.length, 6)); // Limit to six months

//   return periodDates;
// }



//   @override
// Widget build(BuildContext context) {
//   return FutureBuilder<Map<String, dynamic>>(
//     future: FireRepo.instance.getPeriodData(widget.email),
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return CircularProgressIndicator();
//       } else if (snapshot.hasError) {
//         return Text('Error fetching period data');
//       } else if (snapshot.hasData) {
//         final periodDates = _getPeriodDates(_startDate, _periodLength);
//         return ListView.builder(
//           itemCount: periodDates.length,
//           itemBuilder: (context, index) {
//             final periodDate = periodDates[index];
//             final formattedStartDate = DateFormat('dd/MM/yyyy').format(periodDate['start']);
//             final formattedEndDate = DateFormat('dd/MM/yyyy').format(periodDate['end']);
//             final isPastPeriod = periodDate['isPast'];
//             return ListTile(
//               title: Text('$formattedStartDate - $formattedEndDate'),
//               trailing: isPastPeriod ? Icon(Icons.check, color: Colors.red) : null,
//             );
//           },
//         );
//       } else {
//         return Text('No data found');
//       }
//     },
//   );
// }

// }



class MyHomePage extends StatelessWidget {
  final String email;

  const MyHomePage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Period History'),
      ),
      body: PeriodHistoryTab(email: email),
    );
  }
}

class PeriodHistoryTab extends StatefulWidget {
  final String email;

  PeriodHistoryTab({required this.email});

  @override
  _PeriodHistoryTabState createState() => _PeriodHistoryTabState();
}

class _PeriodHistoryTabState extends State<PeriodHistoryTab> {
  late DateTime _startDate =DateTime.now();
  late int _periodLength=5;

  @override
  void initState() {
    super.initState();
    _fetchPeriodData();
  }

  Future<void> _fetchPeriodData() async {
    final periodData = await FireRepo.instance.getPeriodData(widget.email);
    setState(() {
      _startDate = DateTime.parse(periodData['startDate']);
      _periodLength = periodData['periodLength'];
    });
  }

  List<DateTime> _getPeriodDates(DateTime startDate, int periodLength) {
    final periodDates = <DateTime>[];
    final dateFormat = DateFormat('dd/MM/yyyy');

    // Calculate the past period dates
    final now = DateTime.now();
    final sixMonthsAgo = now.subtract(Duration(days: 30 * 6));
    DateTime periodStart = startDate;
    while (periodStart.isAfter(sixMonthsAgo)) {
      final periodEnd = periodStart.add(Duration(days: periodLength - 1));
      periodDates.add(periodStart);
      periodDates.add(periodEnd);
      periodStart = periodStart.subtract(Duration(days: periodLength));
    }

    // Calculate the upcoming period dates
    DateTime nextPeriodStart = startDate.add(Duration(days: periodLength));
    while (nextPeriodStart.isBefore(now.add(Duration(days: 30 * 6)))) {
      final periodEnd = nextPeriodStart.add(Duration(days: periodLength - 1));
      periodDates.add(nextPeriodStart);
      periodDates.add(periodEnd);
      nextPeriodStart = nextPeriodStart.add(Duration(days: periodLength));
    }

    return periodDates;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: FireRepo.instance.getPeriodData(widget.email),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error fetching period data');
        } else if (snapshot.hasData) {
          final periodDates = _getPeriodDates(_startDate, _periodLength);
          return ListView.builder(
            itemCount: periodDates.length,
            itemBuilder: (context, index) {
              final periodDate = periodDates[index];
              final formattedDate = DateFormat('dd/MM/yyyy').format(periodDate);
              final isPastPeriod = periodDate.isBefore(DateTime.now());
              final tickIcon = isPastPeriod ? Icon(Icons.check, color: Colors.red) : SizedBox.shrink();
              return ListTile(
                title: Text(formattedDate),
                trailing: tickIcon,
              );
            },
          );
        } else {
          return Text('No data found');
        }
      },
    );
  }
}



