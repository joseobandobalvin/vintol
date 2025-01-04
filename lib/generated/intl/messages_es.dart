// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'es';

  static String m0(name) => "Welcome ${name}";

  static String m1(gender) =>
      "${Intl.gender(gender, female: 'Hi woman!', male: 'Hi man!', other: 'Hi there!')}";

  static String m2(role) => "${Intl.select(role, {
            'admin': 'Hi admin!',
            'manager': 'Hi manager!',
            'other': 'Hi visitor!',
          })}";

  static String m3(howMany) =>
      "${Intl.plural(howMany, one: '1 message', other: '${howMany} messages')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "baseEmapacopsaUrl": MessageLookupByLibrary.simpleMessage(
            "http://190.116.57.170:8087/facturacion"),
        "pageHomeWelcome": m0,
        "pageHomeWelcomeGender": m1,
        "pageHomeWelcomeRole": m2,
        "pageNotificationsCount": m3,
        "txBle": MessageLookupByLibrary.simpleMessage("Bluetooth"),
        "txCancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "txClose": MessageLookupByLibrary.simpleMessage("Cerrar"),
        "txDelete": MessageLookupByLibrary.simpleMessage("Eliminar"),
        "txDelete2": MessageLookupByLibrary.simpleMessage("Borrar"),
        "txDetail": MessageLookupByLibrary.simpleMessage("Detalle"),
        "txEdit": MessageLookupByLibrary.simpleMessage("Editar"),
        "txElec": MessageLookupByLibrary.simpleMessage("Electricidad"),
        "txEmapa": MessageLookupByLibrary.simpleMessage("EMAPACOP SA"),
        "txError": MessageLookupByLibrary.simpleMessage("Error"),
        "txErrorDescription": MessageLookupByLibrary.simpleMessage(
            "No se pudo guardar el registro"),
        "txHome": MessageLookupByLibrary.simpleMessage("Infracciones"),
        "txNew": MessageLookupByLibrary.simpleMessage("Nuevo"),
        "txOk": MessageLookupByLibrary.simpleMessage("OK"),
        "txSave": MessageLookupByLibrary.simpleMessage("Guardar"),
        "txSearch": MessageLookupByLibrary.simpleMessage("Buscar"),
        "txtAskDeleteAction": MessageLookupByLibrary.simpleMessage(
            "Seguro desea eliminar registro ?"),
        "txtDatabaseBackUp":
            MessageLookupByLibrary.simpleMessage("Copia de seguridad"),
        "txtDatabaseDelete":
            MessageLookupByLibrary.simpleMessage("Eliminar base de datos"),
        "txtDatabaseRestore": MessageLookupByLibrary.simpleMessage(
            "Restaurar copia de seguridad"),
        "txtDefaultDescription":
            MessageLookupByLibrary.simpleMessage("Descripcion por defecto"),
        "txtDefaultTitle":
            MessageLookupByLibrary.simpleMessage("Titulo por defecto"),
        "txtFilterBy": MessageLookupByLibrary.simpleMessage("Filtrar por :"),
        "txtSettings": MessageLookupByLibrary.simpleMessage("Configuración"),
        "txtSignIn": MessageLookupByLibrary.simpleMessage("Ingresar"),
        "urlPhotoResume": MessageLookupByLibrary.simpleMessage(
            "https://declara.jne.gob.pe/Assets/Fotos-HojaVida"),
        "urlPoliticalGroupSymbol": MessageLookupByLibrary.simpleMessage(
            "https://sroppublico.jne.gob.pe/Consulta/Simbolo/GetSimbolo")
      };
}
