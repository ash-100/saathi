import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:saathi/screens/connect.dart';
import 'package:saathi/screens/home.dart';

class NamePage extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  final nextButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black,
      primary: HexColor('#AFE0D8'),
      padding: EdgeInsets.all(15),
      minimumSize: Size(double.maxFinite, 30),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2))));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            child: Image.asset('assets/images/logo2.png'),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Enter Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            //padding: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.currentUser!
                    .updateDisplayName(_nameController.text);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: Text('NEXT'),
              style: nextButtonStyle,
            ),
          ),
        ],
      ),
    );
  }
}
