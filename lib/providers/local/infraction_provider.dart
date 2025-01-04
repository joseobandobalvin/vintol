import 'package:sqflite/sqflite.dart';
import 'package:vintol/models/infraction.dart';
import 'package:vintol/providers/local/database_provider.dart';

class InfractionProvider {
  static final DatabaseProvider db = DatabaseProvider.db;

  // Future getAllCandidates() async {
  //   try {
  //     final response = await _http.request(
  //       '/candidato',
  //       method: HttpMethod.post,
  //       body: {
  //         'pageSize': 1,
  //         'skip': 1,
  //         'filter': {'idProcesoElectoral': 113, 'numeroDocumento': 'loa'}
  //       },
  //     );

  //     return response.data;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  Future getAllInfractionsByFalta(query) async {
    //var db = await openDatabase('vintol.db');
    final databas = await db.database;

    if (query.toString().trim().isNotEmpty) {
      try {
        // final res = await db.rawQuery('''
        // SELECT * from infractions WHERE falta = ? ''', [query]);
        // final res = await databas
        //     .rawQuery('SELECT * from infractions WHERE falta LIKE ?', [query]);
        final res = await databas.query('infractions',
            columns: ['*'],
            where: 'falta LIKE ?',
            whereArgs: ['%' + query + '%']);

        return res.map((te) => Infraction.fromMap(te)).toList();
      } catch (e) {
        print(
            "error sin manejadores en flutter providerGetAllInfractionsByFalta----");
        return null;
      }
    }
    return null;
  }

  // Future searchAllCandidates(buscar) async {
  //   try {
  //     final response = await _http.request(
  //       '/candidato',
  //       method: HttpMethod.post,
  //       body: {
  //         'pageSize': 10,
  //         'skip': 1,
  //         'filter': {'idProcesoElectoral': 113, 'numeroDocumento': buscar}
  //       },
  //     );
  //     //print(response.data);
  //     return response.data;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // Future getUserInformation(idHojaVida) async {
  //   try {
  //     final response = await _http.request(
  //       '/candidato/hoja-vida',
  //       method: HttpMethod.get,
  //       queryParameters: {
  //         'IdHojaVida': idHojaVida.toString(),
  //       },
  //     );
  //     return response.data;
  //   } catch (e) {
  //     return null;
  //   }
  // }
}
