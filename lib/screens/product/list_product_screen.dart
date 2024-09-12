import 'package:audioplayers/audioplayers.dart';
import 'package:vintol/generated/l10n.dart';
import 'package:vintol/models/product.dart';
import 'package:vintol/providers/local/database_provider.dart';
import 'package:vintol/widgets/menu_drawer.dart';

import 'package:vintol/screens/home/widgets/card_stack.dart';
import 'package:flutter/material.dart';
import 'package:vintol/configs/themes/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({super.key});

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  Future<List<Product>>? products;

  late AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();

    // Create the audio player
    player = AudioPlayer();

    // Set the release mode to keep the source after playback has completed.
    player.setReleaseMode(ReleaseMode.stop);
    // Listar productos de la BD
    products = DatabaseProvider.db.getProducts();
    // products = DatabaseProvider.db.getDataExample();
  }

  @override
  void dispose() {
    // Release all sources and dispose the player.
    player.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: kLightBlue,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed("/new-product");
        },
        label: Text(S.current.txtNew),
        icon: const Icon(Icons.add),
      ),
      drawer: const MenuDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
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
            backgroundColor: kDarkBlue,

            actions: <Widget>[
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.offAllNamed("/");
                    },
                    icon: const Icon(Icons.home, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () async {},
                    icon: const Icon(Icons.search, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () async {
                      await _searchBarcode();
                    },
                    icon:
                        const Icon(Icons.qr_code_scanner, color: Colors.white),
                  ),
                ],
              ),
            ],
            title: Text(
              S.current.txtProducts,
              style: const TextStyle(color: Colors.white),
            ),
            //pinned: false,
            snap: true,
            floating: true,
            //expandedHeight: 60.0,
            elevation: 10.0,
          ),
          SlidableAutoCloseBehavior(
            child: FutureBuilder(
              future: products,
              builder: (context, snapshot) {
                var childCount = 0;
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data != null) {
                  childCount = snapshot.data!.length;
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return CardStack(snapshot.data![index]);
                      },
                      childCount: childCount,
                    ),
                  );
                }

                return const SliverToBoxAdapter(
                  child: Center(
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.white,
                      color: Colors.black45,
                      minHeight: 2,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _searchBarcode() async {
    Product p;
    String res;

    try {
      res = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', S.current.txtCancel, true, ScanMode.BARCODE);
      p = await DatabaseProvider.db.getByBarcode(res);
      _soundBeep();
      Get.toNamed(
        "/new-product",
        arguments: p,
      );
    } on PlatformException {
      res = 'Fallo al obtener version de plataforma';
    }
  }

  void _soundBeep() async {
    await player.play(AssetSource('media/beeponetone.mp3'));
  }
}
