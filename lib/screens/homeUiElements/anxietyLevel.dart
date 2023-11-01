// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:saathi/screens/ui/anxietyExercise.dart';
import 'package:saathi/screens/ui/anxietyLevelInsights.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnxietyLevel extends StatefulWidget {
  const AnxietyLevel({Key? key}) : super(key: key);

  @override
  State<AnxietyLevel> createState() => _AnxietyLevelState();
}

class _AnxietyLevelState extends State<AnxietyLevel> {
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
                      'Anxiety Attack',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => AnxietyLevelInsights()));
                    },
                    icon: Icon(Icons.arrow_forward))
              ],
            ),
            //SfCartesianChart(),
            Container(
              height: 300,
              child: Image.asset('assets/images/anxietyChart.png'),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                'Your anxiety level has crossed the set threshold. Take deep breaths. Lets do an exercise for a minute',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnxietyExercise()));
                },
                child: Text('Begin'),
                style: ElevatedButton.styleFrom(
                    primary: HexColor('#b7e1d8'),
                    onPrimary: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
