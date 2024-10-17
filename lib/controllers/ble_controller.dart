import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

//import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_blue_plus_windows/flutter_blue_plus_windows.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vintol/models/device_info.dart';
import 'package:vintol/widgets/dialogs.dart';

class BleController extends GetxController {
  var list = <ScanResult>[];

  BluetoothDevice? selectedDevice;
  BluetoothCharacteristic? selectedCharacteristic;
  List<BluetoothService> availableServices = [];
  List<BluetoothCharacteristic> availableCharacteristics = [];
  late String value = "";

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;
  Stream<BluetoothAdapterState> get getAdapterState =>
      FlutterBluePlus.adapterState;

  Stream<bool> get getIsScanning => FlutterBluePlus.isScanning;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    //_adapterStateStateSubscription.cancel();

    FlutterBluePlus.stopScan();
    super.dispose();
  }

  //Stream<BluetoothConnectionState> tt = Stream.;

  late BluetoothConnectionState stateBluetoothConnectionState =
      BluetoothConnectionState.disconnected;

  //late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  //BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;

//***********************************************************/
  void setSelectedDevice(BluetoothDevice? device) {
    selectedDevice = device;
    update();
  }

  Future<void> connectToSelectedDevice() async {
    if (selectedDevice != null) {
      await connectToDevice(selectedDevice!);
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      await discoverServices(device);
      update(); // Notify listeners
    } catch (e) {
      print(e);
    }
  }

  Future<void> discoverServices(BluetoothDevice device) async {
    try {
      List<BluetoothService> services =
          (await device.discoverServices()).cast<BluetoothService>();
      availableServices = services;
      // Clear the list of characteristics before adding new ones
      availableCharacteristics.clear();

      for (BluetoothService service in services) {
        availableCharacteristics.addAll(service.characteristics);
      }
    } catch (e) {
      print(e);
    }
  }

  //
  Future<List<BluetoothService>> getAvailableServices() async {
    return availableServices;
  }
  //

  Future<void> disconnectToSelectedDevice() async {
    if (selectedDevice != null) {
      await disconnectToDevice(selectedDevice!);
    }
  }

  Future<void> disconnectToDevice(BluetoothDevice device) async {
    try {
      await device.disconnect();
      selectedDevice = null; // Reset selected device on disconnection
      availableServices.clear(); // Clear the list of services
      availableCharacteristics.clear(); // Clear the list of characteristics
      selectedCharacteristic =
          null; // Reset selected characteristic on disconnection
      update(); // Notify listeners
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveSelectedDeviceToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (selectedDevice != null) {
      String deviceJson = jsonEncode(
          DeviceInfo(id: selectedDevice!.id.id, name: selectedDevice!.name)
              .toMap());
      prefs.setString('selectedDevice', deviceJson);
    }
  }

  Future<BluetoothDevice?> loadSelectedDeviceFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? deviceJson = prefs.getString('selectedDevice');

    if (deviceJson != null) {
      DeviceInfo deviceInfo = DeviceInfo.fromMap(jsonDecode(deviceJson));

      // Fetch the connected devices and find the matching device
      List<BluetoothDevice> connectedDevices = FlutterBluePlus.connectedDevices;
      selectedDevice = connectedDevices.firstWhere(
        (device) =>
            device.platformName == deviceInfo.name &&
            device.remoteId.toString() == deviceInfo.id,
      );

      update(); // Notify listeners
      return selectedDevice;
    }

    return null; // Return null if no device is found in preferences
  }

  Future<String> readFromDevice(BluetoothDevice device) async {
    if (selectedCharacteristic == null) {
      try {
        value = (await selectedCharacteristic?.read()) as String;
        print('Read value: $value');
      } catch (e) {
        print(e);
      }
    } else {
      value = 'Read function is not performing';
    }
    return value;
  }

  Future<void> writeToDevice(BluetoothDevice device, String data) async {
    if (selectedCharacteristic != null) {
      try {
        await selectedCharacteristic?.write(data.codeUnits,
            withoutResponse: false);
        print('Write successful');
      } catch (e) {
        print(e);
      }
    }
  }

  BluetoothCharacteristic? findCharacteristicByUuid(
      BluetoothDevice device, String uuid) {
    for (BluetoothService service in availableServices) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.uuid.toString() == uuid) {
          return characteristic;
        }
      }
    }
    return null;
  }

  Future<void> scanDevices() async {
    if (await Permission.bluetoothScan.request().isGranted &&
        await Permission.bluetoothConnect.request().isGranted) {
      FlutterBluePlus.startScan();
    }
  }

