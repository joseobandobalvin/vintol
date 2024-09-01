import 'package:vintol/configs/themes/app_colors.dart';

import 'package:vintol/generated/l10n.dart';
import 'package:flutter/material.dart';

class SearchProductScreen extends StatelessWidget {
  const SearchProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 20),
        backgroundColor: kDarkBlue,
        title: Text(
          S.current.txtNew,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            width: double.maxFinite,
            // decoration: BoxDecoration(
            //   gradient: mainGradient(),
            // ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Pagina de busqueda"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
