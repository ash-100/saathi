import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/animation.dart';

class BreathingExercise extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BreathingExerciseState();
}

class _BreathingExerciseState extends State<BreathingExercise>
    with SingleTickerProviderStateMixin {
  AudioPlayer player = AudioPlayer();
  bool play = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('88c7cc'),
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: HexColor('88c7cc'),
        ),
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                ' Belly Breathing Exercise',
                style: TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Center(
              child: Image.asset('assets/gifs/breatheGif.gif'),
            ),
            PlayButtonDesign()
          ],
        ));
  }

  Widget PlayButtonDesign() {
    return GestureDetector(
      onTap: () async {
        if (play) {
          await player.pause();
        } else {
          await player.play(AssetSource('audios/BellyBreathing.mp3'));
        }
        play = !play;
        setState(() {
          play = play;
        });
      },
      child: Container(
        alignment: Alignment.center,
        width: 145,
        height: 145,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            //color: HexColor('83CF9D'),
            border: Border.all(
              color: HexColor('83CF9D'),
            )),
        child: Container(
          alignment: Alignment.center,
          width: 135,
          height: 135,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: HexColor('#83CF9D')),
          ),
          child: Container(
            alignment: Alignment.center,
            width: 125,
            height: 125,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: HexColor('#83CF9D')),
            ),
            child: Container(
              alignment: Alignment.center,
              width: 115,
              height: 115,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: HexColor('#83CF9D')),
                color: HexColor('AFE0D8'),
              ),
              child: play
                  ? Icon(
                      Icons.pause,
                      size: 70,
                    )
                  : Icon(
                      Icons.play_arrow,
                      size: 70,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.pause();
  }
}
