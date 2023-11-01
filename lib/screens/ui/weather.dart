import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:saathi/model/dietMonth.dart';
import 'package:weather/weather.dart';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:getwidget/getwidget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WeatherPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WeatherState();
}

class _WeatherState extends State<WeatherPage> {
  WeatherFactory wf = new WeatherFactory('1e206fd4e2a3ee499a72da90c92e00b6');
  double lat = 8.0883, long = 77.5385;
  int month = 1;

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
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
    Weather w = await wf.currentWeatherByLocation(lat, long);
    print(w);
    print(w.areaName);
    print(w.date);
  }

  DietMonth diet =
      DietMonth(condition: '', foodsToEat: [], foodsToAvoid: [], lifeStyle: '');
  void getDate() {
    var _month = DateTime.now().month;
    setState(() {
      month = _month;
    });
    print(_month);
    String _condition = 'c';
    String _lifestyle = 'l';
    List<String> _foodsToEat = ['a'];
    List<String> _foodsToAvoid = ['b'];

    DietMonth _diet = DietMonth(
        condition: _condition,
        foodsToEat: _foodsToEat,
        foodsToAvoid: _foodsToAvoid,
        lifeStyle: _lifestyle);

    if (month >= 1 && month <= 3) {
      _diet = winter;
    } else if (month == 4 || month == 5) {
      _diet = spring;
    } else if (month == 6 || month == 7) {
      _diet = summer;
    } else if (month == 8 || month == 9) {
      //print('monsoon');
      _diet = monsoon;
      //print(monsoon.foodsToAvoid);
    } else if (month == 10 || month == 11) {
      _diet = autumn;
    } else {
      _diet = monsoon; //winter is late autumn
    }
    diet = _diet;
    print(_diet.condition);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _determinePosition();
    // _findPos();
    getDate();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              child: Text(
                diet.condition,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
              padding: EdgeInsets.symmetric(vertical: 12)),
          GFCard(
            boxFit: BoxFit.cover,
            titlePosition: GFPosition.start,
            showOverlayImage: true,
            imageOverlay: AssetImage(
              '',
            ),
            title: GFListTile(
              avatar: GFAvatar(
                  backgroundImage: AssetImage('assets/images/lifestyle.jpg')),
              titleText: 'Lifestyle',
              subTitleText: 'Healthy Lifestyle',
            ),
            //content: Text(diet.lifeStyle),
            content: AnimatedTextKit(
              isRepeatingAnimation: false,
              animatedTexts: [TyperAnimatedText(diet.lifeStyle)],
            ),
          ),
          GFCard(
            boxFit: BoxFit.cover,
            titlePosition: GFPosition.start,
            showOverlayImage: true,
            imageOverlay: AssetImage(
              '',
            ),
            title: GFListTile(
              avatar: GFAvatar(
                  backgroundImage: AssetImage('assets/images/lifestyle.jpg')),
              titleText: 'Foods to be taken',
              subTitleText: 'Healthy foods',
            ),
            content: BulletedList(
              listItems: diet.foodsToEat,
              style: TextStyle(fontSize: 14),
            ),
          ),
          GFCard(
            boxFit: BoxFit.cover,
            titlePosition: GFPosition.start,
            showOverlayImage: true,
            imageOverlay: AssetImage(
              '',
            ),
            title: GFListTile(
              avatar: GFAvatar(
                  backgroundImage: AssetImage('assets/images/lifestyle.jpg')),
              titleText: 'Foods to be avoided',
              subTitleText: 'Foods',
            ),
            content: BulletedList(
              listItems: diet.foodsToAvoid,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
