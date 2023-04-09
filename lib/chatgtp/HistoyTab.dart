import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

