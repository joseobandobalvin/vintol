import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:vintol/providers/remote/emapacopsa_provider.dart';

class EmapacopsaController extends GetxController {
  final EmapacopsaProvider _emapacopsaProvider = EmapacopsaProvider();
  String supply = "";
  RxString res = "---".obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onSupplyChanged(String t) {
    supply = t;
  }

  Future submit() async {
    var result = await _emapacopsaProvider.searchBySupply(supply);
    res.value = result.data.toString();

    if (result.data.toString().length == 3) {
      var r = await _emapacopsaProvider.searchBySupplyPostLogin(supply);
      print("---------Bcontroller emapacopsa");
      print(r.data.toString().length);
      print("---------Econtroller emapacopsa");
      res.value = r.data.toString();
      return r;
    }

    return result;
  }
}
