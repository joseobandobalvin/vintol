import 'package:vintol/models/product.dart';
import 'package:vintol/providers/local/database_provider.dart';
import 'package:vintol/widgets/menu_drawer.dart';
import 'package:vintol/screens/home/widgets/card_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:vintol/configs/themes/app_colors.dart';

import 'package:vintol/generated/l10n.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //var users = Get.arguments; ,,,
  Future<List<Product>>? products;

  // getProducts() async {
  //   p = await DatabaseProvider.db.getProducts();
  //   return p;
  // }

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
      floatingActionButton: FloatingActionButton(
        onPressed: _scanBarcodeStream,
        child: const Icon(Icons.qr_code_scanner),
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

            title: Text(
              S.current.txHome,
              style: const TextStyle(color: Colors.white),
            ),
            //pinned: false,
            snap: true,
            floating: true,
            //expandedHeight: 60.0,
            elevation: 10.0,
          ),
          FutureBuilder(
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
        ],
      ),
    );
  }

  void _scanBarcodeStream() {}

  void _navigateToDetail(List<Product> barcodeLista) {
    Get.toNamed(
      "/detail-product",
      arguments: barcodeLista,
    );
  }
}
