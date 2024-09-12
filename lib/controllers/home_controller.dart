import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vintol/helpers/platform_exceptions.dart';
import 'package:vintol/models/cv.dart';
import 'package:vintol/providers/remote/user_provider.dart';
import 'package:vintol/widgets/global_widgets/loader.dart';

class HomeController extends GetxController {
  final UserProvider _userProvider = UserProvider();

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<Cv>> getCandidates(BuildContext context) async {
    List<Cv> usuarios = [];

    try {
      final res = await _userProvider.getAllCandidates();
      //.timeout(const Duration(milliseconds: 2));

      if (res != null && res["count"] > 0.0) {
        final lista = List.from(res['data']);
        for (var e in lista) {
          final Cv user = Cv.fromJson(e);
          usuarios.add(user);
        }
        return usuarios;
      }
    } on PlatformException catch (e) {
      print("error de PlatformException flutter getCandidates-----");
      throw OPlatformException(e.code).message;
    } catch (e) {
      print("error sin manejadores en flutter getCandidates ----");
      print(e);

      Loader.snackBarFlutter(context, message: e.toString());
      //Loader.errorSnackBar(title: "Errorrrrr", message: e.toString());
    }

    return usuarios;
  }

  Future<List<Cv>> getCandidatesByName(query) async {
    List<Cv> usuarios = [];

    try {
      final res = await _userProvider.getAllCandidatesByName(query);
      if (res != null && res["count"] > 0.0) {
        final lista = List.from(res['data']);
        for (var e in lista) {
          final Cv user = Cv.fromJson(e);
          usuarios.add(user);
        }
        return usuarios;
      }
    } on PlatformException catch (e) {
      print("error de PlatformException flutter getCandidatesByName-----");
      throw OPlatformException(e.code).message;
    } catch (e) {
      print("error sin manejadores en flutter getCandidatesByName ----");
      print(e.runtimeType);
      Loader.errorSnackBar(title: "Error", message: e.toString());
    }

    return usuarios;
  }
}
