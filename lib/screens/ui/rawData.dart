// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../auth/googleSignIn.dart';
import '../login.dart';

class RawData extends StatefulWidget {
  const RawData({Key? key}) : super(key: key);

  @override
  State<RawData> createState() => _RawDataState();
}

class _RawDataState extends State<RawData> {
  List<TemperatureData> _chartTempData = [];
  List<BPMData> _chartBPMData = [];
  List<accXData> _chartAccXData = [];
  List<accYData> _chartAccYData = [];
  List<accZData> _chartAccZData = [];
  late Timer timer;

  @override
  void initState() {
    // getTempData();
    // getBPMData();
    // getAccXData();
    // getAccYData();
    // getAccZData();
    Timer.run(() {
      Future.delayed(Duration(seconds: 5), () {
        print('1');
        getTempData();
      });
      Future.delayed(Duration(seconds: 10), () {
        print('2');
        getBPMData();
      });
      Future.delayed(Duration(seconds: 15), () {
        print('3');
        getAccXData();
      });
      Future.delayed(Duration(seconds: 20), () {
        print('4');
        getAccYData();
      });
      Future.delayed(Duration(seconds: 25), () {
        print('5');
        getAccZData();
      });
    });
    timer = Timer.periodic(Duration(seconds: 30), (Timer t) {
      Future.delayed(Duration(seconds: 5), () {
        print('1');
        getTempData();
      });
      Future.delayed(Duration(seconds: 10), () {
        print('2');
        getBPMData();
      });
      Future.delayed(Duration(seconds: 15), () {
        print('3');
        getAccXData();
      });
      Future.delayed(Duration(seconds: 20), () {
        print('4');
        getAccYData();
      });
      Future.delayed(Duration(seconds: 25), () {
        print('5');
        getAccZData();
      });
    });

    super.initState();
  }

  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> getTempData() async {
    var url =
        'https://api.thingspeak.com/channels/1683675/fields/1.json?api_key=2GBTO37APCBTSEQ1&results=20';

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse(url));
    var feeds = [];
    List<TemperatureData> _data = [];
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      feeds = jsonResponse['feeds'];
      for (int i = 0; i < feeds.length; i++) {
        if (feeds[i]['field1'].toString().trim() == '' ||
            feeds[i]['field1'] == null) {
          // _data.add(TemperatureData(
          //     feeds[i]["created_at"].toString(), double.parse('0')));
          continue;
        } else {
          _data.add(TemperatureData(feeds[i]["created_at"].toString(),
              double.parse(feeds[i]['field1'].toString())));
        }
      }
      if (mounted) {
        setState(() {
          _chartTempData = _data;
        });
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> getBPMData() async {
    var url =
        'https://api.thingspeak.com/channels/1683676/fields/1.json?api_key=UAIE1QJU4THM52BT&results=20';

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse(url));
    var feeds = [];
    List<BPMData> _data = [];
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      feeds = jsonResponse['feeds'];
      for (int i = 0; i < feeds.length; i++) {
        if (feeds[i]['field1'].toString().trim() == '' ||
            feeds[i]['field1'] == null) {
          // _data.add(
          //     BPMData(feeds[i]["created_at"].toString(), double.parse('0')));
          continue;
        } else {
          _data.add(BPMData(feeds[i]["created_at"].toString(),
              double.parse(feeds[i]['field1'].toString())));
        }
      }
      setState(() {
        _chartBPMData = _data;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> getAccXData() async {
    var url =
        'https://api.thingspeak.com/channels/1683677/fields/1.json?api_key=BEW331JR1N998WY6&results=10';

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse(url));
    var feeds = [];
    List<accXData> _data = [];
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      feeds = jsonResponse['feeds'];
      for (int i = 0; i < feeds.length; i++) {
        if (feeds[i]['field1'].toString().trim() == '' ||
            feeds[i]['field1'] == null) {
          // _data.add(
          //     accXData(feeds[i]["created_at"].toString(), double.parse('0')));
          continue;
        } else {
          _data.add(accXData(feeds[i]["created_at"].toString(),
              double.parse(feeds[i]['field1'].toString())));
        }
      }
      setState(() {
        _chartAccXData = _data;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> getAccYData() async {
    var url =
        'https://api.thingspeak.com/channels/1683675/fields/2.json?api_key=2GBTO37APCBTSEQ1&results=20';

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse(url));
    var feeds = [];
    List<accYData> _data = [];
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      feeds = jsonResponse['feeds'];
      for (int i = 0; i < feeds.length; i++) {
        if (feeds[i]['field2'].toString().trim() == '' ||
            feeds[i]['field2'] == null) {
          // _data.add(
          //     accYData(feeds[i]["created_at"].toString(), double.parse('0')));
          continue;
        } else {
          _data.add(accYData(feeds[i]["created_at"].toString(),
              double.parse(feeds[i]['field2'].toString())));
        }
      }
      setState(() {
        _chartAccYData = _data;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> getAccZData() async {
    var url =
        'https://api.thingspeak.com/channels/1683676/fields/2.json?api_key=UAIE1QJU4THM52BT&results=20';

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse(url));
    var feeds = [];
    List<accZData> _data = [];
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      feeds = jsonResponse['feeds'];
      for (int i = 0; i < feeds.length; i++) {
        if (feeds[i]['field2'].toString().trim() == '' ||
            feeds[i]['field2'] == null) {
          // _data.add(
          //     accZData(feeds[i]["created_at"].toString(), double.parse('0')));
          continue;
        } else {
          _data.add(accZData(feeds[i]["created_at"].toString(),
              double.parse(feeds[i]['field2'].toString())));
        }
      }
      setState(() {
        _chartAccZData = _data;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Center(
          child: Image.asset('assets/images/logo5.png'),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset('assets/images/darkModeIcon.png'))
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Center(child: Image.asset('assets/images/logo3.png')),
            ),
            ListTile(
              title: Text('Profile'),
            ),
            ListTile(
              title: Text('Log out'),
              onTap: () {
                print(FirebaseAuth
                    .instance.currentUser!.providerData[0].providerId);
                if (FirebaseAuth
                        .instance.currentUser!.providerData[0].providerId
                        .toString()
                        .trim() ==
                    'phone') {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                } else {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.logout();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                      (route) => false);
                }
              },
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text(
                'Temperature',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          Container(
              child: SfCartesianChart(
                  // Initialize category axis
                  primaryXAxis: CategoryAxis(
                      title: AxisTitle(
                    text: 'Reading Time',
                  )),
                  series: <LineSeries>[
                LineSeries<TemperatureData, String>(
                    markerSettings: MarkerSettings(
                      isVisible: true,
                    ),
                    dataSource: _chartTempData,
                    xValueMapper: (TemperatureData d, _) =>
                        d.date_time.substring(11, d.date_time.length - 1),
                    yValueMapper: (TemperatureData d, _) => d.temperature)
              ])),
          Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text(
                'Pulse',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          Container(
              child: SfCartesianChart(
                  // Initialize category axis
                  primaryXAxis: CategoryAxis(
                      title: AxisTitle(
                    text: 'Reading Time',
                  )),
                  series: <LineSeries<BPMData, String>>[
                LineSeries<BPMData, String>(
                    // Bind data source
                    markerSettings: MarkerSettings(
                      isVisible: true,
                    ),
                    dataSource: _chartBPMData,
                    xValueMapper: (BPMData d, _) =>
                        d.date_time.substring(11, d.date_time.length - 1),
                    yValueMapper: (BPMData d, _) => d.bpm)
              ])),
          Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text(
                'Acceleration in X-axis',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          Container(
              child: SfCartesianChart(
                  // Initialize category axis
                  primaryXAxis: CategoryAxis(
                      title: AxisTitle(
                    text: 'Reading Time',
                  )),
                  series: <LineSeries<accXData, String>>[
                LineSeries<accXData, String>(
                    // Bind data source
                    markerSettings: MarkerSettings(
                      isVisible: true,
                    ),
                    dataSource: _chartAccXData,
                    xValueMapper: (accXData d, _) =>
                        d.date_time.substring(11, d.date_time.length - 1),
                    yValueMapper: (accXData d, _) => d.ax)
              ])),
          Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text(
                'Acceleration in Y-axis',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          Container(
              child: SfCartesianChart(
                  // Initialize category axis
                  primaryXAxis: CategoryAxis(
                      title: AxisTitle(
                    text: 'Reading Time',
                  )),
                  series: <LineSeries<accYData, String>>[
                LineSeries<accYData, String>(
                    // Bind data source
                    markerSettings: MarkerSettings(
                      isVisible: true,
                    ),
                    dataSource: _chartAccYData,
                    xValueMapper: (accYData d, _) =>
                        d.date_time.substring(11, d.date_time.length - 1),
                    yValueMapper: (accYData d, _) => d.ay)
              ])),
          Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text(
                'Acceleration in Z-axis',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          Container(
              child: SfCartesianChart(
                  // Initialize category axis
                  primaryXAxis: CategoryAxis(
                      title: AxisTitle(
                    text: 'Reading Time',
                  )),
                  series: <LineSeries<accZData, String>>[
                LineSeries<accZData, String>(
                    // Bind data source
                    markerSettings: MarkerSettings(
                      isVisible: true,
                    ),
                    dataSource: _chartAccZData,
                    xValueMapper: (accZData d, _) =>
                        d.date_time.substring(11, d.date_time.length - 1),
                    yValueMapper: (accZData d, _) => d.az)
              ])),
        ],
      )),
    );
  }
}

class TemperatureData {
  TemperatureData(this.date_time, this.temperature);
  final String date_time;
  final double temperature;
}

class BPMData {
  BPMData(this.date_time, this.bpm);
  final String date_time;
  final double bpm;
}

class accXData {
  accXData(this.date_time, this.ax);
  final String date_time;
  final double ax;
}

class accYData {
  accYData(this.date_time, this.ay);
  final String date_time;
  final double ay;
}

class accZData {
  accZData(this.date_time, this.az);
  final String date_time;
  final double az;
}
