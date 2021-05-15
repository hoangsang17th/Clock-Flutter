import 'package:analog_clock/constants/constants.dart';
import 'package:analog_clock/main.dart';
import 'package:analog_clock/models/alarm_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  List<AlarmInfo> alarms = [
    AlarmInfo(
      alarmDateTime: DateTime.now().add(Duration(hours: 1)),
      title: 'KA103',
      isPending: true,
    ),
    AlarmInfo(
      alarmDateTime: DateTime.now().add(Duration(hours: 12)),
      title: 'Math VA404',
      isPending: false,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
        title: Text(
          "Alarm",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Will ring the bell in 5 hours",
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 25,
              ),
              Expanded(
                child: ListView(
                  children: alarms.map(
                    (alarm) {
                      var alarmTime =
                          DateFormat("hh:mm aa").format(alarm.alarmDateTime);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(17),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 2),
                                color: kShadowColor.withOpacity(0.25),
                                blurRadius: 7,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 15, 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "$alarmTime",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Switch(
                                      value: alarm.isPending,
                                      onChanged: (bool value) {
                                        setState(() {
                                          alarm.isPending = value;
                                        });
                                      },
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                  ],
                                ),
                                Text(
                                  alarm.title + " , Mon-Fri",
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scheduleAlarm();
        },
        child: Icon(Icons.add_alarm_rounded),
      ),
    );
  }

  void scheduleAlarm() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 10));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'logo',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('logo'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Office',
      "alarmInfo.title",
      scheduledNotificationDateTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
    );
  }
}
