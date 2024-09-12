import 'package:flutter/material.dart';

import 'package:vintol/models/ble.dart';
import 'package:vintol/screens/ble/widget/ble_card.dart';

class ListBluetoothLowEnergy extends StatelessWidget {
  final List<Ble> listBle;
  const ListBluetoothLowEnergy(this.listBle, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return CustomScrollView(
            key: PageStorageKey<String>("--"),
            slivers: <Widget>[
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              listBle.isNotEmpty
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          //return CardBluetoothLowEnergy(listBle[index]);
                        },
                        childCount: listBle.length,
                      ),
                    )
                  : SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        child:
                            const Text("No hay dispositivos Bluetooth cerca"),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
