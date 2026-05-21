import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as pp;
import '../models/item_model.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() => _instance;

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await pp.getApplicationDocumentsDirectory();
    final path = p.join(documentsDirectory.path, 'colecao_albuns.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE itens (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nomeAlbum TEXT NOT NULL,
    artista TEXT NOT NULL,
    genero TEXT NOT NULL,
    anoLancamento INTEGER NOT NULL,
    valorPago REAL NOT NULL,
    caminhoCapa TEXT
    
    )
''');
  }

  //CRUD
  // create
  Future<int> cadastrarItem(ItemColecao item) async {
    final db = await database;
    return await db.insert('itens', item.toMap());
  }

  // read
  Future<List<ItemColecao>> listarItens({String? buscaNome}) async {
    final db = await database;

    String whereClause = '';
    List<dynamic> whereArgs = [];

    if (buscaNome != null && buscaNome.isNotEmpty) {
      whereClause += '(nomeAlbum LIKE ? OR artista LIKE ?)';
      whereArgs.addAll(['%buscaNome%', '%buscaNome%']);
    }

    final List<Map<String, dynamic>> maps = await db.query(
      'itens',
      where: whereClause.isNotEmpty ? whereClause : null,
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
      orderBy: 'nomeAlbum ASC',
    );

    return List.generate(maps.length, (i) => ItemColecao.fromMap(maps[i]));
  }
  
  // editar
  Future<int> editarItem(ItemColecao item) async {
    final db = await database;
    return await db.update(
      'itens',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  // delete
  Future<int> excluirItem(int id) async {
    final db = await database;
    return await db.delete(
      'itens',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
