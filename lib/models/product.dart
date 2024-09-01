class Product {
  int? id;
  String name;
  String description;
  double price;
  int quantity;
  String barcode;
  DateTime creationDate;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.barcode,
    required this.creationDate,
  });

  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "name": name,
      "description": description,
      "price": price,
      "quantity": quantity,
      "barcode": barcode,
      "creationDate": creationDate.toString()
    });
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'] ?? "",
      description: map['description'] ?? "",
      price: map['price'] ?? 0.0,
      quantity: map['quantity'] ?? 0,
      barcode: map['barcode'] ?? "",
      creationDate: DateTime.parse(map['creationDate']),
    );
  }
}
