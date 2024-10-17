import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_blue_plus_windows/flutter_blue_plus_windows.dart';
import 'package:get/get.dart';
import 'package:vintol/configs/themes/app_colors.dart';
import 'package:vintol/controllers/ble_controller.dart';

class BleDetail extends StatefulWidget {
  const BleDetail({super.key});

  @override
  State<BleDetail> createState() => _BleDetailState();
}

class _BleDetailState extends State<BleDetail> {
  final controller = Get.put(BleController());
  final ScanResult scanResult = Get.arguments;

  RxBool isConnected = false.obs;

  late Future<List<BluetoothService>> _list;
  //late Future<List<String>> _list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _list = controller.getAvailableServices();
    //_list = controller.getString();
    controller.connectToDevice(scanResult.device);
  }

  @override
  Widget build(BuildContext context) {
    print(scanResult);
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
            backgroundColor: kDarkBlue,
            title: const Text(
              "Bluetooth Detail",
              style: TextStyle(color: Colors.white),
            ),
            // snap: true,
            // floating: true,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                const Expanded(
                  flex: 3,
                  child: Text("Status:"),
                ),
                Expanded(
                  flex: 8,
                  child: StreamBuilder<BluetoothConnectionState>(
                    stream: scanResult.device.connectionState,
                    builder: (context, snapshot) {
                      print(snapshot.hasData);
                      if (snapshot.hasData) {
                        //return Text(snapshot.connectionState.toString());
                        if (snapshot.data ==
                            BluetoothConnectionState.connected) {
                          isConnected.value = true;
                          _getDataServices();
                          return Text("Conectado");
                        } else {
                          //_getDataServices();
                          return Text("No conectado");
                        }
                      }
                      return Text(snapshot.connectionState.toString());
                    },
                  ),
                ),
                const Expanded(
                  flex: 4,
                  child: Text(
                    "Connect",
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              //Elimina espacio extra dentro del contenido
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                scanResult.advertisementData.advName.isNotEmpty
                    ? Text(
                        scanResult.advertisementData.advName,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )
                    : const Text(
                        "Dispositivo desconocido",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                Text(scanResult.device.remoteId.toString()),
                const Text(
                  "Datos del fabricante :",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(scanResult.advertisementData.manufacturerData.toString()),
                const Text(
                  "Fecha y hora :",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(scanResult.timeStamp.toString()),
                Text(scanResult.timeStamp.timeZoneName),
              ],
            ),
          ),
          // SliverFillRemaining(
          //   child: Center(
          //     child: FilledButton(
          //       style: ButtonStyle(
          //           backgroundColor: WidgetStateProperty.resolveWith((states) {
          //         if (states.contains(WidgetState.pressed)) {
          //           return Colors.lightBlue;
          //         }
          //         return kDarkBlue;
          //       })),
          //       onPressed: () {
          //         controller.connectToDevice(scanResult.device);
          //       },
          //       child: const Text("Conectar"),
          //     ),
          //   ),
          // ),

          FutureBuilder(
            future: _list,
            builder: (context, snapshot) {
              var childCount = 0;
              if (snapshot.connectionState != ConnectionState.done) {
                return const SliverFillRemaining(
                  child: Text("Loading..."),
                );
              }
              //Snapshot has data
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data!.isNotEmpty) {
                childCount = snapshot.data!.length;

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Text(snapshot.data![index].toString());
                    },
                    childCount: childCount,
                  ),
                );
              }
              //Error del snapshot
              if (snapshot.hasError) {
                return const SliverFillRemaining(
                  child: Text("hay errores en el snapshot"),
                );
              }

              return SliverFillRemaining(
                child: Center(
                  child: FilledButton(
                    style: ButtonStyle(backgroundColor:
                        WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.pressed)) {
                        return Colors.lightBlue;
                      }
                      return kDarkBlue;
                    })),
                    onPressed: () {
                      controller.connectToDevice(scanResult.device);
                    },
                    child: const Text("Conectar"),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  _getDataServices() async {
    print("_getDataService");
    setState(() {
      _list.printInfo();
      _list = controller.getAvailableServices();
      //_list = controller.getString1();
    });
  }
}



// class BleDetail extends GetView<BleController> {
//   const BleDetail({super.key});

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
//                   icon: Icon(Icons.arrow_back),
//                   color: Colors.white,
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 );
//               },
//             ),
//             backgroundColor: kDarkBlue,
//             title: const Text(
//               "Bluetooth Detail",
//               style: TextStyle(color: Colors.white),
//             ),
//             snap: true,
//             floating: true,
//             //pinned: true,
//           ),
//         ],
//       ),
//     );
//   }
// }
