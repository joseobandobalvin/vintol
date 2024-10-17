class BluetoothService {
  String remoteId;
  String serviceUuid;
  bool isPrimary;

  BluetoothService(
      {required this.remoteId,
      required this.serviceUuid,
      required this.isPrimary});

  Map<String, dynamic> toMap() => {
        "remoteId": remoteId,
        "serviceUuid": serviceUuid,
        "isPrimary": isPrimary,
      };

  factory BluetoothService.fromMap(Map<String, dynamic> map) =>
      BluetoothService(
        remoteId: map['remoteId'],
        serviceUuid: map['serviceUuid'] ?? "",
        isPrimary: map['isPrimary'],
      );
}
