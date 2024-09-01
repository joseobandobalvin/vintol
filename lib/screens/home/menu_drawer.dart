import 'package:vintol/configs/themes/app_colors.dart';
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
              color: kDarkBlue,
            ),
            child: SizedBox(
              height: double.maxFinite,
              child: Center(
                child: Text("HEADER"),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              Get.offAllNamed("/");
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Producto'),
            onTap: () {
              Get.offAllNamed("/product");
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            onTap: () {
              Get.offAllNamed("/settings");
            },
          ),
        ],
      ),
    );
  }
}

// class MenuDrawer extends StatelessWidget {
//   const MenuDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const NavigationDrawer(
//       selectedIndex: screenIndex,
//       children: <Widget>[
//         DrawerHeader(
//           decoration: BoxDecoration(
//             color: Colors.blue,
//           ),
//           child: Text('Drawer Header'),
//         ),
//         NavigationDrawerDestination(
//           label: Text('Item 1'),
//           icon: Icon(Icons.widgets_outlined),
//           selectedIcon: Icon(Icons.widgets),
//         ),
//         NavigationDrawerDestination(
//           label: Text('Item 2'),
//           icon: Icon(Icons.format_paint_outlined),
//           selectedIcon: Icon(Icons.format_paint),
//         ),
//       ],

//       // child: ListView(
//       //   // Important: Remove any padding from the ListView.

//       //   padding: EdgeInsets.zero,
//       //   children: [
//       //     const DrawerHeader(
//       //       decoration: BoxDecoration(
//       //         color: Colors.blue,
//       //       ),
//       //       child: Text('Drawer Header'),
//       //     ),
//       //     ListTile(
//       //       title: const Text('Item 1'),
//       //       onTap: () {
//       //         // Update the state of the app.
//       //         // ...
//       //         Navigator.pop(context);
//       //       },
//       //     ),

//       //   ],
//       // ),
//     );
//   }
// }
