// ignore_for_file: file_names

import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:saathi/screens/sensorReadings/ecg.dart';
import 'package:saathi/screens/sensorReadings/pulseRate.dart';
import 'package:saathi/screens/sensorReadings/spo2.dart';
import 'package:saathi/screens/sensorReadings/temperature.dart';
import 'package:saathi/screens/ui/anxietyExercise.dart';
import 'package:saathi/screens/ui/anxietyLevelInsights.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../sensorReadings/temperatureNew.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:developer';

class VariousInsights extends StatefulWidget {
  const VariousInsights({Key? key}) : super(key: key);

  @override
  State<VariousInsights> createState() => _VariousInsightsState();
}

class _VariousInsightsState extends State<VariousInsights> {
  double temperature = 68;
  double pulse = 0;
  double spo2 = 0;
  late Timer timer;
  AudioPlayer player = AudioPlayer();
  bool tempWarnOnce = false;
  bool pulseWarnOnce = false;

  // Future<QuerySnapshot<Map<String, dynamic>>> lastTemp = FirebaseFirestore
  //     .instance
  //     .collection('users')
  //     .doc('uid7')
  //     .collection('sensorReadings')
  //     .snapshots()
  //     .last;
  // void display() async {
  //   print(lastTemp.toString());
  // }
  void convertTempAndSetState(String s) {
    double c = double.parse(s.trim());
    //double f = (1.8 * c) + 32;
    c.roundToDouble();
    c.toStringAsPrecision(2);
    //print(f);
    if (mounted) {
      setState(() {
        temperature = c;
      });
    }
  }

  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
      .collection('users')
      .doc('uid7')
      .collection('sensorReadings')
      .orderBy('a')
      .limitToLast(1)
      .snapshots();

  Future<void> getData() async {
    var url = 'http://192.168.180.241/';

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse(url));
    var feeds = [];
    //print(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      //print('hi');
      //print(jsonResponse);
      int length = (jsonResponse[' OBJ TEMP MLX'].length);
      //print(jsonResponse[" OBJ TEMP MLX"]['0']);
      convertTempAndSetState(jsonResponse[" OBJ TEMP MLX"]['0'].toString());

      if (mounted) {
        setState(() {
          pulse = jsonResponse['HEARTRATE']['0'];
          spo2 = jsonResponse['SpO2 %']['0'];
        });
      }

      if (pulse > 100 && mounted && !pulseWarnOnce) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'))
            ],
            title: Text('Pulse'),
            content: Text('Your pulse is high'),
          ),
        );
        await player.play(AssetSource('audios/loud-beepy-alarm-81101.mp3'));
        setState(() {
          pulseWarnOnce = true;
        });
      }
      if (temperature > 100 && mounted && !tempWarnOnce) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'))
            ],
            title: Text('Temperature'),
            content: Text('Your temperature is high'),
          ),
        );
        await player.play(AssetSource('audios/loud-beepy-alarm-81101.mp3'));
        setState(() {
          tempWarnOnce = true;
        });
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //display();
  }

  void start() {
    Timer.run(() {
      Future.delayed(Duration(seconds: 1), () {
        getData();
      });
    });
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      Future.delayed(Duration(seconds: 1), () {
        getData();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 460,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: HexColor('#83CF9D'))),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Vitals',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => AnxietyLevelInsights()));
                        },
                        icon: Icon(Icons.arrow_forward))
                  ],
                ),
                //SfCartesianChart(),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                height: 105,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: HexColor('A0DAB4'))),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: Text(
                                            'ECG',
                                            //style: TextStyle(fontSize: 25),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Ecg()));
                                          },
                                          icon: Icon(Icons.arrow_forward))
                                    ],
                                  ),
                                  Container(
                                    height: 30,
                                    child: Image.asset('assets/images/ecg.png'),
                                  ),
                                ]),
                              ),
                            ),
                          ),

                          // Add here
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                height: 105,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: HexColor('A0DAB4'))),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: (temperature < 86
                                              ? Text(
                                                  'Ambient Temperature',
                                                )
                                              : Text(
                                                  'Body Temperature',
                                                )),
                                        ),
                                      ),
                                      IconButton(
                                          padding: EdgeInsets.all(4.0),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TemperatureNewReading()));
                                          },
                                          icon: Icon(Icons.arrow_forward,
                                              size: 20))
                                    ],
                                  ),
                                  Container(
                                    height: 30,
                                    child: Text(
                                      ((temperature.toStringAsFixed(2) + 'F')),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  // Container(
                                  //   padding: EdgeInsets.symmetric(
                                  //       horizontal: 10, vertical: 3),
                                  //   decoration: BoxDecoration(
                                  //       color: HexColor('#AFE0D8'),
                                  //       borderRadius:
                                  //           BorderRadius.circular(10)),
                                  //   child: Text('Normal'),
                                  // )
                                ]),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                height: 105,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: HexColor('A0DAB4'))),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 3),
                                            child: Text(
                                              'SPO2 Level',
                                              //style: TextStyle(fontSize: 25),
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Spo2()));
                                          },
                                          icon: Icon(Icons.arrow_forward,
                                              size: 20))
                                    ],
                                  ),
                                  Container(
                                    height: 30,
                                    child: Text(
                                      spo2.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  // Container(
                                  //   padding: EdgeInsets.symmetric(
                                  //       horizontal: 10, vertical: 3),
                                  //   decoration: BoxDecoration(
                                  //       color: HexColor('#AFE0D8'),
                                  //       borderRadius:
                                  //           BorderRadius.circular(10)),
                                  //   child: Text('Normal'),
                                  // )
                                ]),
                              ),
                            ),
                          ),
                          // Add pulse

                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                height: 105,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: HexColor('A0DAB4'))),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: Text(
                                            'Pulse Rate',
                                            //style: TextStyle(fontSize: 25),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PulseRate()));
                                          },
                                          icon: Icon(Icons.arrow_forward,
                                              size: 20))
                                    ],
                                  ),
                                  Expanded(
                                    //height: 30,
                                    child: Text(
                                      pulse.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          start();
                        },
                        child: Text('Start'),
                        style: ElevatedButton.styleFrom(
                            primary: HexColor('#b7e1d8'),
                            onPrimary: Colors.black,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 70),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)))),
                      )),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          print('timer cancelled');
                          timer.cancel();
                          setState(() {
                            tempWarnOnce = false;
                            pulseWarnOnce = false;
                          });
                        },
                        child: Text('Stop'),
                        style: ElevatedButton.styleFrom(
                            primary: HexColor('#b7e1d8'),
                            onPrimary: Colors.black,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 70),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)))),
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
    print('timer canceled');
  }
}
