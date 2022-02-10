import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "Miindfully.db";
  static final tableName = "cart";

  //cart table fields
  static final columnId = 'id';
  static final columnProductName = 'productName';
  static final columnQuantity = 'quantity';
  static final columnPrice = 'price';
  static final columnTotalPrice = 'totalPrice';
  static final columnDescription = 'description';
  static final columnRating = 'rating';
  static final columnImage = 'image';

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, '$_databaseName'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE $tableName($columnId integer primary key autoincrement,$columnProductName text not null,  $columnDescription text not null,"
          "$columnQuantity INTEGER NOT NULL,$columnImage text not null, $columnPrice INTEGER NOT NULL,$columnTotalPrice INTEGER NOT NULL,$columnRating DOUBLE NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertProduct(Map<String, dynamic> row) async {
    final Database db = await initializeDB();
    return await db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> fetchAllProductData() async {
    final Database db = await initializeDB();
    var result = await db.rawQuery('SELECT * FROM $tableName');
    return result.toList();
  }

  Future<int> updateQuantityAndPrice(int id, int quantity, int price) async {
    final Database db = await initializeDB();
    return await db.rawUpdate(
        'UPDATE $tableName SET $columnQuantity=? , $columnTotalPrice=?  WHERE $columnId=?',
        [quantity, price, id]);
  }

  Future<int> deleteProduct(int id) async {
    final Database db = await initializeDB();
    return await db.delete(tableName, where: '$columnId=?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> quantityCount() async {
    final Database db = await initializeDB();
    var result = await db
        .rawQuery('SELECT SUM($columnQuantity)"totalQuantity" FROM $tableName');
    return result.toList();
  }

  Future<List<Map<String, dynamic>>> fetchPriceAndQuantity() async {
    final Database db = await initializeDB();
    var result = await db.rawQuery(
        'SELECT SUM($columnQuantity)"totalQuantity",SUM($columnTotalPrice)"totalPrice" FROM $tableName');
    return result.toList();
  }
}
