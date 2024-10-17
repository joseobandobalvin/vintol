class DeviceInfo {
  String id;
  String name;

  DeviceInfo({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };

  factory DeviceInfo.fromMap(Map<String, dynamic> map) => DeviceInfo(
        id: map['id'],
        name: map['name'] ?? "",
      );
}
