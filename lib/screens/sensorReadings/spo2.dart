import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:syncfusion_flutter_charts/charts.dart';

class Spo2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Spo2State();
}

class _Spo2State extends State<Spo2> {
  List<Spo2Data> spo2Data = [];
  late Timer timer;
  int c = 1;
  void start() {
    Timer.run(() {
      Future.delayed(Duration(seconds: 1), () {
        getSpo2Data();
      });
    });
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      Future.delayed(Duration(seconds: 1), () {
        getSpo2Data();
      });
    });
  }

  Future<List<Spo2Data>> getSpo2Data() async {
    var url = 'http://192.168.180.241/';

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse(url));
    var feeds = [];
    List<Spo2Data> _data = spo2Data;
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      //feeds = jsonResponse['documents'];
      var s = jsonResponse['SpO2 %'];

      // for (int i = 0; i < feeds.length; i++) {
      //   if (feeds[i]['fields']['SpO2 %']['doubleValue'] == null) continue;
      //   _data.add(Spo2Data(i.toString(),
      //       feeds[i]['fields']['SpO2 %']['doubleValue'].toDouble()));
      // }
      if (_data.length > 40) {
        _data.removeAt(0);
      }
      if (s['0'] != null) _data.add(Spo2Data(c.toString(), s['0'].toDouble()));
      c++;
      if (mounted) {
        setState(() {
          spo2Data = _data;
        });
      }
    } else {
      print(
          'Request failed with status: ${response.statusCode} ${response.body}.');
    }
    return _data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start();
    getSpo2Data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spo2'),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Column(children: [
        Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Spo2',
            style: TextStyle(fontSize: 25),
          ),
        )),
        FutureBuilder(
            future: getSpo2Data(),
            builder: (context, snapshot) {
              return SfCartesianChart(
                  // Initialize category axis
                  primaryXAxis: CategoryAxis(
                      title: AxisTitle(
                    text: 'Reading Time',
                  )),
                  series: <LineSeries<Spo2Data, String>>[
                    LineSeries<Spo2Data, String>(
                        // Bind data source
                        markerSettings: MarkerSettings(
                          isVisible: false,
                        ),
                        dataSource: spo2Data,
                        xValueMapper: (Spo2Data d, _) => d.date_time,
                        yValueMapper: (Spo2Data d, _) => d.spo2)
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

class Spo2Data {
  Spo2Data(this.date_time, this.spo2);
  final String date_time;
  final double spo2;
}
