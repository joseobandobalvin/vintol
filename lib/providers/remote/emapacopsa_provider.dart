import 'package:get/get.dart';
import 'package:vintol/generated/l10n.dart';
import 'package:vintol/helpers/http.dart';
import 'package:vintol/helpers/http_method.dart';

class EmapacopsaProvider {
  final Http _http = Http();

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
  //     //print(response.data);
  //     return response.data;
  //   } catch (e) {
  //     //print("error sin manejadores en flutter getallcandidates ----");
  //     return null;
  //   }
  // }

  // Future getAllCandidatesByName(query) async {
  //   if (query.toString().trim().isNotEmpty) {
  //     try {
  //       final response = await _http.request(
  //         '/candidato',
  //         method: HttpMethod.post,
  //         body: {
  //           'pageSize': 20,
  //           'skip': 1,
  //           'filter': {'idProcesoElectoral': 113, 'numeroDocumento': query}
  //         },
  //       );
  //       //print(response.data);
  //       return response.data;
  //     } catch (e) {
  //       print("error sin manejadores en flutter getAllCandidatesByName----");
  //       return null;
  //     }
  //   }
  //   return null;
  // }

  Future searchBySupply(supply) async {
    try {
      final response = await _http.request(
        '${S.current.baseEmapacopsaUrl}/login.php',
        method: HttpMethod.post,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'user_name': supply.toString().trim(),
          'login': '',
        },
      );

      return response;
    } catch (e) {
      return -1;
    }
  }

  Future searchBySupplyPostLogin(supply) async {
    print("searchBySupplyPostLogin");
    print(supply);
    try {
      final response = await _http.request(
        '${S.current.baseEmapacopsaUrl}/ajax/buscar_facturas.php',
        method: HttpMethod.get,
        queryParameters: {
          'action': 'ajax',
          'page': '1',
          'q': supply.toString(),
        },
      );
      //print(response.data);
      return response;
    } catch (e) {
      return -1;
    }
  }

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
