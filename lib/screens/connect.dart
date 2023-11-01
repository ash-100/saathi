// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';

// import 'dart:async';

// import 'dart:math';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// //import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:provider/provider.dart';
// import 'package:saathi/screens/home.dart';
// import 'package:saathi/screens/login.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import '../auth/googleSignIn.dart';

// class ConnectPage extends StatefulWidget {
//   const ConnectPage({Key? key}) : super(key: key);

//   @override
//   State<ConnectPage> createState() => _ConnectPageState();
// }

// class _ConnectPageState extends State<ConnectPage> {
//   FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

//   void scanDevices() {
//     print('hi');
//     // Start scanning
//     flutterBlue.startScan(timeout: Duration(seconds: 4));

// // Listen to scan results
//     var subscription = flutterBlue.scanResults.listen((results) {
//       // do something with scan results
//       for (ScanResult r in results) {
//         //print('${r.device.name} found! rssi: ${r.rssi}');
//         print(r.device.id);
//       }
//     });

// // Stop scanning
//     //flutterBlue.stopScan();
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     scanDevices();
//   }

//   final connectButtonStyle = ElevatedButton.styleFrom(
//       onPrimary: Colors.black,
//       primary: HexColor('#AFE0D8'),
//       padding: EdgeInsets.all(15),
//       minimumSize: Size(double.maxFinite, 30),
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(2))));
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Colors.black),
//         backgroundColor: Colors.white,
//         title: Center(
//           child: Image.asset('assets/images/logo5.png'),
//         ),
//         actions: [
//           IconButton(
//               onPressed: () {},
//               icon: Image.asset('assets/images/darkModeIcon.png'))
//         ],
//       ),
//       drawer: Drawer(
//         child: Column(
//           children: [
//             DrawerHeader(
//               child: Center(child: Image.asset('assets/images/logo3.png')),
//             ),
//             ListTile(
//               title: Text('Profile'),
//             ),
//             ListTile(
//               title: Text('Log out'),
//               onTap: () {
//                 print(FirebaseAuth
//                     .instance.currentUser!.providerData[0].providerId);
//                 if (FirebaseAuth
//                         .instance.currentUser!.providerData[0].providerId
//                         .toString()
//                         .trim() ==
//                     'phone') {
//                   FirebaseAuth.instance.signOut();
//                   Navigator.pushReplacement(context,
//                       MaterialPageRoute(builder: (context) => Login()));
//                 } else {
//                   final provider =
//                       Provider.of<GoogleSignInProvider>(context, listen: false);
//                   provider.logout();
//                   Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (context) => Login()),
//                       (route) => false);
//                 }
//               },
//             )
//           ],
//         ),
//       ),
//       body: StreamBuilder<BluetoothState>(
//           stream: FlutterBluePlus.instance.state,
//           initialData: BluetoothState.unknown,
//           builder: (c, snapshot) {
//             final state = snapshot.data;
//             if (state == BluetoothState.on) {
//               return const FindDevicesScreen();
//             }
//             return BluetoothOffScreen(state: state);
//           }),
//     );
//   }

//   Widget BlueToothDesign() {
//     return Container(
//       alignment: Alignment.center,
//       width: 257,
//       height: 257,
//       decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           //color: HexColor('83CF9D'),
//           border: Border.all(
//             color: HexColor('83CF9D'),
//           )),
//       child: Container(
//         alignment: Alignment.center,
//         width: 239,
//         height: 239,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(color: HexColor('#83CF9D')),
//         ),
//         child: Container(
//           alignment: Alignment.center,
//           width: 222,
//           height: 222,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(color: HexColor('#83CF9D')),
//           ),
//           child: Container(
//             alignment: Alignment.center,
//             width: 205,
//             height: 205,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(color: HexColor('#83CF9D')),
//               color: HexColor('AFE0D8'),
//             ),
//             child: Icon(
//               Icons.bluetooth,
//               size: 80,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// class BluetoothOffScreen extends StatelessWidget {
//   const BluetoothOffScreen({Key? key, this.state}) : super(key: key);

