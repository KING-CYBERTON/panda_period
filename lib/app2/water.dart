import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class DrinkingWaterReminder extends StatefulWidget {
  const DrinkingWaterReminder({Key? key}) : super(key: key);

  @override
  _DrinkingWaterReminderState createState() => _DrinkingWaterReminderState();
}

class _DrinkingWaterReminderState extends State<DrinkingWaterReminder> {
  int _interval = 2; // default reminder interval in hours

  @override
  void initState() {
    super.initState();
    // initialize awesome_notifications package
    AwesomeNotifications().initialize(
      // set the icon and color of the notification
      'resource://drawable/app_icon',
      [
        NotificationChannel(
          channelKey: 'drinking_water_reminder',
          channelName: 'Drinking Water Reminder',
          channelDescription: 'Get reminders to drink water',
          defaultColor: Colors.blue,
          ledColor: Colors.blue,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Drinking Water Reminder'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Drinking Water Reminder',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          ListTile(
            title: Text('Reminder Interval'),
            trailing: DropdownButton<int>(
              value: _interval,
              onChanged: (value) {
                setState(() {
                  _interval = value!;
                });
              },
              items:const [
                DropdownMenuItem(value: 1, child: Text('1 Hour')),
                DropdownMenuItem(value: 2, child: Text('2 Hours')),
                DropdownMenuItem(value: 3, child: Text('3 Hours')),
                DropdownMenuItem(value: 4, child: Text('4 Hours')),
                DropdownMenuItem(value: 5, child: Text('5 Hours')),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _scheduleReminder,
            child: Text('Set Reminder'),
          ),
        ],
      ),
    );
  }

  void _scheduleReminder() {
    // cancel any existing notifications to avoid duplicates
    AwesomeNotifications().cancel(0);

    // create a notification with the reminder message
    String message = 'Time to drink water!';
    String title = 'Drink Water Reminder';
    DateTime scheduledDate = DateTime.now().add(Duration(hours: _interval));
    NotificationContent content = NotificationContent(
      id: 0,
      channelKey: 'drinking_water_reminder',
      title: title,
      body: message,
      bigPicture: 'resource://drawable/app_icon',
      notificationLayout: NotificationLayout.BigPicture,
      payload: {'id': 0.toString()},
    );

    // schedule the notification to repeat every `_interval` hours
    AwesomeNotifications().createNotification(
      content: content,
      schedule: NotificationCalendar(
        weekday: scheduledDate.weekday,
        hour: scheduledDate.hour,
        minute: scheduledDate.minute,
        second: scheduledDate.second,
        allowWhileIdle: true,
        repeats: true,
        //_interval: Duration(hours: _interval),
      ),
    );
  }
}
