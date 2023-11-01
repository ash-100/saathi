import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:saathi/screens/ui/meditate.dart';

class SleepMonitor extends StatefulWidget {
  const SleepMonitor({Key? key}) : super(key: key);

  @override
  State<SleepMonitor> createState() => _SleepMonitorState();
}

class _SleepMonitorState extends State<SleepMonitor> {
  late String _setTime;
  late String _hour, _minute, _time;
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  TextEditingController _timeController = TextEditingController();

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
  }

  final trackButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black,
      primary: HexColor('#AFE0D8'),
      padding: EdgeInsets.all(15),
      minimumSize: Size(double.maxFinite, 30),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2))));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        //iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                'Sleep Monitor',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Container(child: Image.asset('assets/images/sleepChart.png')),
          Divider(
            thickness: 2,
          ),
          Row(
            children: [
              TextFormField(
                style: TextStyle(fontSize: 40),
                textAlign: TextAlign.center,
                onSaved: (String? val) {
                  _setTime = val!;
                },
                enabled: false,
                keyboardType: TextInputType.text,
                controller: _timeController,
                decoration: InputDecoration(
                    disabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    // labelText: 'Time',
                    contentPadding: EdgeInsets.all(5)),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white)),
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              'Music helps you sleep better',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Tap to play gamma song',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.music_note_rounded,
                          color: Colors.white,
                          size: 35,
                        ))
                  ],
                )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Track My Sleep'),
              style: trackButtonStyle,
            ),
          ),
        ],
      ),
    );
  }
}