//   final BluetoothState? state;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightBlue,
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             const Icon(
//               Icons.bluetooth_disabled,
//               size: 200.0,
//               color: Colors.white54,
//             ),
//             Text(
//               'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
//               style: Theme.of(context)
//                   .primaryTextTheme
//                   .subtitle2
//                   ?.copyWith(color: Colors.white),
//             ),
//             ElevatedButton(
//               child: const Text('TURN ON'),
//               onPressed: Platform.isAndroid
//                   ? () => FlutterBluePlus.instance.turnOn()
//                   : null,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class FindDevicesScreen extends StatelessWidget {
//   const FindDevicesScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Find Devices'),
//         actions: [
//           ElevatedButton(
//             child: const Text('TURN OFF'),
//             style: ElevatedButton.styleFrom(
//               primary: Colors.black,
//               onPrimary: Colors.white,
//             ),
//             onPressed: Platform.isAndroid
//                 ? () => FlutterBluePlus.instance.turnOff()
//                 : null,
//           ),
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: () => FlutterBluePlus.instance
//             .startScan(timeout: const Duration(seconds: 4)),
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               StreamBuilder<List<BluetoothDevice>>(
//                 stream: Stream.periodic(const Duration(seconds: 2))
//                     .asyncMap((_) => FlutterBluePlus.instance.connectedDevices),
//                 initialData: const [],
//                 builder: (c, snapshot) => Column(
//                   children: snapshot.data!
//                       .map((d) => ListTile(
//                             title: Text(d.name),
//                             subtitle: Text(d.id.toString()),
//                             trailing: StreamBuilder<BluetoothDeviceState>(
//                               stream: d.state,
//                               initialData: BluetoothDeviceState.disconnected,
//                               builder: (c, snapshot) {
//                                 if (snapshot.data ==
//                                     BluetoothDeviceState.connected) {
//                                   return ElevatedButton(
//                                     child: const Text('OPEN'),
//                                     onPressed: () => Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 DeviceScreen(device: d))),
//                                   );
//                                 }
//                                 return Text(snapshot.data.toString());
//                               },
//                             ),
//                           ))
//                       .toList(),
//                 ),
//               ),
//               StreamBuilder(
//                 stream: FlutterBluePlus.instance.scanResults,
//                 initialData: const [],
//                 builder: (c, snapshot) => Column(
//                   children: snapshot.data!
//                       .map(
//                         (r) => ScanResultTile(
//                           result: r,
//                           onTap: () => Navigator.of(context)
//                               .push(MaterialPageRoute(builder: (context) {
//                             r.device.connect();
//                             return DeviceScreen(device: r.device);
//                           })),
//                         ),
//                       )
//                       .toList(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: StreamBuilder<bool>(
//         stream: FlutterBluePlus.instance.isScanning,
//         initialData: false,
//         builder: (c, snapshot) {
//           if (snapshot.data!) {
//             return FloatingActionButton(
//               child: const Icon(Icons.stop),
//               onPressed: () => FlutterBluePlus.instance.stopScan(),
//               backgroundColor: Colors.red,
//             );
//           } else {
//             return FloatingActionButton(
//                 child: const Icon(Icons.search),
//                 onPressed: () => FlutterBluePlus.instance
//                     .startScan(timeout: const Duration(seconds: 4)));
//           }
//         },
//       ),
//     );
//   }
// }

// class DeviceScreen extends StatelessWidget {
//   const DeviceScreen({Key? key, required this.device}) : super(key: key);

//   final BluetoothDevice device;

//   List<int> _getRandomBytes() {
//     final math = Random();
//     return [
//       math.nextInt(255),
//       math.nextInt(255),
//       math.nextInt(255),
//       math.nextInt(255)
//     ];
//   }

//   List _buildServiceTiles(List<BluetoothService> services) {
//     return services
//         .map(
//           (s) => ServiceTile(
//             service: s,
//             characteristicTiles: s.characteristics
//                 .map(
//                   (c) => CharacteristicTile(
//                     characteristic: c,
//                     onReadPressed: () => c.read(),
//                     onWritePressed: () async {
//                       await c.write(_getRandomBytes(), withoutResponse: true);
//                       await c.read();
//                     },
//                     onNotificationPressed: () async {
//                       await c.setNotifyValue(!c.isNotifying);
//                       await c.read();
//                     },
//                     descriptorTiles: c.descriptors
//                         .map(
//                           (d) => DescriptorTile(
//                             descriptor: d,
//                             onReadPressed: () => d.read(),
//                             onWritePressed: () => d.write(_getRandomBytes()),
//                           ),
//                         )
//                         .toList(),
//                   ),
//                 )
//                 .toList(),
//           ),
//         )
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(device.name),
//         actions: <Widget>[
//           StreamBuilder<BluetoothDeviceState>(
//             stream: device.state,
//             initialData: BluetoothDeviceState.connecting,
//             builder: (c, snapshot) {
//               VoidCallback? onPressed;
//               String text;
//               switch (snapshot.data) {
//                 case BluetoothDeviceState.connected:
//                   onPressed = () => device.disconnect();
//                   text = 'DISCONNECT';
//                   break;
//                 case BluetoothDeviceState.disconnected:
//                   onPressed = () => device.connect();
//                   text = 'CONNECT';
//                   break;
//                 default:
//                   onPressed = null;
//                   text = snapshot.data.toString().substring(21).toUpperCase();
//                   break;
//               }
//               return TextButton(
//                   onPressed: onPressed,
//                   child: Text(
//                     text,
//                     style: Theme.of(context)
//                         .primaryTextTheme
//                         .button
//                         ?.copyWith(color: Colors.white),
//                   ));
//             },
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             StreamBuilder<BluetoothDeviceState>(
//               stream: device.state,
//               initialData: BluetoothDeviceState.connecting,
//               builder: (c, snapshot) => ListTile(
//                 leading: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     snapshot.data == BluetoothDeviceState.connected
//                         ? const Icon(Icons.bluetooth_connected)
//                         : const Icon(Icons.bluetooth_disabled),
//                     snapshot.data == BluetoothDeviceState.connected
//                         ? StreamBuilder<int>(
//                         stream: rssiStream(),
//                         builder: (context, snapshot) {
//                           return Text(snapshot.hasData ? '${snapshot.data}dBm' : '',
//                               style: Theme.of(context).textTheme.caption);
//                         })
//                         : Text('', style: Theme.of(context).textTheme.caption),
//                   ],
//                 ),
//                 title: Text(
//                     'Device is ${snapshot.data.toString().split('.')[1]}.'),
//                 subtitle: Text('${device.id}'),
//                 trailing: StreamBuilder<bool>(
//                   stream: device.isDiscoveringServices,
//                   initialData: false,
//                   builder: (c, snapshot) => IndexedStack(
//                     index: snapshot.data! ? 1 : 0,
//                     children: <Widget>[
//                       IconButton(
//                         icon: const Icon(Icons.refresh),
//                         onPressed: () => device.discoverServices(),
//                       ),
//                       const IconButton(
//                         icon: SizedBox(
//                           child: CircularProgressIndicator(
//                             valueColor: AlwaysStoppedAnimation(Colors.grey),
//                           ),
//                           width: 18.0,
//                           height: 18.0,
//                         ),
//                         onPressed: null,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             StreamBuilder(
//               stream: device.mtu,
//               initialData: 0,
//               builder: (c, snapshot) => ListTile(
//                 title: const Text('MTU Size'),
//                 subtitle: Text('${snapshot.data} bytes'),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.edit),
//                   onPressed: () => device.requestMtu(223),
//                 ),
//               ),
//             ),
//             StreamBuilder<List<BluetoothService>>(
//               stream: device.services,
//               initialData: const [],
//               builder: (c, snapshot) {
//                 return Column(
//                   children: _buildServiceTiles(snapshot.data!),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Stream<int> rssiStream() async* {
//     var isConnected = true;
//     final subscription = device.state.listen((state) {
//       isConnected = state == BluetoothDeviceState.connected;
//     });
//     while (isConnected) {
//       yield await device.readRssi();
//       await Future.delayed(const Duration(seconds: 1));
//     }
//     subscription.cancel();
//     // Device disconnected, stopping RSSI stream
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:saathi/screens/home.dart';
import 'package:saathi/screens/login.dart';

import '../auth/googleSignIn.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({Key? key}) : super(key: key);

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final connectButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black,
      primary: HexColor('#AFE0D8'),
      padding: EdgeInsets.all(15),
      minimumSize: Size(double.maxFinite, 30),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2))));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Center(
          child: Image.asset('assets/images/logo5.png'),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset('assets/images/darkModeIcon.png'))
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Center(child: Image.asset('assets/images/logo3.png')),
            ),
            ListTile(
              title: Text('Profile'),
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
                  Navigator.pushReplacement(context,
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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: EdgeInsets.all(25),
            child: Center(
              child: BlueToothDesign(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(new MaterialPageRoute(
                    builder: (BuildContext context) => Home()));
              },
              child: Text('Connect to SAATHI Band'),
              style: connectButtonStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget BlueToothDesign() {
    return Container(
      alignment: Alignment.center,
      width: 257,
      height: 257,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          //color: HexColor('83CF9D'),
          border: Border.all(
            color: HexColor('83CF9D'),
          )),
      child: Container(
        alignment: Alignment.center,
        width: 239,
        height: 239,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: HexColor('#83CF9D')),
        ),
        child: Container(
          alignment: Alignment.center,
          width: 222,
          height: 222,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: HexColor('#83CF9D')),
          ),
          child: Container(
            alignment: Alignment.center,
            width: 205,
            height: 205,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: HexColor('#83CF9D')),
              color: HexColor('AFE0D8'),
            ),
            child: Icon(
              Icons.bluetooth,
              size: 80,
            ),
          ),
        ),
      ),
    );
  }
}
