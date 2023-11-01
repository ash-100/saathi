import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:saathi/screens/connect.dart';
import 'package:saathi/screens/name.dart';

class VerifyNumber extends StatefulWidget {
  final String mobile;
  const VerifyNumber({Key? key, required this.mobile}) : super(key: key);

  @override
  State<VerifyNumber> createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumber> {
  var _verificationId;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final verifyButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black,
      primary: HexColor('#AFE0D8'),
      padding: EdgeInsets.all(15),
      minimumSize: Size(double.maxFinite, 30),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2))));
  TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    verify();
  }

  Future verify() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
        phoneNumber: widget.mobile,
        verificationCompleted: (phoneAuthCredential) async {},
        verificationFailed: (verificationFailed) async {},
        codeSent: (verificatoinId, resendingToken) async {
          setState(() {
            _verificationId = verificatoinId;
          });
        },
        codeAutoRetrievalTimeout: (verificaitionId) async {});
  }

  Future _sendCodeToFirebase({String? code}) async {
    if (this._verificationId != null) {
      var credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: code!);
      await _auth.signInWithCredential(credential).then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => NamePage()));
      });
    }
  }

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
              controller: _otpController,
              decoration: InputDecoration(
                labelText: 'Enter OTP',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextButton(
              child: Text('Resend OTP'),
              onPressed: () {
                verify();
              },
            ),
          ),
          Padding(
            //padding: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                _sendCodeToFirebase(code: _otpController.text);
              },
              child: Text('VERIFY'),
              style: verifyButtonStyle,
            ),
          ),
        ],
      ),
    );
  }
}
