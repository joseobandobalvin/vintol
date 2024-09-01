import 'package:vintol/configs/themes/app_colors.dart';
import 'package:vintol/controllers/product_controller.dart';

import 'package:vintol/generated/l10n.dart';
import 'package:vintol/screens/product/widgets/new_product_form.dart';
import 'package:vintol/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditNewProductScreen extends StatelessWidget {
  EditNewProductScreen({super.key});
  final controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 20),
        backgroundColor: kDarkBlue,
        title: Text(
          //S.current.txtNew,
          controller.isNewProduct ? S.current.txtNew : S.current.txtEdit,
          style: const TextStyle(color: Colors.white),
        ),
        actions: controller.isNewProduct == false
            ? canDelete(context, controller.id)
            : [],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            width: double.maxFinite,
            // decoration: BoxDecoration(
            //   gradient: mainGradient(),
            // ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NewProductForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> canDelete(BuildContext context, int id) {
    return [
      IconButton(
        onPressed: () async {
          Future<bool> res = Dialogs.confirmModalBottomSheet(
            context,
            title: S.current.txtDelete,
            description: S.current.txtAskDeleteAction,
          );
          if (await res) {
            int d = await controller.deleteProduct(id);
            if (d == 1) {
              controller.navigateToProductPage();
            }
          }
        },
        icon: const Icon(Icons.delete, color: Colors.white),
      ),
    ];
  }
}
