import 'package:vintol/controllers/ble_controller.dart';
import 'package:vintol/controllers/electricity_controller.dart';
import 'package:vintol/controllers/emapacopsa_controller.dart';
import 'package:vintol/controllers/home_controller.dart';
import 'package:vintol/controllers/infraction_controller.dart';
import 'package:vintol/controllers/settings_controller.dart';
import 'package:vintol/screens/ble/ble_detail.dart';
import 'package:vintol/screens/ble/ble_scan.dart';
import 'package:vintol/screens/ble/ble_screen.dart';
import 'package:vintol/screens/electricity/electricity_screen.dart';
import 'package:vintol/screens/emapa/emapa_screen.dart';
import 'package:vintol/screens/home/home_detail_screen.dart';
import 'package:vintol/screens/home/home_screen.dart';
import 'package:vintol/screens/settings/settings_screen.dart';

import 'package:get/get.dart';

class AppRoutes {
  static const String homeScreen = "/";
  static const String homeDetail = "/home-detail";

  static const String bleScreen = "/ble-screen";
  static const String bleScan = "/ble-scan";
  static const String bleDetail = "/ble-detail";

  static const String electricityScreen = "/electricity-screen";

  static const String emapacopsaScreen = "/emapacopsa-screen";

  static const String settings = "/settings";

  static List<GetPage> routes() => [
        GetPage(
          name: homeScreen,
          page: () => const HomeScreen(),
          binding: BindingsBuilder(() {
            //Get.put(AuthController());
            Get.put(HomeController());
            //Get.put(MyZoomDrawerController());
          }),
        ),
        GetPage(
          name: homeDetail,
          page: () => HomeDetailScreen(),
          binding: BindingsBuilder(() {
            Get.put(InfractionController());
          }),
        ),
        //Ble screen *************************************************
        GetPage(
          name: bleScreen,
          page: () => const BleScreen(),
          binding: BindingsBuilder(() {
            Get.put(BleController());
          }),
        ),
        GetPage(
          name: bleScan,
          page: () => const BleScan(),
          binding: BindingsBuilder(() {
            //Get.put(BleController());
          }),
        ),
        GetPage(
          name: bleDetail,
          page: () => const BleDetail(),
          binding: BindingsBuilder(() {
            Get.put(BleController());
          }),
        ),
        //Electricity screen *****************************************
        GetPage(
          name: electricityScreen,
          page: () => const ElectricityScreen(),
          binding: BindingsBuilder(() {
            Get.put(ElectricityController());
          }),
        ),
        //Emapacopsa screen *****************************************
        GetPage(
          name: emapacopsaScreen,
          page: () => const EmapacopsaScreen(),
          binding: BindingsBuilder(() {
            Get.put(EmapacopsaController());
          }),
        ),

        // GetPage(
        //   name: organizationFilterPage,
        //   page: () => const OrganizationFilterScreen(),
        //   binding: BindingsBuilder(() {
        //     Get.put(OrganizationController());
        //   }),
        // ),

        GetPage(
          name: settings,
          page: () => const SettingsScreen(),
          binding: BindingsBuilder(() {
            Get.put(SettingsController());
          }),
        ),
      ];
}
