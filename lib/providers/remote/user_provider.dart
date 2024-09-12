import 'package:vintol/helpers/http.dart';
import 'package:vintol/helpers/http_method.dart';

class UserProvider {
  final Http _http = Http();

  Future getAllCandidates() async {
    try {
      final response = await _http.request(
        '/candidato',
        method: HttpMethod.post,
        body: {
          'pageSize': 1,
          'skip': 1,
          'filter': {'idProcesoElectoral': 113, 'numeroDocumento': 'loa'}
        },
      );
      //print(response.data);
      return response.data;
    } catch (e) {
      //print("error sin manejadores en flutter getallcandidates ----");
      return null;
    }
  }

  Future getAllCandidatesByName(query) async {
    if (query.toString().trim().isNotEmpty) {
      try {
        final response = await _http.request(
          '/candidato',
          method: HttpMethod.post,
          body: {
            'pageSize': 20,
            'skip': 1,
            'filter': {'idProcesoElectoral': 113, 'numeroDocumento': query}
          },
        );
        //print(response.data);
        return response.data;
      } catch (e) {
        print("error sin manejadores en flutter getAllCandidatesByName----");
        return null;
      }
    }
    return null;
  }

  Future searchAllCandidates(buscar) async {
    try {
      final response = await _http.request(
        '/candidato',
        method: HttpMethod.post,
        body: {
          'pageSize': 10,
          'skip': 1,
          'filter': {'idProcesoElectoral': 113, 'numeroDocumento': buscar}
        },
      );
      //print(response.data);
      return response.data;
    } catch (e) {
      return null;
    }
  }

  Future getUserInformation(idHojaVida) async {
    try {
      final response = await _http.request(
        '/candidato/hoja-vida',
        method: HttpMethod.get,
        queryParameters: {
          'IdHojaVida': idHojaVida.toString(),
        },
      );
      return response.data;
    } catch (e) {
      return null;
    }
  }
}