//***********************************************************/

  // Future<void> scanDevices() async {
  //   print("controller BleController scanDevices()...");

  //   var subscription =
  //       FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
  //     print(state);

  //     if (state == BluetoothAdapterState.on) {
  //       print("start scaning bluetooth is on ....");
  //       // Start scanning w/ timeout
  //       FlutterBluePlus.startScan(
  //         //timeout: const Duration(seconds: 15),
  //         androidUsesFineLocation: false,
  //       );

  //       // Listen to scan results
  //       FlutterBluePlus.scanResults.listen(
  //         (results) {
  //           if (results.isNotEmpty) {
  //             list = results;

  //             ScanResult r = results.last; // the most recently found device
  //             print('${r.device.remoteId}: "${r}" found!');
  //             ////'${r.device.remoteId}: "${r.advertisementData.advName}" found!');
  //           }
  //         },
  //         onError: (e) => print(e),
  //       );
  //     } else {
  //       // show an error to the user, etc
  //     }
  //   });

  //   // cleanup: cancel subscription when scanning stops
  //   //FlutterBluePlus.cancelWhenScanComplete(subscription);

  //   // Wait for Bluetooth enabled & permission granted
  //   // In your real app you should use `FlutterBluePlus.adapterState.listen` to handle all states
  //   await FlutterBluePlus.adapterState
  //       .where((val) => val == BluetoothAdapterState.on)
  //       .first;

  //   // wait for scanning to stop
  //   await FlutterBluePlus.isScanning.where((val) => val == false).first;
  // }

  connectDevice(BuildContext context, BluetoothDevice device) async {
    // listen for disconnection
    SnackBars.info(context, info: "CONNECTING...");
    var subscription =
        device.connectionState.listen((BluetoothConnectionState state) async {
      if (state == BluetoothConnectionState.disconnected) {
        // 1. typically, start a periodic timer that tries to
        //    reconnect, or just call connect() again right now
        // 2. you must always re-discover services after disconnection!
        //print(
        //    "${device.disconnectReason?.code} ${device.disconnectReason?.description}");
        SnackBars.info(context,
            info:
                "Disconnected Reason: ${device.disconnectReason?.code} - ${device.disconnectReason?.description}");

        if (device.disconnectReason!.code! > 0) {
          SnackBars.info(context,
              info:
                  "Disconnected Reason: ${device.disconnectReason?.code} - ${device.disconnectReason?.description}");
        }
      } else {
        if (state == BluetoothConnectionState.connected) {
          SnackBars.info(context, info: "CONNECTED");
          print("START SERVICES");

          List<BluetoothService> services = await device.discoverServices();
          services.forEach((service) {
            print(service.toString());
            SnackBars.info(context, info: service.toString());
          });
          print("END SERVICES");
        }
      }
    });

    // cleanup: cancel subscription when disconnected
    //   - [delayed] This option is only meant for `connectionState` subscriptions.
    //     When `true`, we cancel after a small delay. This ensures the `connectionState`
    //     listener receives the `disconnected` event.
    //   - [next] if true, the the stream will be canceled only on the *next* disconnection,
    //     not the current disconnection. This is useful if you setup your subscriptions
    //     before you connect.
    device.cancelWhenDisconnected(subscription, delayed: true, next: true);

    await device.connect(
      timeout: const Duration(seconds: 35),
    );
  }

  disconnectDevice(BuildContext context, BluetoothDevice device) async {
    // Disconnect from device
    SnackBars.info(context, info: "DISCONNECTING...");
    await device.disconnect();
  }

  readData(BluetoothDevice device) async {
    print("READ DATA SERVICES..............");
    List<BluetoothService> services = await device.discoverServices();

    BluetoothService lastservice = services.last;

    BluetoothCharacteristic lastCharacterist = lastservice.characteristics.last;
    print("SERVICES..............");
    print(lastservice);
  }

  stopScan() {
    FlutterBluePlus.stopScan();
  }

  Future<List<String>> getString() async {
    List<String> usuarios = ["string1", "string2", "string3"];
    return usuarios;
  }

  Future<List<String>> getString1() async {
    List<String> usuarios = ["string4", "string7", "string8"];
    return usuarios;
  }
}
