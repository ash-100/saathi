import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:syncfusion_flutter_charts/charts.dart';

class TemperatureReading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TemperatureReadingState();
}

class _TemperatureReadingState extends State<TemperatureReading> {
  List<TemperatureData> tempData = [];
  Future<void> getTempData() async {
    var url =
        'https://ap-south-1.aws.data.mongodb-api.com/app/sih-whmvb/endpoint/api';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse.length);
      List<TemperatureData> _tempData = [];
      for (int i = 0; i < jsonResponse.length; i++) {
        _tempData.add(TemperatureData(
            i.toString(), jsonResponse[i]['TEMP C lm35'].toDouble()));
      }
      print(jsonResponse[0]['TEMP C lm35']);
      if (mounted) {
        setState(() {
          tempData = _tempData;
        });
      }
    }
  }

  Future<void> getTempDataInF() async {
    var url =
        'https://ap-south-1.aws.data.mongodb-api.com/app/sih-whmvb/endpoint/api';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse.length);
      List<TemperatureData> _tempData = [];
      for (int i = 0; i < jsonResponse.length; i++) {
        if (jsonResponse[i]['TEMP F lm 35'].toString().trim().isNotEmpty) {
          _tempData.add(TemperatureData(
              i.toString(), jsonResponse[i]['TEMP F lm 35'].toDouble()));
        }
      }
      print(jsonResponse[0]['TEMP F lm35']);
      if (mounted) {
        setState(() {
          tempData = _tempData;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTempData();
  }

  String dropdownvalue = 'Celcius';
  var tempOptions = ['Celcius', 'Fahrenheit'];

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
            'Temperature',
            style: TextStyle(fontSize: 25),
          ),
        )),
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
                    markerSettings: MarkerSettings(
                      isVisible: true,
                    ),
                    dataSource: tempData,
                    xValueMapper: (TemperatureData d, _) => d.date_time,
                    yValueMapper: (TemperatureData d, _) => d.temperature)
              ]),
        ),
        ElevatedButton(
            onPressed: () {
              getTempData();
            },
            child: Text('Celcius')),
        ElevatedButton(
            onPressed: () {
              getTempDataInF();
            },
            child: Text('Fahrenheit')),
      ]),
    );
  }
}

class TemperatureData {
  TemperatureData(this.date_time, this.temperature);
  final String date_time;
  final double temperature;
}
