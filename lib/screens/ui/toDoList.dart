import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart' as convert;
import 'package:slide_to_confirm/slide_to_confirm.dart';

//import 'package:slide_to_confirm/slide_to_confirm.dart';
class ToDoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<String> toDoList = [];
  TextEditingController _Controller = TextEditingController();
  void getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> _toDoList = [];
    _toDoList = pref.getStringList('list') ?? [];
    setState(() {
      toDoList = _toDoList;
    });
  }

  Future<void> getData1() async {
    var url = 'http://192.168.180.241/';

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse(url));
    var feeds = [];
    print(url);
    if (response.statusCode == 200) {
      //var jsonResponse = convert.jsonDecode(response.body);
      print('hi');
      print(response.body);

      //print(itemCount);

    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getData1();
    check();
  }

  void setData(String s) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> _toDoList = toDoList;
    _toDoList.add(s);
    pref.setStringList('list', _toDoList);
    setState(() {
      toDoList = _toDoList;
    });
  }

  bool rise = false,
      rinse = false,
      cleaning = false,
      drink = false,
      oilMassage = false,
      exercise = false,
      bath = false,
      meditate = false;
  void check() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    //pref.setString('nextMidnight', DateTime.now().toString());
    var nextNight = pref.getString('nextMidnight') ?? '';
    if (nextNight == '') {
      final now = DateTime.now();
      final lastMidnight = now.subtract(Duration(
        hours: now.hour,
        minutes: now.minute,
        seconds: now.second,
        milliseconds: now.millisecond,
        microseconds: now.microsecond,
      ));
      final nextMidnight = lastMidnight.add(Duration(days: 1));
      print(nextMidnight);
      pref.setString('nextMidnight', nextMidnight.toString());
    }

    var nextMidnight =
        DateTime.parse(pref.getString('nextMidnight').toString());
    if (nextMidnight.isAfter(DateTime.now())) {
    } else {
      //update nextMid
      pref.setBool('rise', false);
      pref.setBool('rinse', false);
      pref.setBool('cleaning', false);
      pref.setBool('drink', false);
      pref.setBool('oilMassage', false);
      pref.setBool('exercise', false);
      pref.setBool('bath', false);
      pref.setBool('meditate', false);

      final now = DateTime.now();
      final lastMidnight = now.subtract(Duration(
        hours: now.hour,
        minutes: now.minute,
        seconds: now.second,
        milliseconds: now.millisecond,
        microseconds: now.microsecond,
      ));
      final nextMidnight = lastMidnight.add(
        Duration(days: 1),
      );
      print(nextMidnight);
      pref.setString('nextMidnight', nextMidnight.toString());
    }

    bool _rise = pref.getBool('rise') ?? false;
    bool _rinse = pref.getBool('rinse') ?? false;
    bool _cleaning = pref.getBool('cleaning') ?? false;
    bool _drink = pref.getBool('drink') ?? false;
    bool _oilMassage = pref.getBool('oilMassage') ?? false;
    bool _exercise = pref.getBool('exercise') ?? false;
    bool _bath = pref.getBool('bath') ?? false;
    bool _meditate = pref.getBool('meditate') ?? false;
    setState(() {
      rise = _rise;
      rinse = _rinse;
      cleaning = _cleaning;
      drink = _drink;
      oilMassage = _oilMassage;
      exercise = _exercise;
      bath = _bath;
      meditate = _meditate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Dincharya',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ConfirmationSlider(
                      height: 50,
                      onConfirmation: () => riseConfirmed(),
                      text: 'Brahmi Muhurta - Rise',
                      textStyle: TextStyle(fontSize: 19),
                      backgroundColor: rise ? Colors.green : Colors.white,
                      //backgroundShape: BorderRadius.all(Radius.circular(10)),
                      //foregroundColor: Colors.transparent,
                      //iconColor: Colors.transparent,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'))
                          ],
                          title: Text('Brahmi Muhurta - Rise'),
                          content: Text(
                              'Wake up before sunrise. Say prayer before getting out of bed to induce positive energy into mind and soul'),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ConfirmationSlider(
                      height: 50,
                      onConfirmation: () => rinseConfirmed(),
                      text: 'Jalenti - Rinse',
                      textStyle: TextStyle(fontSize: 19),
                      backgroundColor: rinse ? Colors.green : Colors.white,
                      //backgroundShape: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'))
                          ],
                          title: Text('Jalenti - Rinse'),
                          content: Text(
                              'Rinse face with cold water. Perform Jalenti - Cleaning of sinus, nasal passage and mouth with help of tea pot like vessel called neti pot.'),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ConfirmationSlider(
                      height: 50,
                      onConfirmation: () => cleaningConfirmed(),
                      text: 'Cleaning',
                      textStyle: TextStyle(fontSize: 19),
                      backgroundColor: cleaning ? Colors.green : Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'))
                          ],
                          title: Text('Cleaning of your senses'),
                          content: Text(
                              'Sense organs should be cleaned throughly. Wash eyes with rose water, ears with sesame oil. Brush teeth and clean tongue'),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ConfirmationSlider(
                      height: 50,
                      onConfirmation: () => drinkConfirmed(),
                      text: 'Ushapana - Drink water',
                      textStyle: TextStyle(fontSize: 19),
                      backgroundColor: drink ? Colors.green : Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'))
                          ],
                          title: Text('Ushapana - Drink warm water'),
                          content: Text('Drink warm water'),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ConfirmationSlider(
                      //width: double.infinity,
                      height: 50,
                      onConfirmation: () => oilConfirmed(),
                      text: 'Abhyanga - Oil Massage',
                      textStyle: TextStyle(fontSize: 19),
                      backgroundColor: oilMassage ? Colors.green : Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'))
                          ],
                          title: Text('Abhyanga - Oil Massage'),
                          content: Text(
                              'Massage body with essential oils to keep body moistural for good circulation'),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ConfirmationSlider(
                      height: 50,
                      onConfirmation: () => exerciseConfirmed(),
                      text: 'Vyayam - Exercise',
                      textStyle: TextStyle(fontSize: 19),
                      backgroundColor: exercise ? Colors.green : Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'))
                          ],
                          title: Text('Vyayam - Exercise'),
                          content: Text('Yoga, surya Namaskars, anulom-vilan'),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ConfirmationSlider(
                      height: 50,
                      onConfirmation: () => bathConfirmed(),
                      text: 'Snana - Bath',
                      textStyle: TextStyle(fontSize: 19),
                      backgroundColor: bath ? Colors.green : Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'))
                          ],
                          title: Text('Snana - Bath'),
                          content: Text('Make feel fresh and energized'),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ConfirmationSlider(
                      height: 50,
                      onConfirmation: () => meditateConfirmed(),
                      text: 'Dhyana - Meditate',
                      textStyle: TextStyle(fontSize: 19),
                      backgroundColor: meditate ? Colors.green : Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'))
                          ],
                          title: Text('Dhyana - Meditate'),
                          content: Text(
                              'Help to concentrate, maintain balance between body, nind and soul'),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.setBool('rise', false);
                  pref.setBool('rinse', false);
                  pref.setBool('cleaning', false);
                  pref.setBool('drink', false);
                  pref.setBool('oilMassage', false);
                  pref.setBool('exercise', false);
                  pref.setBool('bath', false);
                  pref.setBool('meditate', false);
                  setState(() {
                    rise = false;
                    rinse = false;
                    cleaning = false;
                    drink = false;
                    oilMassage = false;
                    exercise = false;
                    bath = false;
                    meditate = false;
                  });
                },
                child: Text('Reset'))
          ],
        ),
      ),
    );
  }

  void riseConfirmed() async {
    print('Slider confirmed!');
    setState(() {
      rise = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('rise', true);
  }

  void rinseConfirmed() async {
    print('Slider confirmed!');
    setState(() {
      rinse = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('rinse', true);
  }

  void cleaningConfirmed() async {
    print('Slider confirmed!');
    setState(() {
      cleaning = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('cleaning', true);
  }

  void drinkConfirmed() async {
    print('Slider confirmed!');
    setState(() {
      drink = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('drink', true);
  }

  void oilConfirmed() async {
    print('Slider confirmed!');
    setState(() {
      oilMassage = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('oilMassage', true);
  }

  void exerciseConfirmed() async {
    print('Slider confirmed!');
    setState(() {
      exercise = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('exercise', true);
  }

  void bathConfirmed() async {
    print('Slider confirmed!');
    setState(() {
      bath = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('bath', true);
  }

  void meditateConfirmed() async {
    print('Slider confirmed!');
    setState(() {
      meditate = true;
    });
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('meditate', true);
  }
}
