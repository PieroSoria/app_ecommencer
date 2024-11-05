import 'package:app_ecommencer/core/helper/database_repository.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final Database mydb;

  DatabaseRepositoryImpl({required this.mydb});

  @override
  Future addDataByDatabase() {
    // TODO: implement addDataByDatabase
    throw UnimplementedError();
  }

  @override
  Future deleteDataByDatabase() {
    // TODO: implement deleteDataByDatabase
    throw UnimplementedError();
  }

  @override
  Future getDataByDatabase() {
    // TODO: implement getDataByDatabase
    throw UnimplementedError();
  }

  @override
  Future updateDataByDatabase() {
    // TODO: implement updateDataByDatabase
    throw UnimplementedError();
  }
}
