import 'package:vintol/models/infraction.dart';
import 'package:vintol/models/product.dart';
import 'package:vintol/providers/local/database_provider.dart';
import 'package:vintol/screens/home/widgets/search_form.dart';
import 'package:vintol/widgets/menu_drawer.dart';
import 'package:vintol/screens/home/widgets/card_stack.dart';
import 'package:flutter/material.dart';
import 'package:vintol/configs/themes/app_colors.dart';

import 'package:vintol/generated/l10n.dart';

import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Infraction>>? infractions;

  @override
  void initState() {
    super.initState();

    // Listar infracciones de la BD
    //infractions = DatabaseProvider.db.getInfractions();
    infractions = DatabaseProvider.db.getDataExample();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[
              IconButton(
                onPressed: () async {
                  await showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(),
                  );
                },
                icon: const Icon(Icons.search, color: Colors.white),
              )
            ],
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
            future: infractions,
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
}
