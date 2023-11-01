import 'dart:typed_data';

import 'package:flutter/material.dart';
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class Music extends StatefulWidget {
  const Music({Key? key}) : super(key: key);

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  AudioPlayer player = AudioPlayer();
  bool play = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#c6c5ff'),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: HexColor('#c6c5ff'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text(
                'Listen To Music',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(child: Image.asset('assets/images/music.png')),
          // Center(
          //   child: Text(
          //     'OO:00',
          //     style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          //   ),
          // ),
          PlayButtonDesign(),
        ],
      ),
    );
  }

  Widget PlayButtonDesign() {
    return GestureDetector(
      onTap: () async {
        if (play) {
          await player.pause();
        } else {
          await player.play(AssetSource('audios/Calm-and-Peaceful.mp3'));
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
              color: Colors.white,
            )),
        child: Container(
          alignment: Alignment.center,
          width: 135,
          height: 135,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white),
          ),
          child: Container(
            alignment: Alignment.center,
            width: 125,
            height: 125,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white),
            ),
            child: Container(
              alignment: Alignment.center,
              width: 115,
              height: 115,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white),
                color: Colors.white,
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
