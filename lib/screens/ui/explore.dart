import 'package:flutter/material.dart';
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:saathi/screens/ui/meditate.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  final beginButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black,
      primary: HexColor('#AFE0D8'),
      padding: EdgeInsets.all(15),
      minimumSize: Size(double.maxFinite, 30),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2))));
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Text(
              'Explore',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Quick activities to calm yourself',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )),
        Row(
          children: [
            Expanded(
                child: Column(
              children: [
                Container(
                  //height:
                  child: IconButton(
                    iconSize: 150,
                    icon: Image.asset('assets/images/meditation.png'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Meditate()));
                    },
                  ),
                ),
                Text('Meditate'),
              ],
            )),
            Expanded(
                child: Column(
              children: [
                Container(
                  //height:
                  child: IconButton(
                    iconSize: 150,
                    icon: Image.asset('assets/images/music.png'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Meditate()));
                    },
                  ),
                ),
                Text('Listen to Music'),
              ],
            )),
            Expanded(
                child: Column(
              children: [
                Container(
                  //height: ,
                  child: IconButton(
                    iconSize: 150,
                    icon: Image.asset('assets/images/games.png'),
                    onPressed: () {},
                  ),
                ),
                Text('Work Mode'),
              ],
            ))
          ],
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            Container(
              child: Image.asset('assets/images/assessment.png'),
            ),
            Padding(
                padding: EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Take a quick self assessment',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Begin'),
                style: beginButtonStyle,
              ),
            ),
          ]),
        )
      ],
    );
  }
}
