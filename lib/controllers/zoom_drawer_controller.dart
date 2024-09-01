import 'package:flutter/material.dart';

import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class MyZoomDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();

  // @override
  // void onReady() async {
  //   super.onReady();
  // }

  void toogleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }

  void website() {
    debugPrint("website pressed");
    _launch("https://pub.dev/packages?q=launch+url");
  }

  void toSearchProduct() {
    Get.toNamed("/search-product");
    _launch("https://pub.dev/packages?q=launch+url");
  }

  void toHomeScreen() {
    Get.toNamed("/");
  }

  void signIn() {}

  void signOut() {}

  void email() {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'joseobandobalvin@gmail.com',
      queryParameters: {'subject': 'Default Subject', 'body': 'Default body'},
    );
    _launch(emailLaunchUri.toString());
  }

  Future<void> _launch(String url) async {}
}
