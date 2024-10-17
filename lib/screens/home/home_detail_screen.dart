import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vintol/configs/themes/app_colors.dart';
import 'package:vintol/controllers/infraction_controller.dart';
import 'package:vintol/models/infraction.dart';

class HomeDetailScreen extends GetView<InfractionController> {
  HomeDetailScreen({super.key});
  final Infraction infraction = Get.arguments;

  //late Future<List<String>> _list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: const MenuDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
              },
            ),
            backgroundColor: kDarkBlue,
            title: Text(
              "Infracción ${infraction.falta}",
              style: const TextStyle(color: Colors.white),
            ),
            // snap: true,
            // floating: true,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 3,
                        child: Text(
                          "FALTA :",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(infraction.falta),
                      ),
                      Expanded(
                        flex: 8,
                        child: Text(
                          infraction.calificacion.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                //Elimina espacio extra dentro del contenido
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    "Infracción :",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    infraction.infraccion,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  const Text(
                    "Sanción :",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    infraction.sancion,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  const Text(
                    "Medida preventiva :",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  infraction.medidaPreventiva.isNotEmpty
                      ? Text(
                          infraction.medidaPreventiva,
                          textAlign: TextAlign.justify,
                        )
                      : const Text(
                          "Sin medida preventiva",
                        ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  const Text(
                    "Solidario :",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  infraction.solidario.isNotEmpty
                      ? Text(
                          infraction.solidario,
                          textAlign: TextAlign.justify,
                        )
                      : const Text(
                          "Solo el conductor es responsable",
                        ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
              ),
              margin: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              decoration: BoxDecoration(border: Border.all()),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          "MONTO",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          "Con descuento",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          "PUNTOS",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          "S/ ${infraction.monto}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          "S/ ${infraction.conDescuento}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          infraction.puntos,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 30.0,
            ),
          )
        ],
      ),
    );
  }
}
