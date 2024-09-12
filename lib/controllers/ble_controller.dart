import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

//import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_blue_plus_windows/flutter_blue_plus_windows.dart';
import 'package:vintol/widgets/dialogs.dart';

class BleController extends GetxController {
  var list = <ScanResult>[];

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

  Stream<BluetoothAdapterState> get getAdapterState =>
      FlutterBluePlus.adapterState;

  Stream<bool> get getIsScanning => FlutterBluePlus.isScanning;

  //var g = FlutterBluePlus.isScanningNow;

  //late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;

  void scanDevices() async {
    print("controller BleController scanDevices()...");
    list.clear();

    var subscription =
        FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      print(state);

      if (state == BluetoothAdapterState.on) {
        print("start scaning bluetooth is on ....");
        // Start scanning w/ timeout
        FlutterBluePlus.startScan(
          //timeout: const Duration(seconds: 15),
          androidUsesFineLocation: false,
        );

        // Listen to scan results
        FlutterBluePlus.scanResults.listen(
          (results) {
            if (results.isNotEmpty) {
              list = results;

              ScanResult r = results.last; // the most recently found device
              //print('${r.device.remoteId}: "${r}" found!');
              ////'${r.device.remoteId}: "${r.advertisementData.advName}" found!');
            }
          },
          onError: (e) => print(e),
        );
      } else {
        // show an error to the user, etc
      }
    });

    // cleanup: cancel subscription when scanning stops
    //FlutterBluePlus.cancelWhenScanComplete(subscription);

    // Wait for Bluetooth enabled & permission granted
    // In your real app you should use `FlutterBluePlus.adapterState.listen` to handle all states
    await FlutterBluePlus.adapterState
        .where((val) => val == BluetoothAdapterState.on)
        .first;

    // wait for scanning to stop
    await FlutterBluePlus.isScanning.where((val) => val == false).first;
  }

  connecting(BuildContext context, BluetoothDevice device) async {
    SnackBars.info(context, info: "Connecting");

    // listen for disconnection
    var subscription =
        device.connectionState.listen((BluetoothConnectionState state) async {
      SnackBars.info(context, info: state.name);
      if (state == BluetoothConnectionState.disconnected) {
        // 1. typically, start a periodic timer that tries to
        //    reconnect, or just call connect() again right now
        // 2. you must always re-discover services after disconnection!
        //print(
        //    "${device.disconnectReason?.code} ${device.disconnectReason?.description}");
        SnackBars.info(context,
            info:
                "Disconnected Reason: ${device.disconnectReason?.code} - ${device.disconnectReason?.description}");
      } else {
        if (state == BluetoothConnectionState.connected) {
          SnackBars.info(context, info: "CONNECTED");
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

  disconnectDevice(BluetoothDevice device) async {
    // Disconnect from device
    await device.disconnect();
  }

  stopScan() async {
    await FlutterBluePlus.stopScan();
  }

  Future<List<String>> getString(query) async {
    List<String> usuarios = ["string1", "string2", "string3"];
    return usuarios;
  }
}
