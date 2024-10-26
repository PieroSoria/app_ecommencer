import 'package:app_ecommencer/features/home/data/models/products_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class ProductsRepository {
  Future<Database> initialSqflite();
  Future<ProductsModel?> getProductData({required int id});
  Future<List<ProductsModel>> getListProducts();
  Future<ProductsModel?> updateProducts({required ProductsModel product});
  Future<ProductsModel?> addProducts({required ProductsModel product});
  Future<bool> deleteProducts({required int id});
}
