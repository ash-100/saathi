import 'package:flutter/material.dart';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:saathi/model/deepBreathingExercises.dart';
import 'package:saathi/screens/ui/alternateNostrilBreathing.dart';
import 'package:saathi/screens/ui/boxBreathing.dart';
import 'package:saathi/screens/ui/breathingExercise.dart';

class BreathingExerciseExplanation extends StatelessWidget {
  List<String> alternateNostrilBreathing = [
    'Position your right hand by bending your pointer and middle fingers into your palm, leaving your thumb, ring finger, and pinky extended. This is known as Vishnu mudra in yoga.',
    'Close your eyes or softly gaze downward.',
    'Inhale and exhale to begin.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Deep Breathing Exercise',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: deepBreathingExercises.length,
                itemBuilder: (context, index) {
                  return Exercise(
                      context,
                      deepBreathingExercises[index].name,
                      deepBreathingExercises[index].desc,
                      deepBreathingExercises[index].procedure);
                }),
          )
        ],
      ),
    );
  }

  Widget Exercise(BuildContext context, String _name, String _desc,
      List<String> _procedure) {
    return GFCard(
      boxFit: BoxFit.cover,
      titlePosition: GFPosition.start,
      showOverlayImage: true,
      imageOverlay: AssetImage(
        '',
      ),
      title: GFListTile(
        avatar: GFAvatar(
            backgroundImage: AssetImage('assets/images/lifestyle.jpg')),
        titleText: _name,
        subTitleText: '',
      ),
      buttonBar: GFButtonBar(children: [
        GFButton(
          onPressed: () {
            if (_name == 'Belly Breathing') {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BreathingExercise()));
            } else if (_name == 'Sama Vritti Pranayama / Box Breathing') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BoxBreathingExercise()));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NostrilBreathingExercise()));
            }
          },
          text: 'Start',
          color: HexColor('#AFE0D8'),
          textColor: Colors.black,
        )
      ]),
      content: Column(
        children: [Text(_desc), BulletedList(listItems: _procedure)],
      ),
    );
  }
}



// Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               _name,
//               style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               _desc,
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//           BulletedList(
//             listItems: _procedure,
//             style: TextStyle(fontSize: 15),
//           ),
//           Divider(
//             thickness: 2,
//           )
//         ],
//       ),
//     )