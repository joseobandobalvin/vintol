import 'package:vintol/configs/themes/app_colors.dart';
import 'package:vintol/generated/l10n.dart';
import 'package:vintol/providers/database_provider.dart';
import 'package:vintol/screens/home/menu_drawer.dart';
import 'package:vintol/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: kLightBlue,
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
                ],
              ),
            ],
            title: Text(
              S.current.txtSettings,
              style: const TextStyle(color: Colors.white),
            ),
            //pinned: false,
            snap: true,
            floating: true,
            //expandedHeight: 60.0,
            elevation: 10.0,
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Column(
                children: [
                  ListTile(
                    trailing: const Icon(Icons.settings),
                    title: Text(S.current.txtDatabaseBackUp),
                    onTap: () async {
                      await DatabaseProvider.db.backupDB(context);
                    },
                  ),
                  ListTile(
                    title: Text(S.current.txtDatabaseRestore),
                    onTap: () async {
                      await DatabaseProvider.db.restoreDB();
                    },
                  ),
                  ListTile(
                    title: Text(S.current.txtDatabaseDelete),
                    onTap: () async {
                      bool res = await Dialogs.confirmAndroid(context,
                          title: S.current.txtDelete.toUpperCase(),
                          description: S.current.txtAskDeleteAction);

                      if (res) {
                        await DatabaseProvider.db.deleteDB();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
