class CharacteristicProperties {
  bool broadcast;
  bool read;
  bool writeWithoutResponse;
  bool write;
  bool notify;
  bool indicate;
  bool authenticatedSignedWrites;
  bool extendedProperties;
  bool notifyEncryptionRequired;
  bool indicateEncryptionRequired;

  CharacteristicProperties({
    required this.broadcast,
    required this.read,
    required this.writeWithoutResponse,
    required this.write,
    required this.notify,
    required this.indicate,
    required this.authenticatedSignedWrites,
    required this.extendedProperties,
    required this.notifyEncryptionRequired,
    required this.indicateEncryptionRequired,
  });

  Map<String, dynamic> toMap() => {
        "broadcast": broadcast,
        "read": read,
        "writeWithoutResponse": writeWithoutResponse,
        "write": write,
        "notify": notify,
        "indicate": indicate,
        "authenticatedSignedWrites": authenticatedSignedWrites,
        "extendedProperties": extendedProperties,
        "notifyEncryptionRequired": notifyEncryptionRequired,
        "indicateEncryptionRequired": indicateEncryptionRequired,
      };

  factory CharacteristicProperties.fromMap(Map<String, dynamic> map) =>
      CharacteristicProperties(
        broadcast: map['broadcast'],
        read: map['read'],
        writeWithoutResponse: map['writeWithoutResponse'],
        write: map['write'],
        notify: map['notify'],
        indicate: map['indicate'],
        authenticatedSignedWrites: map['authenticatedSignedWrites'],
        extendedProperties: map['extendedProperties'],
        notifyEncryptionRequired: map['notifyEncryptionRequired'],
        indicateEncryptionRequired: map['indicateEncryptionRequired'],
      );
}
