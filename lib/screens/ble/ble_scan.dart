import 'package:flutter/material.dart';
//import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_blue_plus_windows/flutter_blue_plus_windows.dart';
import 'package:get/get.dart';
import 'package:vintol/configs/themes/app_colors.dart';
import 'package:vintol/controllers/ble_controller.dart';
import 'package:vintol/screens/ble/widget/ble_card.dart';
import 'package:vintol/widgets/dialogs.dart';

class BleScan extends StatefulWidget {
  const BleScan({super.key});

  @override
  State<BleScan> createState() => _BleScanState();
}

class _BleScanState extends State<BleScan> {
  //final BleController _bleController = BleController();
  final _bleController = Get.put(BleController());

  @override
  void initState() {
    super.initState();
    _bleController.scanDevices();
  }

  @override
  void dispose() {
    _bleController.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: const MenuDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
              },
            ),
            actions: [
              StreamBuilder<bool>(
                stream: _bleController.getIsScanning,
                initialData: false,
                builder: (c, snapshot) {
                  if (snapshot.data!) {
                    // return GestureDetector(
                    //   child: const SizedBox(
                    //     width: 30,
                    //     child: LinearProgressIndicator(
                    //       backgroundColor: Colors.white,
                    //       color: Colors.black45,
                    //       minHeight: 2,
                    //     ),
                    //   ),
                    //   onTap: () {
                    //     print("stopping..................");
                    //     _bleController.stopScan();
                    //   },
                    // );
                    return IconButton(
                      onPressed: () {
                        _bleController.stopScan();
                      },
                      icon: const SizedBox(
                        width: 20,
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.white,
                          color: Colors.black45,
                          minHeight: 2,
                        ),
                      ),
                    );
                  } else {
                    return IconButton(
                      onPressed: () {
                        _bleController.scanDevices();
                      },
                      icon: const Icon(Icons.play_arrow, color: Colors.white),
                    );
                  }
                },
              ),
            ],
            backgroundColor: kDarkBlue,
            title: const Text(
              "Bluetooth Scanning",
              style: TextStyle(color: Colors.white),
            ),
            pinned: true,
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

                      return GestureDetector(
                        onLongPress: () {
                          Dialogs.info(
                            context,
                            data,
                            btnText: "Cerrar",
                          );
                        },
                        onTap: () {
                          print("onTap.......");

                          //_bleController.readData(data.device);
                          if (data.device.isDisconnected) {
                            Get.toNamed(
                              "/ble-detail",
                              arguments: data,
                            );
                          }
                        },
                        onDoubleTap: () {
                          print("onDoubleTap.......");
                          if (data.advertisementData.connectable) {
                            _bleController.connectToDevice(data.device);
                          }
                        },
                        onHorizontalDragDown: (gg) {
                          if (data.device.isConnected) {
                            _bleController.disconnectDevice(
                                context, data.device);
                          }
                        },
                        child: CardBluetoothLowEnergy(data),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text("Scanning"),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class BleScan extends GetView<BleController> {
//   BleScan({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //drawer: const MenuDrawer(),
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             leading: Builder(
//               builder: (context) {
//                 return IconButton(
//                   icon: const Icon(Icons.arrow_back),
//                   color: Colors.white,
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 );
//               },
//             ),
//             backgroundColor: kDarkBlue,
//             title: const Text(
//               "Bluetooth Scanning",
//               style: TextStyle(color: Colors.white),
//             ),
//             snap: true,
//             floating: true,
//             //pinned: true,
//           ),
//           SliverFillRemaining(
//             child: StreamBuilder<List<ScanResult>>(
//               stream: controller.scanResults,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       final data = snapshot.data![index];

//                       return GestureDetector(
//                         onLongPress: () {
//                           Dialogs.info(
//                             context,
//                             data,
//                             btnText: "Cerrar",
//                           );
//                         },
//                         onTap: () {
//                           print("onTap.......");

//                           controller.readData(data.device);
//                           if (data.device.isDisconnected) {
//                             Get.toNamed(
//                               "/ble-detail",
//                               arguments: data,
//                             );
//                           }
//                         },
//                         onDoubleTap: () {
//                           if (data.advertisementData.connectable) {
//                             controller.connectDevice(context, data.device);
//                           }
//                         },
//                         onHorizontalDragDown: (gg) {
//                           if (data.device.isConnected) {
//                             controller.disconnectDevice(context, data.device);
//                           }
//                         },
//                         child: CardBluetoothLowEnergy(data),
//                       );
//                     },
//                   );
//                 } else {
//                   return const Center(
//                     child: Text("Scanning"),
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
