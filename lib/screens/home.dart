//import 'package:background_fetch/background_fetch.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:saathi/auth/googleSignIn.dart';
import 'package:saathi/model/weatherSuggestions.dart';
import 'package:saathi/notificationService.dart';
import 'package:saathi/screens/connect.dart';
import 'package:saathi/screens/homeUiElements/anxietyLevel.dart';
import 'package:saathi/screens/homeUiElements/ocd.dart';
import 'package:saathi/screens/homeUiElements/rawDataFromSensor.dart';
import 'package:saathi/screens/homeUiElements/sleepQuality.dart';
import 'package:saathi/screens/homeUiElements/stressLevel.dart';
import 'package:saathi/screens/homeUiElements/variousInsights.dart';
import 'package:saathi/screens/login.dart';
import 'package:saathi/screens/ui/explore.dart';
import 'package:saathi/screens/ui/fallDetection.dart';
import 'package:saathi/screens/ui/sleep.dart';
import 'package:saathi/screens/ui/toDoList.dart';
import 'package:saathi/screens/ui/weather.dart';
import 'package:weather/weather.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    Center(child: Text('Home')),
    //Center(child: Text('Sleep')),
    //Sleep(),
    FallDetection(),
    WeatherPage(),
    ToDoList(),
  ];

  void initBackground() async {
    final androidConfig = FlutterBackgroundAndroidConfig(
      notificationTitle: "flutter_background example app",
      notificationText:
          "Background notification for keeping the example app running in the background",
      notificationImportance: AndroidNotificationImportance.Default,
      notificationIcon: AndroidResource(
          name: 'background_icon',
          defType: 'drawable'), // Default is ic_launcher from folder mipmap
    );
    bool success =
        await FlutterBackground.initialize(androidConfig: androidConfig);
  }

  // void getPerpetualWeather() async {
  //   await AndroidAlarmManager.initialize();
  //   await AndroidAlarmManager.periodic(Duration(minutes: 1), 1, () {

  //   });
  // }

  late final LocalNotificationService service;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //initBackground();

    _determinePosition();
    _findPos();

    //BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
    //FlutterBackground.initialize();
  }

//   Future<void> initPlatformState() async {
// // Configure BackgroundFetch.
// var status = await BackgroundFetch.configure(BackgroundFetchConfig(
// minimumFetchInterval: 15,
// forceAlarmManager: false,
// stopOnTerminate: false,
// startOnBoot: true,
// enableHeadless: true,
// requiresBatteryNotLow: false,
// requiresCharging: false,
// requiresStorageNotLow: false,
// requiresDeviceIdle: false,
// requiredNetworkType: NetworkType.NONE,
// ), _onBackgroundFetch, _onBackgroundFetchTimeout);
// //print(‘[BackgroundFetch] configure success: $status’);
// // Schedule backgroundfetch for the 1st time it will execute with 1000ms delay.
// // where device must be powered (and delay will be throttled by the OS).
// BackgroundFetch.scheduleTask(TaskConfig(
// taskId: '1',
// delay: 1000,
// periodic: false,
// stopOnTerminate: false,
// enableHeadless: true
// ));
// }
// void _onBackgroundFetchTimeout(String taskId) {
// //print(“[BackgroundFetch] TIMEOUT: $taskId”);
// BackgroundFetch.finish(taskId);
// }
  WeatherFactory wf = new WeatherFactory('1e206fd4e2a3ee499a72da90c92e00b6');
  double lat = 8.0883, long = 77.5385;
  int month = 1;
  int adjustedWeatherCode = 0;
  Future<void> _determinePosition() async {
    print('permission');
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
  }

  void _findPos() async {
    print('pos');
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (mounted) {
      setState(() {
        lat = position.latitude;
        long = position.longitude;
      });
    }
    findWeather();
  }

  void findWeather() async {
    //Weather w =wf.currentWeatherByLocation(lat, long);
    var results = await Future.wait([wf.currentWeatherByLocation(lat, long)]);
    Weather w = results[0];
    print(w);
    print(w.areaName);
    print(w.date);
    int weatherCode = w.weatherConditionCode ?? 800;
    int c = 0; // Normal
    if ((weatherCode >= 200 && weatherCode < 600) || (weatherCode > 800)) {
      c = 1; // Rainy
    } else if (weatherCode >= 600 && weatherCode < 700) {
      c = 2; // Cold
    } else {
      c = 3; // Hot
    }
    setState(() {
      adjustedWeatherCode = c;
    });
  }

  List<Widget> _icons = [
    Icon(Icons.sunny),
    Icon(Icons.water_drop),
    Icon(Icons.snowing),
    Icon(Icons.sunny)
  ];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Center(
          child: Image.asset('assets/images/logo5.png'),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.all(15), child: _icons[adjustedWeatherCode])
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Center(child: Image.asset('assets/images/logo3.png')),
            ),
            ListTile(
              title: Text('Log out'),
              onTap: () {
                print(FirebaseAuth
                    .instance.currentUser!.providerData[0].providerId);
                if (FirebaseAuth
                        .instance.currentUser!.providerData[0].providerId
                        .toString()
                        .trim() ==
                    'phone') {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                } else {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.logout();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                      (route) => false);
                }
              },
            )
          ],
        ),
      ),
      body: _selectedIndex == 0
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: HexColor('#b7e1d8')),
                        padding: EdgeInsets.all(25),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.all(7),
                                    child: Text(
                                      'Hi, ' + user!.displayName!.toString(),
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    // child: Text(
                                    //   hot,
                                    //   style: TextStyle(fontSize: 15),
                                    // ),
                                    child: carousel(),
                                  ),
                                ),
                              ],
                            )),
                            IconButton(
                                onPressed: () async {
                                  setState(() {
                                    _selectedIndex = 2;
                                  });
                                },
                                icon: Icon(Icons.arrow_forward))
                          ],
                        )),
                  ),
                  StressLevel(),
                  Divider(
                    thickness: 2,
                  ),
                  VariousInsights(),
                  // Ocd(),
                  // Divider(
                  //   thickness: 2,
                  // ),
                  // AnxietyLevel(),
                  Divider(
                    thickness: 2,
                  ),
                  SleepQuality(),
                  Divider(
                    thickness: 2,
                  ),
                  //RawDataFromSensor(),
                ],
              ),
            )
          : _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: HexColor('#229F8B'),
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          // BottomNavigationBarItem(
          //   icon: Container(
          //     child: Image.asset('assets/images/darkModeIcon.png'),
          //     height: 25,
          //   ),
          //   label: 'Sleep',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_circle_outline),
            label: 'Fall Detection',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Dincharya',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onNavbarItemTapped,
      ),
    );
  }

  void _onNavbarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget carousel() {
    print('weather code $adjustedWeatherCode');
    List<String> list = [];
    if (adjustedWeatherCode == 1 || adjustedWeatherCode == 0) {
      list = rainyWeatherSuggestions;
    } else if (adjustedWeatherCode == 2) {
      list = coldWeatherSuggestions;
    } else if (adjustedWeatherCode == 3) {
      list = hotWeatherSuggestions;
    }
    return CarouselSlider(
      options:
          CarouselOptions(height: 40.0, autoPlay: true, viewportFraction: 1),
      items: list.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: Colors.transparent),
                child: Text(
                  '$i',
                  style: TextStyle(fontSize: 16.0),
                ));
          },
        );
      }).toList(),
    );
  }
  // void backgroundFetchHeadlessTask(HeadlessTask task) async {
  //   print('background');
  // }
}
