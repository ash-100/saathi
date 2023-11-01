// ignore_for_file: file_names

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

class Temperature extends StatefulWidget {
  const Temperature({Key? key}) : super(key: key);

  @override
  State<Temperature> createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  List<TemperatureData> _chartTempData = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    var url =
        'https://api.thingspeak.com/channels/1676371/fields/1.json?api_key=COMASRO9RCKNDBLK&results=2';

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse(url));
    var feeds = [];
    List<TemperatureData> _data = [];
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      feeds = jsonResponse['feeds'];
      //print(itemCount);
      for (int i = 0; i < feeds.length; i++) {
        if (feeds[i]['field1'].toString().trim() == '' ||
            feeds[i]['field1'] == null) {
          //continue;
          _data.add(TemperatureData(
              feeds[i]["created_at"].toString(), double.parse('12')));
        } else {
          _data.add(TemperatureData(feeds[i]["created_at"].toString(),
              double.parse(feeds[i]['field1'].toString())));
        }
        //print(fds[i].)
        //print(feeds[i]['field1']);

      }
      setState(() {
        _chartTempData = _data;
      });
      print('hi');
      print(_chartTempData);
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
          Container(
              child: SfCartesianChart(
                  // Initialize category axis
                  primaryXAxis: CategoryAxis(
                      title: AxisTitle(
                    text: 'Reading Time',
                  )),
                  series: <LineSeries<TemperatureData, String>>[
                LineSeries<TemperatureData, String>(
                    // Bind data source
                    markerSettings:
                        MarkerSettings(isVisible: true, color: Colors.black),
                    dataSource: _chartTempData,
                    xValueMapper: (TemperatureData d, _) =>
                        d.date_time.substring(11, d.date_time.length - 1),
                    yValueMapper: (TemperatureData d, _) => d.temperature),
              ])),
        ],
      ),
    );
  }
}

class TemperatureData {
  TemperatureData(this.date_time, this.temperature);
  final String date_time;
  final double temperature;
}
