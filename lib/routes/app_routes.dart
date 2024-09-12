import 'package:vintol/controllers/ble_controller.dart';
import 'package:vintol/controllers/home_controller.dart';
import 'package:vintol/controllers/product_controller.dart';
import 'package:vintol/controllers/settings_controller.dart';
import 'package:vintol/screens/ble/ble_screen.dart';
import 'package:vintol/screens/detail/detail_product_screen.dart';
import 'package:vintol/screens/home/home_screen.dart';
import 'package:vintol/screens/product/edit_new_product_screen.dart';
import 'package:vintol/screens/product/list_product_screen.dart';
import 'package:vintol/screens/product/search_product_screen.dart';
import 'package:vintol/screens/settings/settings_screen.dart';

import 'package:get/get.dart';

class AppRoutes {
  static const String homeScreen = "/";
  static const String loginPage = "/login";

  static const String bleScreen = "/ble-screen";

  static const String cardDetailPage = "/card-detail";
  static const String organizationFilterPage = "/organization-filter";

  static const String product = "/product";
  static const String searchProduct = "/search-product";
  static const String newProduct = "/new-product";
  static const String detailProduct = "/detail-product";

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
          name: bleScreen,
          page: () => const BleScreen(),
          binding: BindingsBuilder(() {
            Get.put(BleController());
          }),
        ),
        GetPage(
          name: product,
          page: () => const ListProductScreen(),
          binding: BindingsBuilder(() {
            //Get.put(ProductController());
          }),
        ),
        GetPage(
          name: newProduct,
          page: () => EditNewProductScreen(),
          binding: BindingsBuilder(() {
            Get.put(ProductController());
          }),
        ),
        GetPage(
          name: detailProduct,
          page: () => DetailProductScreen(),
          binding: BindingsBuilder(() {
            Get.put(ProductController());
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
          name: searchProduct,
          page: () => const SearchProductScreen(),
          binding: BindingsBuilder(() {
            Get.put(ProductController());
          }),
        ),

        GetPage(
          name: settings,
          page: () => const SettingsScreen(),
          binding: BindingsBuilder(() {
            Get.put(SettingsController());
          }),
        ),
      ];
}
