import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.

        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('assets/images/splash_logo_dark.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
            child: SizedBox(
              height: double.maxFinite,
              child: Center(
                child: Text(""),
              ),
            ),
          ),
          ListTile(
            dense: true,
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              Get.offAllNamed("/");
            },
          ),
          ListTile(
            dense: true,
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            onTap: () {
              Get.offAllNamed("/settings");
            },
          ),
          ListTile(
            dense: true,
            leading: const Icon(Icons.bluetooth_drive),
            title: const Text('Bluetooth'),
            onTap: () {
              Get.offAllNamed("/ble-screen");
            },
          ),
        ],
      ),
    );
  }
}