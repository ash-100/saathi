import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:saathi/auth/googleSignIn.dart';
import 'package:saathi/screens/ui/anxietyLevelInsights.dart';
import 'package:saathi/screens/ui/temperature.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

import '../screens/login.dart';
import '../screens/name.dart';
import 'notificationService.dart';
import 'screens/connect.dart';
import '../screens/home.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //HttpOverrides.global = new MyHttpOverrides();
  runApp(const MyApp());
}

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key})
      : super(key: key); // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
// Future<bool> isDetailAvailable()async{
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   var val=pref.getInt('breakFastHour')
// }

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              //return ConnectPage();
              if (FirebaseAuth.instance.currentUser!.displayName == null) {
                return NamePage();
              } else {
                return Home();
              }
            } else if (snapshot.hasError) {
              //
            }
            return Login();
          }),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
