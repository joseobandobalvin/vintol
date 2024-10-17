import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:vintol/configs/themes/app_colors.dart';

import 'package:vintol/controllers/ble_controller.dart';
import 'package:vintol/screens/ble/widget/ble_card.dart';
import 'package:vintol/widgets/dialogs.dart';

import 'package:vintol/widgets/menu_drawer.dart';

class BleScreen extends StatefulWidget {
  const BleScreen({super.key});

  @override
  State<BleScreen> createState() => _BleScreenState();
}

class _BleScreenState extends State<BleScreen> {
  //final Cv cv = Get.arguments;
  //late Future<List<String>> res;
  late BleController _bleController;
  late bool bluetoothIsOn = false;

  //BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
  //late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

  @override
  void initState() {
    _turnOnBluetooth();
    super.initState();

    _bleController = BleController();

    // _adapterStateStateSubscription =
    //     FlutterBluePlus.adapterState.listen((state) {
    //   _adapterState = state;
    //   if (mounted) {
    //     setState(() {});
    //   }
    // });
  }

  @override
  void dispose() {
    //_adapterStateStateSubscription.cancel();
    //_bleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _bleController.scanDevices();
      //   },
      //   child: const Icon(Icons.search),
      // ),
      floatingActionButton: StreamBuilder<bool>(
        stream: _bleController.getIsScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data!) {
            return FloatingActionButton(
              onPressed: () {
                _bleController.stopScan();
              },
              backgroundColor: const Color(0xFFEDEDED),
              child: const Icon(Icons.pause),
            );
          } else {
            return FloatingActionButton(
              backgroundColor: const Color(0xFFEDEDED),
              onPressed: () {
                _bleController.scanDevices();
              },
              child: const Icon(
                Icons.search,
              ),
            );
          }
        },
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
              "Bluetooth Devices",
              style: TextStyle(color: Colors.white),
            ),
            snap: true,
            floating: true,
            //pinned: true,
          ),
          SliverToBoxAdapter(
            child: SwitchListTile(
              activeColor: kDarkBlue,
              value: bluetoothIsOn,
              visualDensity: VisualDensity.compact,
              dense: true,
              title: const Text("Bluetooth"),
              onChanged: (val) {
                setState(() {
                  bluetoothIsOn = val;
                });
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.black12,
              width: double.infinity,
              child: const Text("Dispositivos visibles"),
            ),
          ),
          SliverFillRemaining(
            child: StreamBuilder<List<ScanResult>>(
              stream: _bleController.scanResults,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data![index];

                      return CardBluetoothLowEnergy(data);
                    },
                  );
                } else {
                  return const Center(
                    child: Text("No hay dispositivos emparejados"),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
    // return DefaultTabController(
    //   length: tabs.length,
    //   child: Scaffold(
    //     drawer: const MenuDrawer(),
    //     floatingActionButton: FloatingActionButton.extended(
    //       tooltip: "Scanear dispositivos",
    //       onPressed: () {
    //         Get.toNamed("/new-product");
    //       },
    //       label: Text(S.current.txtNew),
    //       icon: const Icon(Icons.search),
    //     ),
    //     body: NestedScrollView(
    //       headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
    //         return <Widget>[
    //           SliverOverlapAbsorber(
    //             handle:
    //                 NestedScrollView.sliverOverlapAbsorberHandleFor(context),
    //             sliver: SliverAppBar(
    //               backgroundColor: kDarkBlue,
    //               title: const Text(
    //                 "cv.nombreCompleto!",
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //               pinned: true,
    //               forceElevated: innerBoxIsScrolled,
    //               bottom: TabBar(
    //                 isScrollable: true,
    //                 indicatorColor: Colors.white,
    //                 tabAlignment: TabAlignment.start,
    //                 labelStyle: const TextStyle(color: Colors.white),
    //                 unselectedLabelColor: Colors.grey,
    //                 tabs: tabs.map((String name) => Tab(text: name)).toList(),
    //               ),
    //             ),
    //           ),
    //         ];
    //       },
    //       body: FutureBuilder(
    //         future: res,
    //         builder: (context, snapshot) {
    //           if (snapshot.connectionState == ConnectionState.done &&
    //               snapshot.data != null) {
    //             //print(snapshot.connectionState);
    //             return TabBarView(
    //               children: tabs.map((String name) {
    //                 return SafeArea(
    //                   top: false,
    //                   bottom: false,
    //                   child: Builder(
    //                     builder: (BuildContext context) {
    //                       return CustomScrollView(
    //                         key: PageStorageKey<String>(name),
    //                         slivers: <Widget>[
    //                           SliverOverlapInjector(
    //                             handle: NestedScrollView
    //                                 .sliverOverlapAbsorberHandleFor(context),
    //                           ),
    //                           SliverPadding(
    //                             padding: const EdgeInsets.all(8.0),
    //                             sliver: SliverFixedExtentList(
    //                               itemExtent: 48.0,
    //                               delegate: SliverChildBuilderDelegate(
    //                                 (BuildContext context, int index) {
    //                                   return ListTile(
    //                                     title: Text('Item $index'),
    //                                   );
    //                                 },
    //                                 childCount: 30,
    //                               ),
    //                             ),
    //                           ),
    //                         ],
    //                       );
    //                     },
    //                   ),
    //                 );
    //               }).toList(),
    //             );
    //             //return DetailInformation(snapshot.data!);
    //           }
    //           return const Center(
    //             child: CircularProgressIndicator(
    //               backgroundColor: Colors.black,
    //               color: Colors.black45,
    //               strokeWidth: 2.0,
    //             ),
    //           );
    //         },
    //       ),
    //     ),
    //   ),
    // );
  }

  _turnOnBluetooth() async {
    print("_turnOnBluetooth...");

    // if (await FlutterBluePlus.isSupported == false) {
    //   print("Bluetooth not supported by this device");
    //   return;
    // }

    if (await Permission.bluetoothScan.request().isGranted) {
      setState(() {
        bluetoothIsOn = true;
      });
      print("is granted ble");
    }

    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }
  }
}
