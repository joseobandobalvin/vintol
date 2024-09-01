import 'package:vintol/configs/themes/app_colors.dart';
import 'package:vintol/controllers/product_controller.dart';
import 'package:vintol/generated/l10n.dart';
import 'package:vintol/models/product.dart';
import 'package:vintol/screens/detail/widgets/detail_product_card_stack.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class DetailProductScreen extends StatefulWidget {
//   const DetailProductScreen({super.key});

//   @override
//   State<DetailProductScreen> createState() => _DetailProductScreenState();
// }

// class _DetailProductScreenState extends State<DetailProductScreen> {
//   List<Product> products = [];
//   late int childCount;

//   @override
//   void initState() {
//     super.initState();
//     print(
//         "iniciando estado en detailProductScreen **********************************");
//     products = Get.arguments;
//     childCount = products.length;
//     print(
//         "saliendo estado en detailProductScreen **********************************");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             backgroundColor: kDarkBlue,
//             title: Text(
//               S.current.txtDetail,
//               style: const TextStyle(color: Colors.white),
//             ),
//             elevation: 10.0,
//           ),
//           SliverToBoxAdapter(
//             child: Container(
//               padding: EdgeInsets.all(10.0),
//               child: const Text(
//                 "Total: 14.7",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 17,
//                 ),
//                 textAlign: TextAlign.end,
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int index) {
//                 return DetailProductCardStack(products[index]);
//               },
//               childCount: childCount,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class DetailProductScreen extends GetView<ProductController> {
  DetailProductScreen({super.key});
  final List<Product> products = Get.arguments;

  @override
  Widget build(BuildContext context) {
    int childCount = products.length;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: const IconThemeData(color: Colors.white, size: 20),
            backgroundColor: kDarkBlue,
            title: Text(
              S.current.txtDetail,
              style: const TextStyle(color: Colors.white),
            ),
            elevation: 10.0,
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(14.0),
              child: Obx(
                () => Text(
                  "Total: S/. ${controller.total.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return DetailProductCardStack(products[index]);
              },
              childCount: childCount,
            ),
          ),
        ],
      ),
    );
  }
}
