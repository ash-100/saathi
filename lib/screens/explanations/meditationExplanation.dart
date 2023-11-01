import 'package:flutter/material.dart';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:saathi/model/deepBreathingExercises.dart';
import 'package:saathi/model/meditationExplanation.dart';
import 'package:saathi/screens/ui/meditate.dart';

class MeditationExerciseExplanation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Meditation',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: mediationExerciseExplanations.length,
                itemBuilder: (context, index) {
                  return Exercise(
                    context,
                    mediationExerciseExplanations[index].name,
                    mediationExerciseExplanations[index].desc,
                  );
                }),
          ),
          GFButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Meditate()));
            },
            text: 'Start',
            color: HexColor('#AFE0D8'),
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget Exercise(BuildContext context, String _name, String _desc) {
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
      content: Column(
        children: [Text(_desc), Text(_desc)],
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
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 _name,
//                 style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 _desc,
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//           ),
//           Divider(
//             thickness: 2,
//           )
//         ],
//       ),
//     )