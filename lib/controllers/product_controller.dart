import 'package:vintol/generated/l10n.dart';
import 'package:vintol/providers/database_provider.dart';
import 'package:get/get.dart';
import 'package:vintol/models/product.dart';

class ProductController extends GetxController {
  var ini = "".obs;

  int id = 0;
  String name = "", barcode = "", description = "", emptyString = "";
  double price = 0.0;
  int quantity = 0;

  bool isNewProduct = true;

  var total = 0.0.obs;

  @override
  void onInit() {
    dynamic argumentData = Get.arguments;

    if (argumentData != null) {
      switch (argumentData.runtimeType) {
        case const (List<Product>):
          List<Product> list = argumentData as List<Product>;
          sum(list);
          break;
        case const (Product):
          Product p = argumentData as Product;

          id = p.id!;
          barcode = p.barcode;
          name = p.name;
          description = p.description;
          price = p.price;
          quantity = p.quantity;
          isNewProduct = false;
          break;
        default:
          // print("DEFAULT*********************************");
          break;
      }
    }

    super.onInit();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  void onBarcodeChanged(String t) {
    barcode = t;
  }

  void onNameChanged(String t) {
    name = t;
  }

  void onPriceChanged(String t) {
    price = double.parse(t);
  }

  void onQuantityChanged(String t) {
    quantity = int.parse(t);
  }

  void onDescriptionChanged(String t) {
    description = t;
  }

  Future<int> submit(bool isNew) async {
    Product p = Product(
      name: name.isNotEmpty
          ? name.trim().toUpperCase()
          : S.current.txtDefaulProductName.toUpperCase(),
      description: description.trim().toUpperCase(),
      price: price,
      quantity: quantity,
      barcode: barcode.trim(),
      creationDate: DateTime.now(),
    );

    if (isNew && barcode.isNotEmpty && price > 0) {
      try {
        var result = await DatabaseProvider.db.addNewProduct(p);
        return result;
      } catch (e) {
        print(e);
      }
    } else if (isNew == false && barcode.isNotEmpty && price > 0) {
      try {
        var result = await DatabaseProvider.db.update(id, p);
        return result;
      } catch (e) {
        print(e);
      }
    }

    // if (barcode.isNotEmpty && price > 0) {
    //   var result = await DatabaseProvider.db.addNewProduct(p);
    //   return result;
    // }

    return -1;
  }

  Future<int> deleteProduct(int id) async {
    var result = await DatabaseProvider.db.delete(id);
    return result;
  }

  sum(List<Product> l) {
    double tot = 0;

    for (var p in l) {
      tot += p.price;
    }

    total.value = tot;
  }

  void navigateToHomePage() {
    Get.offAllNamed("/");
  }

  void navigateToProductPage() {
    Get.offAllNamed("/product");
  }
}
