import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../modal/contact.model.dart';

class ContactDatabase {
  static final ContactDatabase instance = ContactDatabase._init();
  static Database? _database;

  ContactDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('contacts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE $tableName (
        ${ContactFields.id} $idType,
        ${ContactFields.nom} $textType,
        ${ContactFields.tel} $textType
      )
    ''');
  }

  Future<Contact> create(Contact contact) async {
    final db = await instance.database;
    final id = await db.insert(tableName, contact.toJson());
    return contact.copyWith(id: id as int);
  }

  Future<Contact?> readContact(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableName,
      columns: ContactFields.values,
      where: '${ContactFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Contact.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Contact>> readAllContacts() async {
    final db = await instance.database;
    final orderBy = '${ContactFields.nom} ASC';
    final result = await db.query(tableName, orderBy: orderBy);
    return result.map((json) => Contact.fromJson(json)).toList();
  }

  Future<int> update(Contact contact) async {
    final db = await instance.database;
    return db.update(
      tableName,
      contact.toJson(),
      where: '${ContactFields.id} = ?',
      whereArgs: [contact.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableName,
      where: '${ContactFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

// Constantes pour la table et les champs de contact
const String tableName = 'contacts';

class ContactFields {
  static const String id = 'id';
  static const String nom = 'nom';
  static const String tel = 'tel';

  static const List<String> values = [id, nom, tel];
}
