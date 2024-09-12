import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:path/path.dart';
import 'package:vintol/models/ble.dart';

class CardBluetoothLowEnergy extends StatelessWidget {
  final ScanResult ble;
  const CardBluetoothLowEnergy(this.ble, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        key: Key(ble.device.remoteId.str),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.grey),
          ),
        ),
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(4.0),
        child: Row(
          children: [
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
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ble.device.remoteId.toString(),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: ble.advertisementData.connectable
                  ? Text(
                      ble.rssi.toString(),
                      style: const TextStyle(color: Colors.green),
                    )
                  : Text(
                      ble.rssi.toString(),
                    ),
            ),
          ],
        ));
  }
}
