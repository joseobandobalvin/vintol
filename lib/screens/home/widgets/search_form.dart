import 'package:flutter/material.dart';
import 'package:vintol/configs/themes/app_colors.dart';
import 'package:vintol/controllers/infraction_controller.dart';
import 'package:vintol/models/infraction.dart';
import 'package:vintol/screens/home/widgets/search_result_list.dart';

class CustomSearchDelegate extends SearchDelegate {
  final InfractionController _infractionController = InfractionController();

  //PreferredSizeWidget? buildBottom(BuildContext context) => ver();

  Future<List<Infraction>> _search() async {
    var inf = _infractionController.getInfractionsByFalta(query);
    return inf;
  }

  // To clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      ),
      // IconButton(
      //   onPressed: () async {
      //     var t = await HomeFilters.dropDownFilters(
      //       context,
      //       title: S.current.txtFilterBy,
      //       sorDirection: "asc",
      //       disLength: 20,
      //     );
      //   },
      //   icon: const Icon(
      //     Icons.more_vert,
      //     color: Colors.blue,
      //   ),
      // ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Infraction>>(
      future: _search(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return SearchResultList(snapshot.data![index]);
              },
              itemCount: snapshot.data!.length,
            );
          } else {
            return const Center(child: Text("Sin resultados"));
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
        //color: kLightBlue,
        );
  }

  ver() {
    return PreferredSize(
      preferredSize: Size(double.infinity, 70),
      child: Container(
        height: 40,
        width: double.infinity,
        color: kDarkBlue,
        child: Text("Hola mola"),
      ),
    );
  }

  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {},
  );
}
