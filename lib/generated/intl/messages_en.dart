// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

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
        "txCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "txClose": MessageLookupByLibrary.simpleMessage("Close"),
        "txDelete": MessageLookupByLibrary.simpleMessage("Delete"),
        "txDelete2": MessageLookupByLibrary.simpleMessage("Delete"),
        "txDetail": MessageLookupByLibrary.simpleMessage("Detail"),
        "txEdit": MessageLookupByLibrary.simpleMessage("Edit"),
        "txElec": MessageLookupByLibrary.simpleMessage("Electricity"),
        "txEmapa": MessageLookupByLibrary.simpleMessage("EMAPACOP SA"),
        "txError": MessageLookupByLibrary.simpleMessage("Error"),
        "txErrorDescription": MessageLookupByLibrary.simpleMessage(
            "The record could not be saved."),
        "txHome": MessageLookupByLibrary.simpleMessage("Infractions"),
        "txNew": MessageLookupByLibrary.simpleMessage("New"),
        "txOk": MessageLookupByLibrary.simpleMessage("OK"),
        "txSave": MessageLookupByLibrary.simpleMessage("Save"),
        "txSearch": MessageLookupByLibrary.simpleMessage("Buscar"),
        "txtAskDeleteAction": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete a record ?"),
        "txtDatabaseBackUp":
            MessageLookupByLibrary.simpleMessage("Backup Copy"),
        "txtDatabaseDelete":
            MessageLookupByLibrary.simpleMessage("Delete Database"),
        "txtDatabaseRestore":
            MessageLookupByLibrary.simpleMessage("Restore Backup"),
        "txtDefaultDescription":
            MessageLookupByLibrary.simpleMessage("Default Description"),
        "txtDefaultTitle":
            MessageLookupByLibrary.simpleMessage("Default Title"),
        "txtFilterBy": MessageLookupByLibrary.simpleMessage("Filter by :"),
        "txtSettings": MessageLookupByLibrary.simpleMessage("Settings"),
        "txtSignIn": MessageLookupByLibrary.simpleMessage("Sign in"),
        "urlPhotoResume": MessageLookupByLibrary.simpleMessage(
            "https://declara.jne.gob.pe/Assets/Fotos-HojaVida"),
        "urlPoliticalGroupSymbol": MessageLookupByLibrary.simpleMessage(
            "https://sroppublico.jne.gob.pe/Consulta/Simbolo/GetSimbolo")
      };
}
