// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:saathi/screens/ui/ocdInsights.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Ocd extends StatefulWidget {
  const Ocd({Key? key}) : super(key: key);

  @override
  State<Ocd> createState() => _OcdState();
}

class _OcdState extends State<Ocd> {
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
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  'OCD Compulsion Chart',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            //SfCartesianChart(),
            Container(
              height: 300,
              child: Image.asset('assets/images/ocdChart.png'),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                'Repeatative actions tend to worsen OCD. A sharp increase has been observed recently. Lets try to find out more and find a relief to it',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OcdInsights()));
                },
                child: Text('Insights'),
                style: ElevatedButton.styleFrom(
                    primary: HexColor('#b7e1d8'),
                    onPrimary: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
