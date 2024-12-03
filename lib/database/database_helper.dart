import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:groupprojfinal/models/dealership.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('dealerships.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Create database table
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''CREATE TABLE dealerships (
    id $idType,
    name $textType,
    streetAddress $textType,
    city $textType,  
    postalCode $textType  
  )''');
  }

  // Insert a dealership
  Future<int> insertDealership(Dealership dealership) async {
    final db = await instance.database;
    return await db.insert('dealerships', dealership.toMap());
  }

  // Get all dealerships
  Future<List<Dealership>> getDealerships() async {
    final db = await instance.database;
    final result = await db.query('dealerships');
    return result.map((json) => Dealership.fromMap(json)).toList();
  }

  // Delete a dealership
  Future<int> deleteDealership(int id) async {
    final db = await instance.database;
    return await db.delete('dealerships', where: 'id = ?', whereArgs: [id]);
  }

  // Update a dealership
  Future<int> updateDealership(Dealership dealership) async {
    final db = await instance.database;
    return await db.update('dealerships', dealership.toMap(),
        where: 'id = ?', whereArgs: [dealership.id]);
  }
}



