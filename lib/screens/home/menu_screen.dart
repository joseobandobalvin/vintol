import 'package:vintol/configs/themes/app_colors.dart';
import 'package:vintol/configs/themes/ui_parameters.dart';
import 'package:vintol/controllers/zoom_drawer_controller.dart';

//import 'package:vintol/controllers/zoom_drawer_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuScreen extends GetView<MyZoomDrawerController> {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: UIParameters.mobileScreenPadding,
        width: double.maxFinite,
        decoration: BoxDecoration(gradient: mainGradient()),
        child: Theme(
          data: ThemeData(
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: onSurfaceTextColor),
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: BackButton(
                    color: Colors.white,
                    onPressed: () {
                      controller.toogleDrawer();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.3,
                  ),
                  child: Column(
                    children: [
                      // const Text(
                      //   "m",
                      //   style: TextStyle(color: Colors.white),
                      // ),
                      const Spacer(flex: 1),
                      _DrawerButton(
                        icon: Icons.web,
                        label: "Inicio",
                        onPressed: () => controller.toHomeScreen(),
                      ),
                      const Spacer(
                        flex: 4,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DrawerButton extends StatelessWidget {
  const _DrawerButton({
    required this.icon,
    required this.label,
    this.onPressed,
  });
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 14,
        ),
        label: Text(
          label,
        ),
      ),
    );
  }
}
