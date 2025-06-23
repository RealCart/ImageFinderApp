import 'package:image_finder_app/core/constants/constant_variables.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbException implements Exception {
  DbException(this.message, [this.original]);
  final String message;
  final Object? original;

  @override
  String toString() =>
      'DbException: $message${original != null ? ' -> $original' : ''}';
}

class SqfliteClient {
  SqfliteClient._();
  static final SqfliteClient _singleton = SqfliteClient._();
  factory SqfliteClient() => _singleton;

  static const _dbName = 'image_finder_app.db';
  static const _dbVersion = 2;

  Database? _db;

  Future<Database> get db async => _db ??= await _openDb();

  static Future<void> init() async {
    await _singleton.db;
  }

  Future<Database> _openDb() async {
    final dir = await getDatabasesPath();
    final dataBasePath = join(dir, _dbName);

    return openDatabase(
      dataBasePath,
      version: _dbVersion,
      onCreate: (db, v) async {
        await db.execute('''
        CREATE TABLE IF NOT EXISTS $cachedRandomTable(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          value TEXT NOT NULL
        );
        ''');

        await db.execute('''
        CREATE TABLE IF NOT EXISTS $favoritesTable(
          id TEXT PRIMARY KEY,
          value TEXT NOT NULL
        );
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
          CREATE TABLE IF NOT EXISTS $favoritesTable(
            id TEXT PRIMARY KEY,
            value TEXT NOT NULL
          );
          ''');
        }
      },
    );
  }

  Future<List<Map<String, Object?>>> query(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    try {
      final res = await (await db).query(
        table,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
      return res;
    } catch (e) {
      throw DbException('Query failed on $table', e);
    }
  }

  Future<int> insert(String table, Map<String, Object?> values,
      {ConflictAlgorithm? conflictAlgorithm}) async {
    try {
      return await (await db).insert(
        table,
        values,
        conflictAlgorithm: conflictAlgorithm ?? ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw DbException('Insert failed on $table', e);
    }
  }

  Future<int> update(
    String table,
    Map<String, Object?> values, {
    String? where,
    List<Object?>? whereArgs,
    ConflictAlgorithm? conflictAlgorithm,
  }) async {
    try {
      return await (await db).update(
        table,
        values,
        where: where,
        whereArgs: whereArgs,
        conflictAlgorithm: conflictAlgorithm ?? ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw DbException('Update failed on $table', e);
    }
  }

  Future<int> delete(
    String table, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    try {
      return await (await db).delete(
        table,
        where: where,
        whereArgs: whereArgs,
      );
    } catch (e) {
      throw DbException('Delete failed on $table', e);
    }
  }

  Future<T> transaction<T>(Future<T> Function(Transaction txn) action) async {
    try {
      return await (await db).transaction(action);
    } catch (e) {
      throw DbException('Transaction failed', e);
    }
  }

  Future<void> close() async {
    await _db?.close();
    _db = null;
  }
}
