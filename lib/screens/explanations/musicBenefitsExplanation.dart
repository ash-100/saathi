import 'package:flutter/material.dart';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:saathi/model/deepBreathingExercises.dart';
import 'package:saathi/model/meditationExplanation.dart';
import 'package:saathi/screens/ui/music.dart';

class MusicBenefitsExplanation extends StatelessWidget {
  List<String> musicBenefits = [
    'Music can provide a distraction',
    'Listening to music can increase productivity',
    'Certain music can help with sleep',
    'Listening to music can help to keep the brain young',
    'Singing along to music is great for the soul',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Listening to Music',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          GFCard(
            boxFit: BoxFit.cover,
            titlePosition: GFPosition.start,
            showOverlayImage: true,
            imageOverlay: AssetImage(
              '',
            ),
            title: GFListTile(
              avatar: GFAvatar(
                  backgroundImage: AssetImage('assets/images/lifestyle.jpg')),
              titleText: 'Benefits of Music',
            ),
            content: BulletedList(listItems: musicBenefits),
          ),
          GFButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Music()));
            },
            text: 'Listen to Music',
            color: HexColor('#AFE0D8'),
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
