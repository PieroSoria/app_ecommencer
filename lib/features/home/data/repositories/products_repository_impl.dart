import 'package:app_ecommencer/features/home/data/models/products_model.dart';
import 'package:app_ecommencer/features/home/domain/repositories/products_repository.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  @override
  Future<Database> initialSqflite() async {
    final path = await getDatabasesPath();
    final pathio = join(path, 'product.db');
    final mydb = await openDatabase(
      pathio,
      onCreate: (db, version) {
        db.execute('''
  CREATE TABLE productos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    description TEXT,
    precio REAL,
    imagen BLOB,
    created_at TEXT
  )
''');
      },
      version: 1,
    );
    return mydb;
  }

  @override
  Future<ProductsModel?> addProducts({required ProductsModel product}) async {
    final mydb = await initialSqflite();
    try {
      final data = await mydb.insert('productos', product.toJson());
      if (data > 0) {
        return product;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("El error al guardar datos es $e");
      return null;
    }
  }

  @override
  Future<bool> deleteProducts({required int id}) async {
    final mydb = await initialSqflite();
    try {
      final result = await mydb.delete(
        'productos',
        where: 'id = ?',
        whereArgs: [id],
      );
      return result > 0;
    } catch (e) {
      debugPrint("el error es $e");
      return false;
    }
  }

  @override
  Future<List<ProductsModel>> getListProducts() async {
    final mydb = await initialSqflite();
    try {
      final data = await mydb.query('productos').then((value) =>
          value.map((resu) => ProductsModel.fromJson(resu)).toList());
      return data;
    } catch (e) {
      debugPrint("el error es $e");
      return [];
    }
  }

  @override
  Future<ProductsModel?> getProductData({required int id}) async {
    final mydb = await initialSqflite();
    try {
      final data = await mydb
          .query('productos', where: 'id = ?', whereArgs: [id]).then((value) =>
              value.map((resu) => ProductsModel.fromJson(resu)).toList().first);
      return data;
    } catch (e) {
      debugPrint("El error es $e");
      return null;
    }
  }

  @override
  Future<ProductsModel?> updateProducts(
      {required ProductsModel product}) async {
    final mydb = await initialSqflite();
    try {
      final data = await mydb.update(
        'productos',
        product.toJson(),
        where: 'id = ?',
        whereArgs: [product.id],
      );
      return data > 0 ? product : null;
    } catch (e) {
      debugPrint("el error es $e");
      return null;
    }
  }
}
