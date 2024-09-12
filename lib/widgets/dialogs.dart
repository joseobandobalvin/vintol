import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:vintol/configs/themes/app_colors.dart';
import 'package:vintol/generated/l10n.dart';
import 'package:vintol/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

abstract class Dialogs {
  static Future<void> info(
    BuildContext context,
    ScanResult data, {
    String? btnText,
    bool dismissible = true,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (_) => AlertDialog(
        // margen de alert dialog
        insetPadding: const EdgeInsets.symmetric(horizontal: 18),
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(2),
            bottom: Radius.circular(4),
          ),
        ),
        title: Center(
          child: data.advertisementData.advName.isNotEmpty
              ? Text(
                  data.advertisementData.advName,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              : const Text(
                  "Dispositivo desconocido",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
        ),
        content: Column(
          //Elimina espacio extra dentro del contenido
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Text(
                    "MAC :",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Text(
                    data.device.remoteId.toString(),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "TxPowerLevel :",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    data.advertisementData.txPowerLevel.toString(),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Conectable :",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  // child: Text(
                  //   data.advertisementData.connectable.toString(),
                  //   textAlign: TextAlign.end,
                  // ),
                  child: data.advertisementData.connectable
                      ? Container(
                          alignment: Alignment.centerRight,
                          child: const Icon(
                            size: 20.0,
                            Icons.check_circle_outline,
                            color: Colors.green,
                          ),
                        )
                      : Container(
                          alignment: Alignment.centerRight,
                          child: const Icon(
                            size: 20.0,
                            Icons.cancel_outlined,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            const Text(
              "Datos del fabricante :",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              data.advertisementData.manufacturerData.toString(),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: btnText != null ? Text(btnText) : Text(S.current.txClose),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  static Future<void> infoProduct(BuildContext context,
      {String? title,
      Product? product,
      String? btnText,
      bool dismissible = true}) {
    return showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (_) => AlertDialog(
        scrollable: true,
        title: title != null
            ? Text(
                title,
                textAlign: TextAlign.justify,
              )
            : null,
        content: product != null
            ? Column(
                children: [
                  Text(
                    product.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: kDarkBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                  Container(height: 8.0),
                  const Divider(height: 1.0),
                  Container(height: 8.0),
                  Row(
                    children: [
                      const Text(
                        "Cantidad : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(product.quantity.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Precio de venta : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("S/ ${product.price}"),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "QR : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(product.barcode),
                    ],
                  ),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      text: "Observación : ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: product.description,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : null,
        actions: [
          TextButton(
            child: btnText != null ? Text(btnText) : Text(S.current.txClose),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  static Future<bool> confirm(
    BuildContext context, {
    String? title,
    String? description,
  }) async {
    final result = await showCupertinoModalPopup<bool>(
      context: context,
      builder: (_) => PopScope(
        child: CupertinoActionSheet(
          title: title != null ? Text(title) : Text(S.current.txtDefaultTitle),
          message: description != null
              ? Text(description)
              : Text(S.current.txtDefaultDescription),
          actions: [
            CupertinoActionSheetAction(
              child: Text(S.current.txtOk),
              onPressed: () {
                Navigator.pop(_, true);
              },
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(_, false);
              },
              isDestructiveAction: true,
              child: Text(S.current.txtCancel),
            )
          ],
        ),
      ),
    );
    return result ?? false;
  }

  static Future<bool> confirmAndroid(
    BuildContext context, {
    String? title,
    String? description,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: title != null ? Text(title) : Text(S.current.txtDefaultTitle),
        content: description != null
            ? Text(
                description,
                textAlign: TextAlign.justify,
              )
            : Text(
                S.current.txtDefaultDescription,
                textAlign: TextAlign.justify,
              ),
        actions: [
          TextButton(
            child: Text(S.current.txtCancel),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: Text(
              S.current.txtDelete,
              style: const TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
    );
    return result ?? false;
  }

  static Future<bool> confirmModalBottomSheet(
    BuildContext context, {
    String? title,
    String? description,
  }) async {
    final result = await showModalBottomSheet<bool>(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      context: context,
      builder: (_) => PopScope(
        child: Wrap(
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  title != null
                      ? Text(
                          title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      : Text(S.current.txtDefaultTitle),
                  description != null
                      ? Text(
                          description,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      : Text(S.current.txtDefaultDescription),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
            const Divider(
              height: 3,
              color: Colors.black45,
            ),
            ListTile(
              leading: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              title: Text(
                S.current.txtDelete,
                style: const TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.pop(_, true);
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: Text(S.current.txtCancel),
              onTap: () {
                Navigator.pop(_, false);
              },
            ),
          ],
        ),
      ),
    );

    return result ?? false;
  }
}

abstract class ProgressDialog {
  static Future<void> show(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (_) => PopScope(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          color: Colors.white30,
          child: const CupertinoActivityIndicator(
            radius: 15,
          ),
        ),
      ),
    );
  }
}

class SnackBars {
  static void show(
    BuildContext context, {
    required Object error,
    bool? hasAction = false,
  }) {
    final snackBar = SnackBar(
      action: hasAction == true
          ? SnackBarAction(
              label: 'Deshacer',
              onPressed: () {
                // Some code to undo the change.
              },
            )
          : null,
      behavior: SnackBarBehavior.floating,
      content: Text(
        error.toString(),
        textAlign: TextAlign.justify,
      ),
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(
        seconds: 4,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void info(
    BuildContext context, {
    String? info,
    bool? hasAction = false,
  }) {
    final snackBar = SnackBar(
      action: hasAction == true
          ? SnackBarAction(
              label: 'Deshacer',
              onPressed: () {
                // Some code to undo the change.
              },
            )
          : null,
      behavior: SnackBarBehavior.floating,
      content: Text(
        info!,
        textAlign: TextAlign.justify,
      ),
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(
        seconds: 4,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

// abstract class ProgressDialog {
//   static Future<void> show(BuildContext context) {
//     return showCupertinoModalPopup(
//       context: context,
//       builder: (_) => WillPopScope(
//         onWillPop: () async => false,
//         child: Container(
//           width: double.infinity,
//           height: double.infinity,
//           alignment: Alignment.center,
//           color: Colors.white30,
//           child: const CupertinoActivityIndicator(
//             radius: 15,
//           ),
//         ),
//       ),
//     );
//   }
// }
