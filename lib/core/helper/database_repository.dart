abstract class DatabaseRepository {
  Future<dynamic> getDataByDatabase();
  Future<dynamic> addDataByDatabase();
  Future<dynamic> updateDataByDatabase();
  Future<dynamic> deleteDataByDatabase();
}
