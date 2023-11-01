import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:saathi/screens/ui/meditate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import '../../notificationService.dart';

class Sleep extends StatefulWidget {
  const Sleep({Key? key}) : super(key: key);

  @override
  State<Sleep> createState() => _SleepState();
}

class _SleepState extends State<Sleep> {
  TimeOfDay wakeUpTime = TimeOfDay(hour: 06, minute: 00);
  TimeOfDay sleepTime = TimeOfDay(hour: 22, minute: 00);
  late final LocalNotificationService service;

  void initializePrefs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var _hour = pref.getInt('hour') ?? 06;
    var _minute = pref.getInt('minute') ?? 30;
    TimeOfDay t = TimeOfDay(hour: _hour, minute: _minute);
    setState(() {
      wakeUpTime = t;
    });

    var _sleepHour = pref.getInt('sleepHour') ?? 22;
    var _sleepMinute = pref.getInt('sleepMinute') ?? 30;
    TimeOfDay sleep_t = TimeOfDay(hour: _sleepHour, minute: _sleepMinute);
    setState(() {
      sleepTime = sleep_t;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializePrefs();
  }

  void setWakeUpPerpetualAlarm() async {
    await AndroidAlarmManager.initialize();
    await AndroidAlarmManager.cancel(0);
    await AndroidAlarmManager.periodic(Duration(days: 1), 0, () {
      print('wake');
      FlutterAlarmClock.createAlarm(wakeUpTime.hour, wakeUpTime.minute,
          title: "Wake UP");
    });
  }

  void setSleepPerpetualAlarm() async {
    await AndroidAlarmManager.initialize();
    await AndroidAlarmManager.cancel(0);
    await AndroidAlarmManager.periodic(Duration(days: 1), 0, () {
      FlutterAlarmClock.createAlarm(wakeUpTime.hour, wakeUpTime.minute,
          title: "Wake UP");
    });
  }

  final setAlarmButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black,
      primary: HexColor('#AFE0D8'),
      padding: EdgeInsets.all(15),
      minimumSize: Size(double.maxFinite, 30),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2))));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Padding(
        //   padding: EdgeInsets.all(10),
        //   child: Center(
        //     child: Text(
        //       'Sleep Monitor',
        //       style: TextStyle(
        //           fontSize: 25,
        //           fontWeight: FontWeight.bold,
        //           color: Colors.black),
        //     ),
        //   ),
        // ),
        Divider(
          thickness: 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  'Sleep Time:',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                // Text(
                //   '${sleepTime.hour}:${sleepTime.minute}',
                //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                // ),
                Text(formatDate(
                    DateTime(0, 0, 0, sleepTime.hour, sleepTime.minute, 0),
                    [HH, ':', nn])),
                ElevatedButton(
                    onPressed: () async {
                      TimeOfDay? newTime = await showTimePicker(
                          context: context, initialTime: sleepTime);
                      if (newTime == null) return;
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      await pref.setInt('sleepHour', newTime.hour);
                      await pref.setInt('sleepMinute', newTime.minute);
                      if (mounted) {
                        setState(() {
                          sleepTime = newTime;
                        });
                      }
                    },
                    child: Text(
                      'Select time',
                      style: TextStyle(fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.black,
                      primary: HexColor('#AFE0D8'),
                    )),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              children: [
                Text(
                  'Wake Up Time',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                // Text(
                //   '${wakeUpTime.hour}:${wakeUpTime.minute}',
                //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                // ),
                Text(formatDate(
                    DateTime(0, 0, 0, wakeUpTime.hour, wakeUpTime.minute, 0),
                    [HH, ':', nn])),
                ElevatedButton(
                    onPressed: () async {
                      TimeOfDay? newTime = await showTimePicker(
                          context: context, initialTime: wakeUpTime);
                      if (newTime == null) return;
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      await pref.setInt('hour', newTime.hour);
                      await pref.setInt('minute', newTime.minute);
                      if (mounted) {
                        setState(() {
                          wakeUpTime = newTime;
                        });
                      }
                    },
                    child: Text(
                      'Select time',
                      style: TextStyle(fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.black,
                      primary: HexColor('#AFE0D8'),
                    )),
              ],
            )
          ],
        ),
        Divider(
          thickness: 2,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ElevatedButton(
            onPressed: () {
              FlutterAlarmClock.createAlarm(wakeUpTime.hour, wakeUpTime.minute,
                  title: 'Wake Up');
              FlutterAlarmClock.createAlarm(sleepTime.hour, sleepTime.minute,
                  title: 'Wake Up');
              //setWakeUpPerpetualAlarm();
            },
            child: Text('Set Alarm'),
            style: setAlarmButtonStyle,
          ),
        ),
      ],
    );
  }
}
