import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:saathi/auth/googleSignIn.dart';
import 'package:saathi/screens/verifyMobile.dart';

class Login extends StatelessWidget {
  Future<UserCredential> signInWithGoogle() async {
    GoogleSignInAccount? googleUser = null;
    try {
      googleUser = await GoogleSignIn().signIn();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  final requestButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black,
      primary: HexColor('#AFE0D8'),
      padding: EdgeInsets.all(15),
      minimumSize: Size(double.maxFinite, 30),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2))));
  TextEditingController _numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(50),
            child: Image.asset('assets/images/logo4.png'),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _numberController,
              decoration: InputDecoration(
                labelText: 'Enter Mobile Number',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.all(10),
          //   child: TextField(
          //     decoration: InputDecoration(
          //       labelText: 'Enter OTP',
          //       border: OutlineInputBorder(),
          //     ),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              onPressed: () {
                String number = '+91' + _numberController.text;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VerifyNumber(mobile: number)));
              },
              child: Text('Request OTP'),
              style: requestButtonStyle,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text('----OR----'),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: SignInButton(
              Buttons.Google,
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();
              },
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 10),
          //   child: SignInButton(
          //     Buttons.Facebook,
          //     onPressed: () {},
          //   ),
          // ),
        ],
      ),
    );
  }
}
