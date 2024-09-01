import 'dart:io';

import 'package:vintol/models/product.dart';
import 'package:vintol/screens/settings/settings_screen.dart';
import 'package:vintol/widgets/dialogs.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();
  static Database? _database;

  //creating the getter
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "store.db"),
        onCreate: (db, version) async {
      //create a first table

      await db.execute('''
          CREATE TABLE products (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            description TEXT,
            price DOUBLE,
            quantity INTEGER,
            barcode TEXT UNIQUE,
            creationDate DATE
          )         
          ''');
    }, version: 1);
  }

  //add new product
  Future<int> addNewProduct(Product p) async {
    final db = await database;

    try {
      var pp = await db.insert("products", p.toMap(),
          conflictAlgorithm: ConflictAlgorithm.rollback);
      return pp;
    } catch (e) {
      return -1;
    }
  }

  //Get all products
  Future<List<Product>> getProducts() async {
    final db = await database;

    final res = await db.rawQuery('''
      SELECT * from products limit 8
    ''');

    return res.map((te) => Product.fromMap(te)).toList();
  }

  Future<Product> getById(int id) async {
    final db = await database;

    final res = await db.rawQuery('''
      SELECT * from products WHERE id = ?''', [id]);

    return Product.fromMap(res.first);
  }

  Future<Product> getByBarcode(String barcode) async {
    final db = await database;

    final res = await db.rawQuery('''
      SELECT * from products WHERE barcode = ?''', [barcode]);

    return Product.fromMap(res.first);
  }

  Future<int> update(int id, Product p) async {
    final db = await database;
    return await db.update(
      "products",
      {
        "name": p.name,
        "description": p.description,
        "price": p.price,
        "quantity": p.quantity,
        "barcode": p.barcode
      },
      where: 'id = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.rawDelete('''
    DELETE FROM products WHERE id = ?''', [id]);
  }

  Future<Map<dynamic, dynamic>> getDBPath() async {
    String dbPath = await getDatabasesPath();
    // print('================databasePath $dbPath');
    Directory? externalStoragePath = await getExternalStorageDirectory();
    // print('================externalStoragePath $externalStoragePath');
    return {"dbpath": dbPath, "externalstoragepath": externalStoragePath};
  }

  backupDB(BuildContext context) async {
    // var status = await Permission.manageExternalStorage.status;
    // if (!status.isGranted) {
    //   print("====status=========> $status");
    //   await Permission.manageExternalStorage.request();
    // }

    var status1 = await Permission.storage.status;
    // print("======status1=======# $status1");
    if (!status1.isGranted) {
      // print("======status1=======# $status1");
      await Permission.storage.request();
    }
    try {
      File ourDBFile = File(join(await getDatabasesPath(), "store.db"));

      Directory? folderPathForDBFile =
          Directory("/storage/emulated/0/StoreDatabase/");
      await folderPathForDBFile.create();
      await ourDBFile.copy("/storage/emulated/0/StoreDatabase/store.db");
    } catch (e) {
      // ignore: use_build_context_synchronously
      SnackBars.show(context, error: e.toString());
    }
  }

  restoreDB() async {
    // var status = await Permission.manageExternalStorage.status;
    // if (!status.isGranted) await Permission.manageExternalStorage.request();

    var status1 = await Permission.storage.status;
    if (!status1.isGranted) await Permission.storage.request();

    try {
      File savedDBFile = File("/storage/emulated/0/StoreDatabase/store.db");
      await savedDBFile.copy(join(await getDatabasesPath(), "store.db"));
    } catch (e) {}
  }

  deleteDB() async {
    try {
      _database = null;
      deleteDatabase(join(await getDatabasesPath(), "store.db"));
    } catch (e) {}
  }

  Future<List<Product>> getDataExample() async {
    var data = <Product>[
      Product(
        id: 1,
        name: "GOMA EN POMO LAYCONSA ECOGREEN",
        description:
            "La goma es una sustancia resinosa que se pega muy rápidamente, con un alto peso molecular; estructuralmente muy compleja, siempre con carácter ácido. Es sólida, aunque su consistencia varía según su procedencia y las condiciones a las que se somete, y tiene la peculiaridad de ser genuinamente elástica.",
        price: 2.8,
        quantity: 99,
        barcode: "123",
        creationDate: DateTime.now(),
      ),
      Product(
        id: 2,
        name: "CREMA PONDS REHIDRATANTE NUEVA PRESENTACION 10G",
        description:
            "La crema S humectante y nutritiva Pond´s nutre y humecta la piel durante 48 horas de afuera hacia dentro, previniendo la resequedad de la piel, dejandola suave y tersa por fuera. Dermatológicamente probada.",
        price: 2.8,
        quantity: 12,
        barcode: "1234",
        creationDate: DateTime.now(),
      ),
      Product(
        id: 3,
        name: "GASEOSA ORO 300ML",
        description:
            "La gaseosa, o bebida carbonatada, es una bebida saborizada, efervescente (carbonatada) y sin alcohol. Estas bebidas suelen consu- mirse frías, para ser más refrescantes y para evitar la pérdida de dióxido de carbono, que le otorga la efervescencia.",
        price: 2.8,
        quantity: 31,
        barcode: "123333",
        creationDate: DateTime.now(),
      ),
      Product(
        id: 4,
        name: "PAPEL HIGIENICO ROSITA 2 ROLLOS",
        description: "descRIPCION 4",
        price: 80.83,
        quantity: 89,
        barcode: "12377733",
        creationDate: DateTime.now(),
      ),
      Product(
        id: 7,
        name: "VOLT MANZANA",
        description: "descRIPCION 7",
        price: 32.9,
        quantity: 2,
        barcode: "12339888133",
        creationDate: DateTime.now(),
      ),
      Product(
        id: 8,
        name: "MERMELADA MANZANA",
        description: "descRIPCION 8",
        price: 22,
        quantity: 17,
        barcode: "123330000233",
        creationDate: DateTime.now(),
      )
    ];

    return data;
  }
}
