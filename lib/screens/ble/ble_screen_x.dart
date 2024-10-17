import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:vintol/configs/themes/app_colors.dart';

import 'package:vintol/controllers/ble_controller.dart';
import 'package:vintol/screens/ble/widget/ble_card.dart';
import 'package:vintol/widgets/dialogs.dart';

import 'package:vintol/widgets/menu_drawer.dart';

class BleScreenX extends StatefulWidget {
  const BleScreenX({super.key});

  @override
  State<BleScreenX> createState() => _BleScreenXState();
}

class _BleScreenXState extends State<BleScreenX> {
  //final Cv cv = Get.arguments;
  //late Future<List<String>> res;

  //BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
  //late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

  @override
  void initState() {
    super.initState();

    //Activando permisos
    _getPermissions();
  }

  @override
  void dispose() {
    //_adapterStateStateSubscription.cancel();
    //_bleController.scanResults();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFEDEDED),
        onPressed: () {
          Get.toNamed("/ble-scan");
        },
        child: const Icon(
          Icons.search,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: kDarkBlue,
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  color: Colors.white,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            title: const Text(
              "Bluetooth Device X",
              style: TextStyle(color: Colors.white),
            ),
            snap: true,
            floating: true,
            //pinned: true,
          ),
          const SliverFillRemaining(
            child: Center(
              child: Text("No hay dispositivos emparejados"),
            ),
          ),
        ],
      ),
    );
  }
}

Future _getPermissions() async {
  try {
    if (await Permission.speech.isPermanentlyDenied) {
      openAppSettings();
    }

    var u = await Permission.location.request();

    print(u.isGranted.toString() + " - la ubicaion esta activada");

    if (await Permission.bluetooth.request().isGranted) {
      _turnOnBluetooth();
    }
  } catch (e) {
    print(e.toString());
  }
}

_turnOnBluetooth() async {
  print("starting...");

  // if (await FlutterBluePlus.isSupported == false) {
  //   print("Bluetooth not supported by this device");
  //   return;
  // }

  if (Platform.isAndroid) {
    await FlutterBluePlus.turnOn();
  }
}
