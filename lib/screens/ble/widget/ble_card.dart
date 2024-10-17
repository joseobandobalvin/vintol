import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:vintol/configs/themes/app_colors.dart';
import 'package:vintol/controllers/ble_controller.dart';

class CardBluetoothLowEnergy extends GetView<BleController> {
  final ScanResult ble;

  const CardBluetoothLowEnergy(this.ble, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        key: Key(ble.device.remoteId.str),
        decoration: BoxDecoration(
          border: ble.device.isConnected
              ? const Border(
                  bottom: BorderSide(width: 1.0, color: kDarkBlue),
                )
              : const Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey),
                ),
        ),
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
        ),
        margin: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(
                right: 4.0,
              ),
              height: 32,
              width: 3,
              color: ble.device.isConnected
                  ? kDarkBlue
                  : Colors.grey.withOpacity(0.7),
            ),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ble.advertisementData.advName.isNotEmpty
                        ? ble.advertisementData.advName
                        : "Dispositivo desconocido",
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: ble.device.isConnected ? kDarkBlue : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ble.device.remoteId.toString(),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: ble.device.isConnected ? kDarkBlue : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  ble.advertisementData.connectable
                      ? Text(
                          ble.rssi.toString(),
                          style: const TextStyle(color: Colors.green),
                        )
                      : Text(
                          ble.rssi.toString(),
                        ),
                  ble.advertisementData.connectable
                      ? IconButton(
                          iconSize: 24.0,
                          icon: const Icon(
                            Icons.bluetooth_audio_sharp,
                            color: kDarkBlue,
                          ),
                          onPressed: () {
                            controller.stopScan();
                            Get.toNamed("/ble-detail", arguments: ble);
                          },
                        )
                      : const Text(""),
                ],
              ),
            ),
          ],
        ));
  }
}
