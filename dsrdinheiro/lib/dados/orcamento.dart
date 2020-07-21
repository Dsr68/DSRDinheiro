import "package:sqflite/sqflite.dart";
import "package:path/path.dart";

final String tabela = "Planejamento";
final String idColumn = "id";
final String categoriaColumn = "categoria";
final String valorColumn = "valor";

class Orcamento {
  int id;
  String categoria;
  double valor;

  Orcamento();

  Orcamento.fromMap(Map map) {
    id = map[idColumn];
    categoria = map[categoriaColumn];
    valor = map[valorColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {categoriaColumn: categoria, valorColumn: valor};

    if (id != null) {
      map[idColumn] = id;
    } else {
      return map;
    }
  }
}

class DadosOrcamento {
  static Database _db;

  static Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  static Future<Database> initDb() async {
    final DatabasePath = await getDatabasesPath();
    final path = join(DatabasePath, "orcamento.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newVersion) async {
      await db.execute("CREATE TABLE $tabela("
          "$idColumn INTEGER PRIMARY KEY, "
          "$categoriaColumn TEXT, "
          "$valorColumn REAL");
    });
  }

  static Future<Orcamento> salva(Orcamento orcamento) async {
    Database dbOrcamento = await db;
    orcamento.id = await dbOrcamento.insert(tabela, orcamento.toMap());
    return orcamento;
  }

  static Future<Orcamento> getOrcamento(int id) async {
    Database dbOrcamento = await db;
    List<Map> maps = await dbOrcamento.query(tabela,
        columns: [idColumn, categoriaColumn, valorColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Orcamento.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<int> apagar(int id) async {
    Database dbOrcamento = await db;
    return await dbOrcamento
        .delete(tabela, where: "$idColumn = ?", whereArgs: [id]);
  }

  static Future<int> atualizar(Orcamento orcamento) async {
    Database dbOrcamento = await db;
    return await dbOrcamento.update(tabela, orcamento.toMap(),
        where: "$idColumn", whereArgs: [orcamento.id]);
  }

  static Future<List> getAllOrcamento() async {
    Database dbOrcamento = await db;
    List listMap = await dbOrcamento.rawQuery("SELECT * FROM $tabela");
    List<Orcamento> lista = new List();

    for (Map m in listMap) {
      lista.add(Orcamento.fromMap(m));
    }

    return lista;
  }

  static Future fechar() async {
    Database dbOrcamento = await db;
    dbOrcamento.close();
  }
}
