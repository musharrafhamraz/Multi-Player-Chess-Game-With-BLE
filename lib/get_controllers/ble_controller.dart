// // import 'package:flutter_blue/flutter_blue.dart';
// // import 'package:get/get.dart';
// // import 'package:permission_handler/permission_handler.dart';

// // class BleController extends GetxController {
// //   FlutterBlue ble = FlutterBlue.instance;

// // // This Function will help users to scan near by BLE devices and get the list of Bluetooth devices.
// //   Future scanDevices() async {
// //     if (await Permission.bluetoothScan.request().isGranted) {
// //       if (await Permission.bluetoothConnect.request().isGranted) {
// //         ble.startScan(timeout: const Duration(seconds: 15));

// //         ble.stopScan();
// //       }
// //     }
// //   }

// // // This function will help user to connect to BLE devices.
// //   Future<void> connectToDevice(BluetoothDevice device) async {
// //     await device.connect(timeout: const Duration(seconds: 15));

// //     device.state.listen((isConnected) {
// //       if (isConnected == BluetoothDeviceState.connecting) {
// //         print("Device connecting to: ${device.name}");
// //       } else if (isConnected == BluetoothDeviceState.connected) {
// //         print("Device connected: ${device.name}");
// //       } else {
// //         print("Device Disconnected");
// //       }
// //     });
// //   }

// //   Stream<List<ScanResult>> get scanResults => ble.scanResults;
// // }
// import 'package:flutter_blue/flutter_blue.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';

// class BleController extends GetxController {
//   final FlutterBlue ble = FlutterBlue.instance;
//   final RxList<ScanResult> devicesList = <ScanResult>[].obs;

//   /// This function scans nearby BLE devices and populates the `devicesList`.
//   Future<void> scanDevices() async {
//     try {
//       // Request required permissions
//       if (await _requestPermissions()) {
//         // Clear existing results
//         devicesList.clear();

//         // Start scanning
//         ble.startScan(timeout: const Duration(seconds: 15));

//         // Listen to scan results
//         ble.scanResults.listen((results) {
//           devicesList.addAll(results);
//           for (var result in results) {
//             print('Device found: ${result.device.name}, RSSI: ${result.rssi}');
//           }
//         });

//         // Stop scanning after timeout
//         Future.delayed(const Duration(seconds: 15), () {
//           ble.stopScan();
//         });
//       } else {
//         print("Permissions not granted.");
//       }
//     } catch (e) {
//       print("Error while scanning devices: $e");
//     }
//   }

//   /// This function connects to a BLE device and listens to its connection state.
//   Future<void> connectToDevice(BluetoothDevice device) async {
//     try {
//       await device.connect(autoConnect: false);

//       device.state.listen((connectionState) {
//         if (connectionState == BluetoothDeviceState.connected) {
//           print("Device connected: ${device.name}");
//         } else if (connectionState == BluetoothDeviceState.disconnected) {
//           print("Device disconnected: ${device.name}");
//         }
//       });
//     } catch (e) {
//       print("Error while connecting to device: $e");
//     }
//   }

//   /// Helper function to request required Bluetooth permissions.
//   Future<bool> _requestPermissions() async {
//     final bluetoothScanStatus = await Permission.bluetoothScan.request();
//     final bluetoothConnectStatus = await Permission.bluetoothConnect.request();
//     final locationStatus = await Permission.locationWhenInUse.request();

//     return bluetoothScanStatus.isGranted &&
//         bluetoothConnectStatus.isGranted &&
//         locationStatus.isGranted;
//   }

//   /// Exposes a stream of scan results to the UI.
//   Stream<List<ScanResult>> get scanResultsStream => ble.scanResults;
// }

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BLEController {
  // final FlutterBluePlus _flutterBlue = FlutterBluePlus.instance;

  // Stream for scanning devices
  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

  // Stream for checking the Bluetooth adapter state
  Stream<BluetoothAdapterState> get adapterState =>
      FlutterBluePlus.adapterState;

  // Start scanning for BLE devices
  Future<void> startScan(
      {Duration timeout = const Duration(seconds: 10)}) async {
    try {
      // Ensure Bluetooth is enabled before scanning
      final state = await FlutterBluePlus.adapterState.first;
      if (state != BluetoothAdapterState.on) {
        throw Exception('Bluetooth is not enabled. Please enable Bluetooth.');
      }

      // Start scanning
      await FlutterBluePlus.startScan(timeout: timeout);
    } catch (e) {
      rethrow;
    }
  }

  // Stop scanning for BLE devices
  Future<void> stopScan() async {
    try {
      await FlutterBluePlus.stopScan();
    } catch (e) {
      rethrow;
    }
  }

  // Connect to a BLE device
  Future<BluetoothDevice> connectToDevice(ScanResult scanResult) async {
    final device = scanResult.device;
    try {
      // Listen to connection state changes
      device.connectionState.listen((state) {
        if (state == BluetoothConnectionState.connected) {
          print('Device connected: ${device.name}');
        } else if (state == BluetoothConnectionState.disconnected) {
          print('Device disconnected: ${device.name}');
        }
      });

      // Connect to the device
      await device.connect();
      return device;
    } catch (e) {
      rethrow;
    }
  }

  // Disconnect from a BLE device
  Future<void> disconnectFromDevice(BluetoothDevice device) async {
    try {
      await device.disconnect();
    } catch (e) {
      rethrow;
    }
  }

  // Discover services and characteristics
  Future<List<BluetoothService>> discoverServices(
      BluetoothDevice device) async {
    try {
      return await device.discoverServices();
    } catch (e) {
      rethrow;
    }
  }

  // Read a characteristic's value
  Future<List<int>> readCharacteristic(
      BluetoothCharacteristic characteristic) async {
    try {
      return await characteristic.read();
    } catch (e) {
      rethrow;
    }
  }

  // Write a value to a characteristic
  Future<void> writeCharacteristic(
    BluetoothCharacteristic characteristic,
    List<int> value, {
    bool withoutResponse = false,
  }) async {
    try {
      await characteristic.write(value, withoutResponse: withoutResponse);
    } catch (e) {
      rethrow;
    }
  }

  // Subscribe to a characteristic
  Stream<List<int>> subscribeToCharacteristic(
      BluetoothCharacteristic characteristic) {
    try {
      characteristic.setNotifyValue(true);
      return characteristic.onValueReceived;
    } catch (e) {
      rethrow;
    }
  }

  // Dispose resources
  void dispose() {
    FlutterBluePlus.stopScan();
  }
}
