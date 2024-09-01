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
        "baseUrl":
            MessageLookupByLibrary.simpleMessage("https://full.facturalo.pro"),
        "pageHomeWelcome": m0,
        "pageHomeWelcomeGender": m1,
        "pageHomeWelcomeRole": m2,
        "pageNotificationsCount": m3,
        "txClose": MessageLookupByLibrary.simpleMessage("Close"),
        "txDescription": MessageLookupByLibrary.simpleMessage("Description"),
        "txError": MessageLookupByLibrary.simpleMessage("Error"),
        "txErrorDescription": MessageLookupByLibrary.simpleMessage(
            "The record could not be saved."),
        "txName": MessageLookupByLibrary.simpleMessage("Name"),
        "txPrice": MessageLookupByLibrary.simpleMessage("Price"),
        "txQuantity": MessageLookupByLibrary.simpleMessage("Quantity"),
        "txtAcademicFormation":
            MessageLookupByLibrary.simpleMessage("Academic Formation"),
        "txtAditionalInformation":
            MessageLookupByLibrary.simpleMessage("Aditional Information"),
        "txtAskDeleteAction": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete a record ?"),
        "txtBasicInformation":
            MessageLookupByLibrary.simpleMessage("Basic Informatión"),
        "txtCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "txtDatabaseBackUp":
            MessageLookupByLibrary.simpleMessage("Backup Copy"),
        "txtDatabaseDelete":
            MessageLookupByLibrary.simpleMessage("Delete Database"),
        "txtDatabaseRestore":
            MessageLookupByLibrary.simpleMessage("Restore Backup"),
        "txtDefaulProductName":
            MessageLookupByLibrary.simpleMessage("Generic Product"),
        "txtDefaultDescription":
            MessageLookupByLibrary.simpleMessage("Default Description"),
        "txtDefaultTitle":
            MessageLookupByLibrary.simpleMessage("Default Title"),
        "txtDelete": MessageLookupByLibrary.simpleMessage("Delete"),
        "txtDelete2": MessageLookupByLibrary.simpleMessage("Delete"),
        "txtDetail": MessageLookupByLibrary.simpleMessage("Detail"),
        "txtEdit": MessageLookupByLibrary.simpleMessage("Edit"),
        "txtFilterBy": MessageLookupByLibrary.simpleMessage("Filter by :"),
        "txtHome": MessageLookupByLibrary.simpleMessage("Products scanner"),
        "txtListOfJudgments":
            MessageLookupByLibrary.simpleMessage("List Of Judgments"),
        "txtNew": MessageLookupByLibrary.simpleMessage("New"),
        "txtOk": MessageLookupByLibrary.simpleMessage("OK"),
        "txtPartialPosition":
            MessageLookupByLibrary.simpleMessage("Partial Position"),
        "txtProducts": MessageLookupByLibrary.simpleMessage("Products"),
        "txtSave": MessageLookupByLibrary.simpleMessage("Save"),
        "txtSettings": MessageLookupByLibrary.simpleMessage("Settings"),
        "txtSignIn": MessageLookupByLibrary.simpleMessage("Sign in"),
        "txtSwornDeclaration":
            MessageLookupByLibrary.simpleMessage("Sworn Declaration"),
        "txtWorkExperience":
            MessageLookupByLibrary.simpleMessage("Work Experience"),
        "urlPhotoResume": MessageLookupByLibrary.simpleMessage(
            "https://declara.jne.gob.pe/Assets/Fotos-HojaVida"),
        "urlPoliticalGroupSymbol": MessageLookupByLibrary.simpleMessage(
            "https://sroppublico.jne.gob.pe/Consulta/Simbolo/GetSimbolo")
      };
}
