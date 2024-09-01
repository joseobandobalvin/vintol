import 'package:flutter/material.dart';
import 'package:vintol/models/product.dart';

//import 'package:jnee/screens/detail/detail_screen.dart';

class DetailProductCardStack extends StatelessWidget {
  final Product product;
  const DetailProductCardStack(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Center(
        //padding: const EdgeInsets.all(2.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  product.name,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.price.toStringAsFixed(2),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            // Container(
            //   padding: const EdgeInsets.all(4.0),
            //   width: double.infinity,

            //   child: Text(
            //     product.name,
            //     overflow: TextOverflow.ellipsis,
            //   ),
            // ),
            // Container(
            //   width: double.infinity,
            //   padding: const EdgeInsets.only(right: 12.0),
            //   child: Text(
            //     product.price.toString(),
            //     style: const TextStyle(
            //       fontWeight: FontWeight.bold,
            //       fontSize: 17,
            //     ),
            //     textAlign: TextAlign.end,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
