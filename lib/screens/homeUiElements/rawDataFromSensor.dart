// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:saathi/screens/ui/rawData.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RawDataFromSensor extends StatefulWidget {
  const RawDataFromSensor({Key? key}) : super(key: key);
  @override
  State<RawDataFromSensor> createState() => _RawDataFromSensorState();
}

class _RawDataFromSensorState extends State<RawDataFromSensor> {
  @override
  Widget build(BuildContext context) {
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
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Raw Data',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RawData()));
                    },
                    icon: Icon(Icons.arrow_forward))
              ],
            ),
            // Padding(
            //   padding: EdgeInsets.all(15),
            //   child: Text(
            //     'A well sleep is a sign of lower risk for serious health problems, like diabetes and heart disease',
            //     style: TextStyle(fontSize: 16),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
