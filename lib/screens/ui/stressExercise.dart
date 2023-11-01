import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:saathi/auth/googleSignIn.dart';
import 'package:saathi/model/musicBenefits.dart';

import 'package:saathi/screens/login.dart';
import 'package:saathi/screens/ui/alternateNostrilBreathing.dart';
import 'package:saathi/screens/ui/boxBreathing.dart';
import 'package:saathi/screens/ui/breathingExercise.dart';
import 'package:saathi/screens/explanations/breathingExerciseExplanation.dart';
import 'package:saathi/screens/ui/meditate.dart';
import 'package:saathi/screens/explanations/meditationExplanation.dart';
import 'package:saathi/screens/explanations/musicBenefitsExplanation.dart';
import 'package:saathi/screens/ui/music.dart';

class StressExercise extends StatefulWidget {
  const StressExercise({Key? key}) : super(key: key);

  @override
  State<StressExercise> createState() => _StressExerciseState();
}

class _StressExerciseState extends State<StressExercise> {
  List<String> list = [
    'Meditation',
    'Box Breathing',
    'Alternate Nostril Breathing',
    'Belly Breathing',
    'Listening to Music'
  ];
  final exerciseDesc =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ';
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    List<Widget> _icons = [
      Column(
        children: [
          Container(
            //height: ,
            child: IconButton(
              iconSize: 120,
              icon: Image.asset('assets/images/meditation.png'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Meditate()));
              },
            ),
          ),
          Text('Dhyana Chikitsa'),
        ],
      ),
      Column(
        children: [
          Container(
            //height: ,
            child: IconButton(
              iconSize: 120,
              icon: Image.asset('assets/images/alternateNostrilBreathing2.png'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NostrilBreathingExercise()));
              },
            ),
          ),
          Text('Anulom Vilom'),
        ],
      ),
      Column(
        children: [
          Container(
            //height: ,
            child: IconButton(
              iconSize: 120,
              icon: Image.asset('assets/images/boxBreathing3.png'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BoxBreathingExercise()));
              },
            ),
          ),
          Text('Sama Vritti Pranayama'),
        ],
      ),
      Column(
        children: [
          Container(
            //height: ,
            child: IconButton(
              iconSize: 120,
              icon: Image.asset('assets/images/bellyBreathing2.png'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BreathingExercise()));
              },
            ),
          ),
          Text('Belly Breathing'),
        ],
      ),
      Column(
        children: [
          Container(
            //height: ,
            child: IconButton(
              iconSize: 120,
              icon: Image.asset('assets/images/music.png'),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Music()));
              },
            ),
          ),
          Text('Listening to music'),
        ],
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Stress Relief',
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon: Image.asset('assets/images/darkModeIcon.png'))
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Padding(
            //   padding: EdgeInsets.all(15),
            //   child: Center(
            //     child: Text(
            //       'Stress Relief',
            //       style: TextStyle(fontSize: 25),
            //     ),
            //   ),
            // ),
            CarouselSlider(
              options: CarouselOptions(
                  height: 180.0, autoPlay: true, viewportFraction: 0.35),
              items: _icons.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return i;
                  },
                );
              }).toList(),
            ),
            Exercise(
                'Pranayama / Deep Breathing Exercise',
                'Deep breathing can help lessen stress and anxiety.Our breath isn’t just part of our body’s stress response, it’s key to it.',
                0),
            Exercise(
                'Dhyana Chikitsa / Meditation',
                'Dhyana Chikitsa offers time for relaxation and heightened awareness in a stressful world where our senses are often dulled.',
                1),
            Exercise(
                'Listen to Relaxing Music',
                'Stress can be reduced and relaxation maximized with the use of music.',
                2),
          ],
        ),
      ),
    );
  }

  Widget Exercise(String exerciseName, String exerciseDescription, int index) {
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
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          exerciseName,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
                IconButton(
                    onPressed: () {
                      if (index == 0) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BreathingExerciseExplanation()));
                      }
                      if (index == 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MeditationExerciseExplanation()));
                      }
                      if (index == 2) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MusicBenefitsExplanation()));
                      }
                    },
                    icon: Icon(Icons.arrow_forward))
              ],
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    exerciseDescription,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

// Row(
//               children: [
//                 Expanded(
//                     child: Column(
//                   children: [
//                     Container(
//                       //height:
//                       child: IconButton(
//                         iconSize: 120,
//                         icon: Image.asset('assets/images/meditation.png'),
//                         onPressed: () {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => Meditate()));
                        // },
//                       ),
//                     ),
//                     Text('Meditate'),
//                   ],
//                 )),
//                 Expanded(
//                     child: Column(
//                   children: [
//                     Container(
//                       //height:
//                       child: IconButton(
//                         iconSize: 120,
//                         icon: Image.asset('assets/images/music.png'),
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => BreathingExercise()));
//                         },
//                       ),
//                     ),
//                     Text('Breathing Exercise'),
//                   ],
//                 )),
//                 Expanded(
//                     child: Column(
//                   children: [
//                     Container(
//                       //height: ,
//                       child: IconButton(
//                         iconSize: 120,
//                         icon: Image.asset('assets/images/games.png'),
//                         onPressed: () {},
//                       ),
//                     ),
//                     Text('Games'),
//                   ],
//                 ))
//               ],
//             ),
