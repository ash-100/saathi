import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:syncfusion_flutter_charts/charts.dart';

class TemperatureNewReading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TemperatureReadingState();
}

class _TemperatureReadingState extends State<TemperatureNewReading> {
  List<TemperatureData> tempData = [];
  List<TemperatureData> tempDataInF = [];

  CollectionReference _collectionRef = FirebaseFirestore.instance
      .collection('users')
      .doc('uid5')
      .collection('sensorReadings');
  int c = 1;
  late Timer timer;
  void start() {
    Timer.run(() {
      Future.delayed(Duration(seconds: 1), () {
        getTempData();
      });
    });
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      Future.delayed(Duration(seconds: 1), () {
        getTempData();
      });
    });
  }

  Future<List<TemperatureData>> getTempData() async {
    var url = 'http://192.168.180.241/';
    print('temp C');
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse(url));
    var feeds = [];
    List<TemperatureData> _data = tempData;
    List<TemperatureData> _dataInF = tempDataInF;
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      //feeds = jsonResponse[' OBJ TEMP MLX'];
      // var fields = feeds[0]['fields']['ACC_X']['doubleValue'];
      //print(jsonResponse);
      var t = jsonResponse[' OBJ TEMP MLX'];
      print(t['0']);

      // for (int i = 0; i < 6; i++) {
      //   if (t[i.toString()] == null) continue;
      //   _data.add(TemperatureData(i.toString(), t[i.toString()]));
      //   _dataInF
      //       .add(TemperatureData(i.toString(), (1.8 * t[i.toString()]) + 32));
      // }
      if (_data.length > 40) {
        _data.removeAt(0);
      }
      if (_dataInF.length > 40) {
        _dataInF.removeAt(0);
      }

      _data.add(TemperatureData(c.toString(), (t['0'])));
      _dataInF.add(TemperatureData(c.toString(), (t['0'])));

      c++;
      if (mounted && _data.length > 0) {
        setState(() {
          tempData = _data;
          tempDataInF = _dataInF;
        });
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return _data;
  }

  // Future<List<TemperatureData>> getTempDataInF() async {
  //   var url =
  //       'https://firestore.googleapis.com/v1/projects/saathi-v2/databases/(default)/documents/users/uid5/sensorReadings';

  //   // Await the http get response, then decode the json-formatted response.
  //   var response = await http.get(Uri.parse(url));
  //   var feeds = [];
  //   List<TemperatureData> _data = [];
  //   if (response.statusCode == 200) {
  //     var jsonResponse = convert.jsonDecode(response.body);
  //     feeds = jsonResponse['documents'];
  //     // var fields = feeds[0]['fields']['ACC_X']['doubleValue'];
  //     // print(fields);
  //     for (int i = 0; i < feeds.length; i++) {
  //       if (feeds[i]['fields']['TEMP F']['doubleValue'] == null) continue;
  //       _data.add(TemperatureData(
  //           i.toString(), feeds[i]['fields']['TEMP F']['doubleValue']));
  //     }
  //     if (mounted) {
  //       setState(() {
  //         tempDataInF = _data;
  //       });
  //     }
  //   } else {
  //     print('Request failed with status: ${response.statusCode}.');
  //   }
  //   return _data;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start();
    getTempData();
    //getTempDataInF();
    // getData();
    //getTempData('2');
  }

  String dropdownvalue = 'Celcius';
  var tempOptions = ['Celcius', 'Fahrenheit'];
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .doc('uid5')
      .collection('sensorReadings')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature'),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Column(children: [
        Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Temperature in C',
            style: TextStyle(fontSize: 25),
          ),
        )),
        FutureBuilder(
            future: getTempData(),
            builder: (context, snapshot) {
              return SfCartesianChart(
                  // Initialize category axis
                  primaryXAxis: CategoryAxis(
                      title: AxisTitle(
                    text: 'Reading Time',
                  )),
                  series: <LineSeries<TemperatureData, String>>[
                    LineSeries<TemperatureData, String>(
                        // Bind data source
                        markerSettings: MarkerSettings(
                          isVisible: false,
                        ),
                        dataSource: tempData,
                        xValueMapper: (TemperatureData d, _) => d.date_time,
                        yValueMapper: (TemperatureData d, _) => d.temperature)
                  ]);
            }),
        Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Temperature in F',
            style: TextStyle(fontSize: 25),
          ),
        )),
        Expanded(
          child: FutureBuilder(
              future: getTempData(),
              builder: (context, snapshot) {
                return SfCartesianChart(
                    // Initialize category axis
                    primaryXAxis: CategoryAxis(
                        title: AxisTitle(
                      text: 'Reading Time',
                    )),
                    series: <LineSeries<TemperatureData, String>>[
                      LineSeries<TemperatureData, String>(
                          // Bind data source
                          markerSettings: MarkerSettings(
                            isVisible: false,
                          ),
                          dataSource: tempDataInF,
                          xValueMapper: (TemperatureData d, _) => d.date_time,
                          yValueMapper: (TemperatureData d, _) => d.temperature)
                    ]);
              }),
        ),
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

class TemperatureData {
  TemperatureData(this.date_time, this.temperature);
  final String date_time;
  final double temperature;
}
