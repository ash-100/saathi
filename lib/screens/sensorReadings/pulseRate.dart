import 'dart:async';
import 'dart:developer';
//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:async/async.dart';

class PulseRate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PulseRateState();
}

class _PulseRateState extends State<PulseRate> {
  List<PulseRateData> pulseData = [];
  late Timer timer;
  int c = 1;
  void start() {
    Timer.run(() {
      Future.delayed(Duration(seconds: 1), () {
        getPulseRateData();
      });
    });
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      Future.delayed(Duration(seconds: 1), () {
        getPulseRateData();
      });
    });
  }

  Future<List<PulseRateData>> getPulseRateData() async {
    var url = 'http://192.168.180.241/'; //changed by me

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse(url));

    var feeds = [];
    List<PulseRateData> _data = pulseData;
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var p = jsonResponse['HEARTRATE'];

      // for (int i = 0; i < feeds.length; i++) {
      //   if (feeds[i]['fields']['HEARTRATE']['doubleValue'] == null) continue;
      //   _data.add(PulseRateData(i.toString(),
      //       (feeds[i]['fields']['HEARTRATE']['doubleValue']).toDouble()));
      // }
      if (_data.length > 40) {
        _data.removeAt(0);
      }
      if (p['0'] != null)
        _data.add(PulseRateData(c.toString(), p['0'].toDouble()));
      c++;
      if (mounted) {
        setState(() {
          pulseData = _data;
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
    getPulseRateData();
    // _cancelableOperation = CancelableOperation.fromFuture(getPulseRateData(),
    //     onCancel: () => 'Future function has been cancelled');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pulse'),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Column(children: [
        Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Pulse',
            style: TextStyle(fontSize: 25),
          ),
        )),
        FutureBuilder(
            future: getPulseRateData(),
            builder: (context, snapshot) {
              return SfCartesianChart(
                  // Initialize category axis
                  primaryXAxis: CategoryAxis(
                      title: AxisTitle(
                    text: 'Reading Time',
                  )),
                  series: <LineSeries<PulseRateData, String>>[
                    LineSeries<PulseRateData, String>(
                        // Bind data source
                        markerSettings: MarkerSettings(
                          isVisible: false,
                        ),
                        dataSource: pulseData,
                        xValueMapper: (PulseRateData d, _) => d.date_time,
                        yValueMapper: (PulseRateData d, _) => d.pulseRate)
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

class PulseRateData {
  PulseRateData(this.date_time, this.pulseRate);
  final String date_time;
  final double pulseRate;
}
