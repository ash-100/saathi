import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:saathi/screens/ui/anxietyLevelInsights.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../ui/anxietyExercise.dart';
import '../ui/stressExercise.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class StressLevel extends StatefulWidget {
  const StressLevel({Key? key}) : super(key: key);

  @override
  State<StressLevel> createState() => _StressLevelState();
}

class _StressLevelState extends State<StressLevel> {
  late Timer timer;
  double percent = 0.0;
  AudioPlayer player = AudioPlayer();
  @override
  void initState() {
    setState(() {
      percent = 0;
    });
    super.initState();
  }

  void start() {
    Timer.run(() {
      Future.delayed(Duration(seconds: 25), () {
        getData();
      });
    });
    timer = Timer.periodic(Duration(seconds: 50), (timer) {
      Future.delayed(Duration(seconds: 25), () {
        getData();
      });
    });
  }

  bool stressWarnOnce = false;
  Future<void> getData() async {
    var url = 'http://192.168.180.241/ml';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonReponse = convert.jsonDecode(response.body);
      var stressValue = jsonReponse['stress']['0'];
      print('stress');
      print(stressValue);
      var _percent = 0;
      if (stressValue == 0) {
        _percent = 0;
      } else if (stressValue == 1) {
        _percent = 25;
      } else if (stressValue == 2) {
        _percent = 50;
      } else if (stressValue == 3) {
        _percent = 75;
      }
      if (mounted) {
        setState(() {
          percent = _percent.toDouble();
        });
      }
      if (percent > 50 && mounted && !stressWarnOnce) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('CANCEL')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StressExercise()));
                  },
                  child: Text('Stress Relief'))
            ],
            title: Text('Stress'),
            content: Text('You are stressed right now'),
          ),
        );
        await player.play(AssetSource('audios/loud-beepy-alarm-81101.mp3'));
        setState(() {
          stressWarnOnce = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //percent = 10;
    return Padding(
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Stress Levels',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ),
                // IconButton(
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => AnxietyLevelInsights()));
                //     },
                //     icon: Icon(Icons.arrow_forward))
              ],
            ),
            Container(
              height: 250,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    showLabels: false,
                    showTicks: false,
                    axisLineStyle: AxisLineStyle(
                        thickness: 0.2,
                        cornerStyle: CornerStyle.bothCurve,
                        color: Color.fromARGB(30, 0, 169, 181),
                        thicknessUnit: GaugeSizeUnit.factor),
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: percent,
                        cornerStyle: CornerStyle.bothCurve,
                        width: 0.2,
                        sizeUnit: GaugeSizeUnit.factor,
                        color: HexColor('#b7e1d8'),
                      )
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        positionFactor: 0.1,
                        angle: 90,
                        widget: Text(percent.toString() + "%"),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                'Just deep breathes can control almost all kinds of stress. So, lets do an excercise for a minute',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StressExercise()));
                },
                child: Text('Begin Exercise'),
                style: ElevatedButton.styleFrom(
                    primary: HexColor('#b7e1d8'),
                    onPrimary: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)))),
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
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 70),
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
                        stressWarnOnce = false;
                      });
                    },
                    child: Text('Stop'),
                    style: ElevatedButton.styleFrom(
                        primary: HexColor('#b7e1d8'),
                        onPrimary: Colors.black,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 70),
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
    );
  }
}
