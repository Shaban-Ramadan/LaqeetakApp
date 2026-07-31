import 'package:laqeetak/feature/model/loser_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> getDatabase() async {
    if (_db != null) return _db!;
    String path = join(await getDatabasesPath(), 'losers.db');
    _db = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE losers(
            id TEXT PRIMARY KEY,
            title TEXT,
            description TEXT,
            category TEXT,
            date TEXT,
            latitude REAL,
            longitude REAL,
            locationName TEXT,
            images TEXT
          )
        ''');
      },
    );
    return _db!;
  }

  static Future<void> insertLoser(LoserItemModel item) async {
    final db = await getDatabase();
    await db.insert('losers', item.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<LoserItemModel>> getAllLosers() async {
    final db = await getDatabase();
    final maps = await db.query('losers', orderBy: 'date DESC');
    return List.generate(maps.length, (i) => LoserItemModel.fromMap(maps[i]));
  }
}
