import 'package:flutter/services.dart';
import 'package:vintol/generated/l10n.dart';
import 'package:vintol/helpers/platform_exceptions.dart';
import 'package:vintol/providers/local/database_provider.dart';
import 'package:get/get.dart';
import 'package:vintol/models/infraction.dart';
import 'package:vintol/providers/local/infraction_provider.dart';
import 'package:vintol/widgets/global_widgets/loader.dart';

class InfractionController extends GetxController {
  final InfractionProvider _infractionProvider = InfractionProvider();

  // int id = 0;
  // String name = "", barcode = "", description = "", emptyString = "";
  // double price = 0.0;
  // int quantity = 0;

  @override
  void onInit() {
    dynamic argumentData = Get.arguments;

    if (argumentData != null) {
      switch (argumentData.runtimeType) {
        case const (List<Infraction>):
          List<Infraction> list = argumentData as List<Infraction>;

          break;
        case const (Infraction):
          Infraction p = argumentData as Infraction;

          break;
        default:
          // print("DEFAULT*********************************");
          break;
      }
    }

    super.onInit();
  }

  Future<List<Infraction>> getInfractionsByFalta(query) async {
    List<Infraction> infractions = [];

    try {
      final res = await _infractionProvider.getAllInfractionsByFalta(query);
      print("--------..........----------");

      if (res != null) {
        infractions = List.from(res);
        // print(res.runtimeType);
        // for (var e in lista) {
        //   final Infraction infraction = Infraction.fromMap(e);
        //   infractions.add(infraction);
        // }
        return infractions;
      }
    } on PlatformException catch (e) {
      print("error de PlatformException flutter getCandidatesByName-----");
      throw OPlatformException(e.code).message;
    } catch (e) {
      print(e);
      print("error sin manejadores en flutter getCandidatesByName ----");
      print(e.runtimeType);
      Loader.errorSnackBar(title: "Error", message: e.toString());
    }

    return infractions;
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  void navigateToHomePage() {
    Get.offAllNamed("/");
  }

  void navigateToProductPage() {
    Get.offAllNamed("/product");
  }
}
