class Ble {
  int? id;
  String name;
  String description;

  Ble({
    this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "name": name,
      "description": description,
    });
  }

  factory Ble.fromMap(Map<String, dynamic> map) {
    return Ble(
      id: map['id'],
      name: map['name'] ?? "",
      description: map['description'] ?? "",
    );
  }
}
