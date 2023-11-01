import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:syncfusion_flutter_charts/charts.dart';

class Ecg extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EcgState();
}

class _EcgState extends State<Ecg> {
  List<EcgData> ecgData = [];
  late Timer timer;
  int c = 1;
  void start() {
    Timer.run(() {
      Future.delayed(Duration(seconds: 1), () {
        getEcgData();
      });
    });
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      Future.delayed(Duration(seconds: 1), () {
        getEcgData();
      });
    });
  }

  Future<List<EcgData>> getEcgData() async {
    var url = 'http://192.168.180.241/';

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse(url));

    List<EcgData> _data = ecgData;
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var res = jsonResponse['ECG'];
      if (_data.length > 40) _data.removeAt(0);
      _data.add(EcgData(c.toString(), res['0'].toDouble()));
      c++;

      // for (int i = 0; i < feeds.length; i++) {
      //   if (feeds[i]['fields']['Heartrate']['integerValue'] == null) continue;
      //   _data.add(EcgData(i.toString(),
      //       double.parse(feeds[i]['fields']['Heartrate']['integerValue'])));
      // }
      if (mounted) {
        setState(() {
          ecgData = _data;
        });
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return _data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start();
    getEcgData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ECG'),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Column(children: [
        Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'ECG',
            style: TextStyle(fontSize: 25),
          ),
        )),
        FutureBuilder(
            future: getEcgData(),
            builder: (context, snapshot) {
              return SfCartesianChart(
                  // Initialize category axis
                  primaryXAxis: CategoryAxis(
                      title: AxisTitle(
                    text: 'Reading Time',
                  )),
                  series: <LineSeries<EcgData, String>>[
                    LineSeries<EcgData, String>(
                        // Bind data source
                        markerSettings: MarkerSettings(
                          isVisible: false,
                        ),
                        dataSource: ecgData,
                        xValueMapper: (EcgData d, _) => d.date_time,
                        yValueMapper: (EcgData d, _) => d.heartRate)
                  ]);
            }),
      ]),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }
}

class EcgData {
  EcgData(this.date_time, this.heartRate);
  final String date_time;
  final double heartRate;
}
