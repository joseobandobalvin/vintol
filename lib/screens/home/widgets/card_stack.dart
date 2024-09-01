import 'package:vintol/configs/themes/app_colors.dart';
import 'package:vintol/controllers/product_controller.dart';
import 'package:vintol/generated/l10n.dart';
import 'package:vintol/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:vintol/models/product.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class CardStack extends StatelessWidget {
  final Product product;
  const CardStack(this.product, {super.key});

  //final controller = Get.put(ProductController());
  //Get.lazyPut(()=>ProductController());
  //final controller = Get.lazyPut(() => ProductController());

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(product.id),

      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const DrawerMotion(),

        openThreshold: 0.1,
        closeThreshold: 0.4,
        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(
          dismissalDuration: const Duration(milliseconds: 100),
          dismissThreshold: 0.2,
          resizeDuration: const Duration(milliseconds: 100),
          onDismissed: () async {
            Get.lazyPut(() => ProductController());
            ProductController r = Get.find();

            int d = await r.deleteProduct(product.id!);

            // int d = await controller.deleteProduct(product.id!);
            // Get.delete<ProductController>();
            if (d == 1) {
              //controller.navigateToProductPage();
              //print("se elimino registro");
              var t = await Get.delete<ProductController>();
            }
          },
          closeOnCancel: true,
          confirmDismiss: () async {
            return await Dialogs.confirmAndroid(
              context,
              title: S.current.txtDelete,
              description: S.current.txtAskDeleteAction,
            );
          },
        ),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: S.current.txtDelete,
          ),
          // SlidableAction(
          //   onPressed: doNothing,
          //   backgroundColor: Color(0xFF21B7CA),
          //   foregroundColor: Colors.white,
          //   icon: Icons.share,
          //   label: 'Share',
          // ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            //flex: 2,
            onPressed: editProduct,
            backgroundColor: const Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: S.current.txtEdit,
          ),
          // SlidableAction(
          //   onPressed: doNothing,
          //   backgroundColor: Color(0xFF0392CF),
          //   foregroundColor: Colors.white,
          //   icon: Icons.save,
          //   label: 'Save',
          // ),
        ],
      ),
      child: ListTile(
        minLeadingWidth: 3,
        leading: Container(
          width: 4.0,
          color: Colors.green,
        ),
        title: Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          product.name,
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
                child: RichText(
                  text: TextSpan(
                    text: product.quantity.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: const <TextSpan>[
                      TextSpan(
                        text: ' und',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Expanded(
                flex: 1,
                child: Text(
                  "la mejor descripcion de la app que esta pueda tener",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        trailing: Container(
          width: 50,
          //color: Colors.red,
          child: Text(
            textAlign: TextAlign.end,
            product.price.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 17.0,
            ),
          ),
        ),
        onTap: () {
          print(product.name);
        },
        onLongPress: () {
          Dialogs.infoProduct(
            context,
            product: product,
          );
        },
      ),
    );
  }

  void doNothing(BuildContext c) {}

  void editProduct(BuildContext c) {
    Get.toNamed(
      "/new-product",
      arguments: product,
    );
  }
}

// class CardStack extends StatefulWidget {
//   final Product product;
//   const CardStack(this.product, {super.key});
  
//   @override
//   State<CardStack> createState() => _CardStackState();
// }

// class _CardStackState extends State<CardStack> {
//   @override
//   Widget build(BuildContext context) {
//     return Slidable(
//       key: ValueKey(widget.product.id),

//       startActionPane: ActionPane(
//         // A motion is a widget used to control how the pane animates.
//         motion: const DrawerMotion(),

//         openThreshold: 0.1,
//         closeThreshold: 0.4,
//         // A pane can dismiss the Slidable.
//         dismissible: DismissiblePane(
//           dismissalDuration: const Duration(milliseconds: 100),
//           dismissThreshold: 0.4,
//           //resizeDuration: const Duration(milliseconds: 100),
//           onDismissed: () {
//             print("onDismiss");
//           },
//           closeOnCancel: true,
//           confirmDismiss: () async {
//             return await Dialogs.confirmAndroid(
//               context,
//               title: S.current.txtDelete,
//               description: S.current.txtAskDeleteAction,
//             );
//           },
//         ),

//         // All actions are defined in the children parameter.
//         children: [
//           // A SlidableAction can have an icon and/or a label.
//           SlidableAction(
//             onPressed: doNothing,
//             backgroundColor: const Color(0xFFFE4A49),
//             foregroundColor: Colors.white,
//             icon: Icons.delete,
//             label: 'Borrar',
//           ),
          
//         ],
//       ),

//       // The end action pane is the one at the right or the bottom side.
//       endActionPane: ActionPane(
//         motion: const ScrollMotion(),
//         children: [
//           SlidableAction(
//             // An action can be bigger than the others.
//             //flex: 2,
//             onPressed: editProduct,
//             backgroundColor: const Color(0xFF7BC043),
//             foregroundColor: Colors.white,
//             icon: Icons.edit,
//             label: 'Editar',
//           ),
          
//         ],
//       ),
//       child: ListTile(
//         minLeadingWidth: 3,
//         leading: Container(
//           width: 4.0,
//           color: Colors.green,
//         ),
//         title: Text(
//           overflow: TextOverflow.ellipsis,
//           maxLines: 2,
//           widget.product.name,
//           style: const TextStyle(
//             color: kDarkBlue,
//             fontSize: 12.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         subtitle: SizedBox(
//           width: double.maxFinite,
//           //color: Colors.green,
//           child: Row(
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: RichText(
//                   text: const TextSpan(
//                     text: "20",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                     children: <TextSpan>[
//                       TextSpan(
//                         text: ' und',
//                         style: TextStyle(
//                           fontWeight: FontWeight.normal,
//                           color: Colors.black54,
//                         ),
//                       ),
//                     ],
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               const Expanded(
//                 flex: 1,
//                 child: Text(
//                   "la mejor descripcion de la app que esta pueda tener",
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         trailing: Container(
//           width: 50,
//           //color: Colors.red,
//           child: Text(
//             textAlign: TextAlign.end,
//             widget.product.price.toString(),
//             style: const TextStyle(
//               color: Colors.black,
//               fontSize: 17.0,
//             ),
//           ),
//         ),
//         onTap: () {
//           // print(product.name);
//         },
//       ),
//     );
//   }

//   void doNothing(BuildContext c) {}

//   void editProduct(BuildContext c) {
//     Get.toNamed(
//       "/new-product",
//       arguments: widget.product,
//     );
//   }
// }
