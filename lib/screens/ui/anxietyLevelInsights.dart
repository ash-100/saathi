// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:saathi/screens/ui/stressExercise.dart';
import 'package:saathi/screens/ui/temperature.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../auth/googleSignIn.dart';
import '../login.dart';

class AnxietyLevelInsights extends StatefulWidget {
  const AnxietyLevelInsights({Key? key}) : super(key: key);

  @override
  State<AnxietyLevelInsights> createState() => _AnxietyLevelInsightsState();
}

class _AnxietyLevelInsightsState extends State<AnxietyLevelInsights> {
  final beginButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black,
      primary: HexColor('#AFE0D8'),
      padding: EdgeInsets.all(15),
      minimumSize: Size(double.maxFinite, 30),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2))));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text(
                'Anxiety Level Insights',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          // SfCartesianChart(),
          Expanded(
            child: Container(
              height: 280,
              child: Image.asset('assets/images/anxietyChart.png'),
            ),
          ),
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
                              border: Border.all(color: HexColor('A0DAB4'))),
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
                                    onPressed: () {},
                                    icon: Icon(Icons.arrow_forward))
                              ],
                            ),
                            Container(
                              height: 30,
                              child: Image.asset('assets/images/ecg.png'),
                            ),
                            // Container(
                            //   padding: EdgeInsets.symmetric(
                            //       horizontal: 10, vertical: 3),
                            //   decoration: BoxDecoration(
                            //       color: HexColor('#AFE0D8'),
                            //       borderRadius: BorderRadius.circular(10)),
                            //   child: Text('Normal'),
                            // )
                          ]),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          height: 105,
                          decoration: BoxDecoration(
                              border: Border.all(color: HexColor('A0DAB4'))),
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
                                    onPressed: () {},
                                    icon: Icon(Icons.arrow_forward))
                              ],
                            ),
                            Container(
                              height: 30,
                              child: Text(
                                '120',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            // Container(
                            //   padding: EdgeInsets.symmetric(
                            //       horizontal: 10, vertical: 3),
                            //   decoration: BoxDecoration(
                            //       color: HexColor('#AFE0D8'),
                            //       borderRadius: BorderRadius.circular(10)),
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
                              border: Border.all(color: HexColor('A0DAB4'))),
                          child: Column(children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      'SPO2 Level',
                                      //style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.arrow_forward))
                              ],
                            ),
                            Container(
                              height: 30,
                              child: Text(
                                '93.3%',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            // Container(
                            //   padding: EdgeInsets.symmetric(
                            //       horizontal: 10, vertical: 3),
                            //   decoration: BoxDecoration(
                            //       color: HexColor('#AFE0D8'),
                            //       borderRadius: BorderRadius.circular(10)),
                            //   child: Text('Normal'),
                            // )
                          ]),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          height: 105,
                          decoration: BoxDecoration(
                              border: Border.all(color: HexColor('A0DAB4'))),
                          child: Column(children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      'Temperature',
                                      //style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.arrow_forward))
                              ],
                            ),
                            Container(
                              height: 30,
                              child: Text(
                                '97 F',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            // Container(
                            //   padding: EdgeInsets.symmetric(
                            //       horizontal: 10, vertical: 3),
                            //   decoration: BoxDecoration(
                            //       color: HexColor('#AFE0D8'),
                            //       borderRadius: BorderRadius.circular(10)),
                            //   child: Text('Normal'),
                            // )
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
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StressExercise()));
              },
              child: Text('Begin Exercise'),
              style: beginButtonStyle,
            ),
          ),
        ],
      ),
    );
  }
}
