//import 'package:jnee/controllers/auth_controller.dart';
import 'package:vintol/controllers/product_controller.dart';
import 'package:vintol/generated/l10n.dart';
import 'package:vintol/widgets/dialogs.dart';
import 'package:vintol/widgets/global_widgets/input_text.dart';
import 'package:vintol/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
//import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class NewProductForm extends GetView<ProductController> {
  NewProductForm({super.key});

  var barcodeController = TextEditingController();
  var barcodeNewController = TextEditingController();

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final descriptionController = TextEditingController();
  final emptyStringPriceController = TextEditingController();
  final emptyStringQuantityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _submit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      ProgressDialog.show(context);

      final int submitOk = await controller.submit(controller.isNewProduct);

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      if (submitOk < 1) {
        ////
      } else {
        // go to home
        controller.navigateToHomePage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = controller.name;
    priceController.text = controller.price.toString();
    emptyStringPriceController.text = controller.emptyString;
    quantityController.text = controller.quantity.toString();
    emptyStringQuantityController.text = controller.emptyString;
    descriptionController.text = controller.description;

    barcodeController.text = controller.barcode;
    barcodeNewController.text = controller.emptyString;

    return Form(
      key: _formKey,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 340),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    //key: UniqueKey(),

                    // initialValue:
                    //     controller.isNewProduct ? "" : controller.barcode,
                    controller: controller.isNewProduct
                        ? barcodeNewController
                        : barcodeController, // <-- SEE HERE
                    decoration: const InputDecoration(
                      isDense: true,
                      prefixIcon: Icon(Icons.qr_code_scanner),
                    ),
                    textInputAction: TextInputAction.next,
                    onChanged: controller.onBarcodeChanged,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          WidgetStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: _scanBarcodeNormal,
                    child: const Icon(Icons.search),
                  ),
                )
              ],
            ),
            //Obx(() => Text("${controller.ini}")),

            InputText(
              isDense: true,
              prefixIcon: const Icon(Icons.production_quantity_limits),
              labelText: S.current.txName,
              textInputAction: TextInputAction.next,
              controller: nameController,
              onChanged: (value) {
                controller.onNameChanged(value);
              },
              validator: (text) {
                if (text!.isNotEmpty) return null;
                return "Nombre inválido";
              },
            ),
            InputText(
              isDense: true,
              prefixIcon: const Icon(Icons.price_check),
              labelText: S.current.txPrice,
              textInputAction: TextInputAction.next,
              controller: controller.isNewProduct
                  ? emptyStringPriceController
                  : priceController,
              onChanged: controller.onPriceChanged,
              keyboardType: TextInputType.number,
              validator: (text) {
                if (text!.isNotEmpty) return null;
                return "Precio invalido";
              },
            ),
            InputText(
              isDense: true,
              prefixIcon: const Icon(Icons.pin),
              labelText: S.current.txQuantity,
              textInputAction: TextInputAction.next,
              controller: controller.isNewProduct
                  ? emptyStringQuantityController
                  : quantityController,
              onChanged: controller.onQuantityChanged,
              keyboardType: TextInputType.number,
              validator: (text) {
                if (text!.isNotEmpty) return null;
                return "Cantidad invalida";
              },
            ),
            InputText(
              isDense: true,
              prefixIcon: const Icon(Icons.view_list),
              labelText: S.current.txDescription,
              textInputAction: TextInputAction.next,
              controller: descriptionController,
              onChanged: controller.onDescriptionChanged,
              validator: (text) {
                if (text!.isEmpty) return "Descripcion invalido";
                return null;
              },
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            RoundedButton(
              label: S.current.txtSave,
              onPressed: () => _submit(context),
              padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 40),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _scanBarcodeNormal() async {
    String res;

    try {
      res = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', S.current.txtCancel, true, ScanMode.BARCODE);
      // controller.ini.value = res;
      // controller.barcode = res;
      if (controller.isNewProduct) {
        barcodeNewController.text = res;
        controller.barcode = res;
      } else {
        barcodeController.text = res;
        controller.barcode = res;
      }
    } on PlatformException {
      res = 'Fallo al obtener version de plataforma';
    }
  }
}
