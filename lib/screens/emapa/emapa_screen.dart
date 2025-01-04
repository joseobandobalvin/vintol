import 'package:flutter/material.dart';
import 'package:vintol/configs/themes/app_colors.dart';
import 'package:vintol/generated/l10n.dart';
import 'package:vintol/screens/emapa/widgets/emapa_search_form.dart';
import 'package:vintol/widgets/menu_drawer.dart';

class EmapacopsaScreen extends StatefulWidget {
  const EmapacopsaScreen({super.key});

  @override
  State<EmapacopsaScreen> createState() => _EmapacopsaScreenState();
}

class _EmapacopsaScreenState extends State<EmapacopsaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      body: CustomScrollView(
        slivers: [
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
              S.current.txEmapa,
              style: const TextStyle(color: Colors.white),
            ),
            //pinned: false,
            snap: true,
            floating: true,
            //expandedHeight: 60.0,
            elevation: 10.0,
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10.0,
            ),
          ),
          SliverToBoxAdapter(
            child: EmapaSearchForm(),
          ),
        ],
      ),
    );
  }
}
