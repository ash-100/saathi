import 'dart:async';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cron/cron.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class FallDetection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FallDetectionState();
}

class _FallDetectionState extends State<FallDetection> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('fallStatus').snapshots();
  int fall = 0;
  late Timer timer;
  bool isTimerInitialised = false;
  final assetsAudioPlayer = AssetsAudioPlayer();

  TextEditingController _contactController = TextEditingController();

  String emergencyContact = '';
  var cron = new Cron();

  void sending_SMS(String msg, List<String> list_receipents) async {
    String send_result =
        await sendSMS(message: msg, recipients: list_receipents)
            .catchError((err) {
      print(err);
    });
    print(send_result);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Timer.run(() {
    //   Future.delayed(Duration(seconds: 5), () {
    //     print('1');
    //   });
    //   Future.delayed(Duration(seconds: 10), () {
    //     print('2');
    //   });
    //   Future.delayed(Duration(seconds: 15), () {
    //     print('3');
    //     getData();
    //   });
    //   Future.delayed(Duration(seconds: 20), () {
    //     print('4');
    //     getData();
    //   });
    //   Future.delayed(Duration(seconds: 25), () {
    //     print('5');
    //   });
    // });

    // timer = Timer.periodic(Duration(seconds: 30), (Timer t) {
    //   Future.delayed(Duration(seconds: 5), () {
    //     print('1');
    //   });
    //   Future.delayed(Duration(seconds: 10), () {
    //     print('2');
    //     getData();
    //   });
    //   Future.delayed(Duration(seconds: 15), () {
    //     print('3');
    //     playMusic();
    //     //sendSms();
    //   });
    //   Future.delayed(Duration(seconds: 20), () {
    //     print('4');
    //     getData();
    //   });
    //   Future.delayed(Duration(seconds: 25), () {
    //     print('5');
    //   });
    // });

    twilioFlutter = TwilioFlutter(
        accountSid: 'AC2d470ccf9853c81e1161addf5f916374',
        authToken: '6f30fb82cbd945bffcda212b164c58f5',
        twilioNumber: '+13012982832');

    initContact();
  }

  void initContact() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var _contact = pref.get('contact');
    if (mounted) {
      setState(() {
        emergencyContact = _contact.toString();
      });
    }
  }

  bool play = false;
  void playMusic() {
    assetsAudioPlayer.open(Audio('assets/audios/Calm-and-Peaceful.mp3'));
    if (play) {
      print('pause');
      assetsAudioPlayer.stop();
      setState(() {
        play = false;
      });
    } else {
      print('play');
      assetsAudioPlayer.play();
      setState(() {
        play = true;
      });
    }
  }

  Future<void> getData() async {
    var url = 'http://192.168.180.241/ml';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonReponse = convert.jsonDecode(response.body);
      var fallValue = jsonReponse['fall']['0'];
      print(fallValue);
      setState(() {
        fall = fallValue;
      });
      if (fall == 1) {
        sendSms();
      }
    }
  }

  String _message = '';
  late TwilioFlutter twilioFlutter;
  void sendSms() async {
    String number = '9496475444';
    if (emergencyContact.trim().length == 10) {
      number = emergencyContact;
    }
    print(number);
    var currentUser = FirebaseAuth.instance.currentUser!.displayName;
    twilioFlutter.sendSMS(
        toNumber: '+91' + number, messageBody: 'THe person has fallen');
  }

  final saveButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black,
      primary: HexColor('#AFE0D8'),
      padding: EdgeInsets.all(15),
      minimumSize: Size(double.maxFinite, 30),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2))));

  void startDetection() async {
    print('start');
    // setState(() {
    //   isTimerInitialised = true;
    // });
    // timer = Timer.periodic(Duration(seconds: 30), (Timer t) {
    //   Future.delayed(Duration(seconds: 5), () {
    //     print('1');
    //   });
    //   Future.delayed(Duration(seconds: 10), () {
    //     print('2');
    //     getData();
    //     playMusic();
    //   });
    //   Future.delayed(Duration(seconds: 15), () {
    //     print('3');

    //     sendSms();
    //   });
    //   Future.delayed(Duration(seconds: 20), () {
    //     print('4');
    //     getData();
    //   });
    //   Future.delayed(Duration(seconds: 25), () {
    //     print('5');
    //   });
    // });
    //sendSms();

    cron.schedule(Schedule.parse('*/5 * * * *'), () async {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    // CollectionReference contact =
    //     FirebaseFirestore.instance.collection('contacts');

    Future<void> addContact() async {
      // return contact
      //     .doc(FirebaseAuth.instance.currentUser!.uid)
      //     .set({'contact': _contactController.text})
      //     .then((value) => print("Contact Added"))
      //     .catchError((error) => print("Failed to add contact: $error"));

      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('contact', _contactController.text);
      initContact();
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            'Fall Detection',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: _contactController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Enter Emergency Contact',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {
              addContact();
            },
            child: Text('Save Contact'),
            style: saveButtonStyle,
          ),
        ),
        //get data from firebase to display the current emergency contact
        Text('Current Contact Number: '),
        // FutureBuilder(
        //     future: contact.doc(FirebaseAuth.instance.currentUser!.uid).get(),
        //     builder: (BuildContext context,
        //         AsyncSnapshot<DocumentSnapshot> snapshot) {
        //       if (snapshot.hasError) {
        //         return Text("Something went wrong");
        //       }

        //       if (snapshot.hasData && !snapshot.data!.exists) {
        //         return Text("No contact saved");
        //       }

        //       if (snapshot.connectionState == ConnectionState.done) {
        //         Map<String, dynamic> data =
        //             snapshot.data!.data() as Map<String, dynamic>;
        //         return Text(data['contact']);
        //       }

        //       return Text("loading");
        //     }),
        Text(emergencyContact),
        Padding(
          padding: const EdgeInsets.all(25),
          child: StartButtonDesign(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          child: ElevatedButton(
            onPressed: () {
              print('stop');

              //implement properly
              cron.close();
            },
            child: Text('Stop Detection'),
            style: saveButtonStyle,
          ),
        ),
        ElevatedButton(
            onPressed: () {
              sendSms();
            },
            child: Text('Test'),
            style: ElevatedButton.styleFrom(
              primary: HexColor('#AFE0D8'),
            ))
      ],
    );
  }

  Widget StartButtonDesign() {
    return GestureDetector(
      onTap: () {
        startDetection();
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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Start',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Detection',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}



// Expanded(
//           child: StreamBuilder<QuerySnapshot>(
//             stream: _usersStream,
//             builder:
//                 (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (snapshot.hasError) {
//                 return Text('Something went wrong');
//               }

//               if (!snapshot.hasData) {
//                 return Text("No data");
//               }

//               return ListView(
//                 children: snapshot.data!.docs.map((DocumentSnapshot document) {
//                   Map<String, dynamic> data =
//                       document.data()! as Map<String, dynamic>;
//                   print(data['fall']);
//                   return ListTile(
//                     title: data['fall'] ? Text('yes') : Text('no'),
//                   );
//                 }).toList(),
//               );
//             },
//           ),
//         )




// FutureBuilder(
//             future: contact.doc(FirebaseAuth.instance.currentUser!.uid).get(),
//             builder: (BuildContext context,
//                 AsyncSnapshot<DocumentSnapshot> snapshot) {
//               if (snapshot.hasError) {
//                 return Text("Something went wrong");
//               }

//               if (snapshot.hasData && !snapshot.data!.exists) {
//                 return Text("No contact saved");
//               }

//               if (snapshot.connectionState == ConnectionState.done) {
//                 Map<String, dynamic> data =
//                     snapshot.data!.data() as Map<String, dynamic>;
//                 return Text(data['contact']);
//               }

//               return Text("loading");
//             }),