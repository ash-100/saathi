import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:saathi/auth/googleSignIn.dart';

import 'package:saathi/screens/login.dart';

class AnxietyExercise extends StatefulWidget {
  const AnxietyExercise({Key? key}) : super(key: key);

  @override
  State<AnxietyExercise> createState() => _AnxietyExerciseState();
}

class _AnxietyExerciseState extends State<AnxietyExercise> {
  final exerciseDesc =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ';
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  'Anxiety Mitigation',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            Exercise('Deep Breathing Exercise', exerciseDesc),
            Exercise('Meditate for a couple of minutes', exerciseDesc),
            Exercise('Listen to Relaxing Music', exerciseDesc),
            Exercise('Deep Breathing Exercise', exerciseDesc),
          ],
        ),
      ),
    );
  }

  Widget Exercise(String exerciseName, String exerciseDescription) {
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
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward))
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
