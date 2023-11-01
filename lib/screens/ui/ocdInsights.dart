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

class OcdInsights extends StatefulWidget {
  const OcdInsights({Key? key}) : super(key: key);

  @override
  State<OcdInsights> createState() => _OcdInsightsState();
}

class _OcdInsightsState extends State<OcdInsights> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    'Compulsion 1',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              // SfCartesianChart(),
              Container(
                height: 280,
                child: Image.asset('assets/images/ocdChart1.png'),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'You have exceeded your limit on the repetativeness of this compulsion. We suggest you to take some preventive action and relieve yourself',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    'Compulsion 2',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              // SfCartesianChart(),
              Container(
                height: 280,
                child: Image.asset('assets/images/ocdChart2.png'),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Goodjob! You have been able to control yourself. Keep the good work and do not forget to share your experience',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ));
  }
}
