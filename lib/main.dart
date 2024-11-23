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

import 'package:chessgame/get_controllers/ble_controller.dart';
import 'package:chessgame/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("BLE SCANNER"),
        ),
        body: GetBuilder<BLEController>(
          init: BLEController(),
          builder: (controller) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<List<ScanResult>>(
                      stream: controller.scanResult,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print("Found ${snapshot.data!.length} devices!");
                          // ... existing code ...
                          return Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  final data = snapshot.data![index];
                                  if (snapshot.hasData) {
                                    print(
                                        "Found ${snapshot.data!.length} devices!");
                                    // ... existing code ...
                                  }
                                  return Card(
                                    elevation: 2,
                                    child: ListTile(
                                      title: Text(data.device.platformName),
                                      subtitle: Text(data.device.remoteId.str),
                                      trailing: Text(data.rssi.toString()),
                                      // onTap: () => controller
                                      //     .connectToDevice(data.device),
                                    ),
                                  );
                                }),
                          );
                        } else {
                          return const Center(
                            child: Text("No Device Found"),
                          );
                        }
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        controller.scanDevices();
                        // await controller.disconnectDevice();
                      },
                      child: const Text("SCAN")),
                ],
              ),
            );
          },
        ));
  }
}
