import 'package:vintol/configs/themes/app_colors.dart';
import 'package:vintol/controllers/product_controller.dart';
import 'package:vintol/generated/l10n.dart';
import 'package:vintol/models/infraction.dart';
import 'package:vintol/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:vintol/models/product.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class CardStack extends StatelessWidget {
  final Infraction infraction;
  const CardStack(this.infraction, {super.key});

  //final controller = Get.put(ProductController());
  //Get.lazyPut(()=>ProductController());
  //final controller = Get.lazyPut(() => ProductController());

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 3,
      leading: SizedBox(
        width: 50.0,
        //color: Colors.green,
        child: Text(
          infraction.falta,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: kDarkBlue,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        infraction.infraccion,
        textAlign: TextAlign.justify,
        style: const TextStyle(
          color: kDarkBlue,
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: SizedBox(
        width: double.maxFinite,
        //color: Colors.green,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "S/. ${infraction.monto}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      trailing: SizedBox(
        width: 50,
        child: Text(
          textAlign: TextAlign.end,
          infraction.puntos,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 27.0,
          ),
        ),
      ),
      onTap: () {
        viewInfraction();
      },
      onLongPress: () {
        // Dialogs.infoProduct(
        //   context,
        //   product: product,
        // );
      },
    );
  }

  void viewInfraction() {
    Get.toNamed(
      "/home-detail",
      arguments: infraction,
    );
  }
}
