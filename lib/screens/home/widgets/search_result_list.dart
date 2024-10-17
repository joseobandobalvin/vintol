import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vintol/configs/themes/app_colors.dart';
import 'package:vintol/models/infraction.dart';

class SearchResultList extends StatelessWidget {
  final Infraction infraction;
  const SearchResultList(this.infraction, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: CachedNetworkImage(
      //   width: 47,
      //   height: 47,
      //   imageUrl: "${S.current.urlPoliticalGroupSymbol}/$idOrgPol",
      //   progressIndicatorBuilder: (context, url, downloadProgress) =>
      //       LinearProgressIndicator(
      //     value: downloadProgress.progress,
      //     color: kDarkBlue,
      //   ),
      //   errorWidget: (context, url, error) => const Icon(Icons.error),
      // ),
      leading: Container(
        padding: const EdgeInsets.all(10.0),
        color: Colors.black12,
        child: Text(
          infraction.falta,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        textAlign: TextAlign.justify,
        maxLines: 2,
        infraction.infraccion,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        "S/. ${infraction.monto}",
        style: const TextStyle(
          fontSize: 10,
        ),
      ),
      onTap: () => Get.toNamed("/home-detail", arguments: infraction),
    );
  }
}
