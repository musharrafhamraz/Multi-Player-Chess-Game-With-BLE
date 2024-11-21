// import 'package:chessgame/screens/game_screen.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const GameScreen(),
//     );
//   }
// }

// import 'package:chessgame/get_controllers/ble_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_blue/flutter_blue.dart';
// import 'package:get/get.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("BLE SCANNER"),
//         ),
//         body: GetBuilder<BleController>(
//           init: BleController(),
//           builder: (BleController controller) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   StreamBuilder<List<ScanResult>>(
//                       stream: controller.scanResultsStream,
//                       builder: (context, snapshot) {
//                         if (snapshot.hasData) {
//                           return Expanded(
//                             child: ListView.builder(
//                                 shrinkWrap: true,
//                                 itemCount: snapshot.data!.length,
//                                 itemBuilder: (context, index) {
//                                   final data = snapshot.data![index];
//                                   return Card(
//                                     elevation: 2,
//                                     child: ListTile(
//                                       title: Text(data.device.name),
//                                       subtitle: Text(data.device.id.id),
//                                       trailing: Text(data.rssi.toString()),
//                                       onTap: () => controller
//                                           .connectToDevice(data.device),
//                                     ),
//                                   );
//                                 }),
//                           );
//                         } else {
//                           return Center(
//                             child: Text("No Device Found"),
//                           );
//                         }
//                       }),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   ElevatedButton(
//                       onPressed: () async {
//                         controller.scanDevices();
//                         // await controller.disconnectDevice();
//                       },
//                       child: Text("SCAN")),
//                 ],
//               ),
//             );
//           },
//         ));
//   }
// }

import 'package:chessgame/get_controllers/ble_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

void main() {
  runApp(BLEScannerApp());
}

class BLEScannerApp extends StatelessWidget {
  const BLEScannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLE Scanner',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BLEScannerScreen(),
    );
  }
}

class BLEScannerScreen extends StatefulWidget {
  const BLEScannerScreen({super.key});

  @override
  _BLEScannerScreenState createState() => _BLEScannerScreenState();
}

class _BLEScannerScreenState extends State<BLEScannerScreen> {
  final BLEController _bleController = BLEController();
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _checkBluetoothState();
  }

  Future<void> _checkBluetoothState() async {
    _bleController.adapterState.listen((state) {
      if (state != BluetoothAdapterState.on) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Bluetooth is off'),
            content: Text('Please enable Bluetooth to use this app.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      }
    });
  }

  void _startScan() async {
    setState(() {
      _isScanning = true;
    });

    await _bleController.startScan(timeout: Duration(seconds: 10));

    setState(() {
      _isScanning = false;
    });
  }

  void _stopScan() async {
    await _bleController.stopScan();
    setState(() {
      _isScanning = false;
    });
  }

  void _connectToDevice(ScanResult result) async {
    try {
      await _bleController.connectToDevice(result);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Connected to ${result.device.name}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to connect: $e')),
      );
    }
  }

  @override
  void dispose() {
    _bleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BLE Scanner'),
        actions: [
          if (_isScanning)
            IconButton(
              icon: Icon(Icons.stop),
              onPressed: _stopScan,
            )
          else
            IconButton(
              icon: Icon(Icons.search),
              onPressed: _startScan,
            ),
        ],
      ),
      body: StreamBuilder<List<ScanResult>>(
        stream: _bleController.scanResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final results = snapshot.data ?? [];

          if (results.isEmpty) {
            return Center(child: Text('No devices found. Start scanning.'));
          }

          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final result = results[index];
              return Card(
                child: ListTile(
                  leading: Icon(Icons.bluetooth),
                  title: Text(result.device.name.isNotEmpty
                      ? result.device.name
                      : 'Unknown Device'),
                  subtitle: Text(result.device.id.toString()),
                  trailing: ElevatedButton(
                    child: Text('Connect'),
                    onPressed: () => _connectToDevice(result),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
