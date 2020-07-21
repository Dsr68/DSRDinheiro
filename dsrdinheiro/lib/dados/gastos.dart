import 'dart:core';
import "package:sqflite/sqflite.dart";
import "package:path/path.dart";

final String tabela = "Gastos";
final String idColumn = "id";
final String descColumn = "descricao";
final String categoriaColumn = "categoria";
final String valorColumn = "valor";

class Gasto {
  int id;
  String descricao;
  String categoria;
  double valor;

  Gasto();

  Gasto.fromMap(Map map) {
    id = map[idColumn];
    descricao = map[descColumn];
    categoria = map[categoriaColumn];
    valor = map[valorColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      descColumn: descricao,
      categoriaColumn: categoria,
      valorColumn: valor
    };

    if (id != null) {
      map[idColumn] = id;
    } else {
      return map;
    }
  }
}

class DadosdeGastos {
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
    final dataBasePath = await getDatabasesPath();
    final path = join(dataBasePath, "gasto.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newVersion) async {
      await db.execute("CREATE TABLE $tabela("
          "$idColumn INTEGER PRIMARY KEY, "
          "$descColumn TEXT, "
          "$categoriaColumn TEXT, "
          "$valorColumn REAL)");
    });
  }

  static Future<Gasto> salvar(Gasto gasto) async {
    Database dbGasto = await db;
    gasto.id = await dbGasto.insert(tabela, gasto.toMap());
    return gasto;
  }

  static Future<Gasto> getGasto(int id) async {
    Database dbGasto = await db;

    List<Map> maps = await dbGasto.query(tabela,
        columns: [idColumn, descColumn, categoriaColumn, valorColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Gasto.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<int> apagar(int id) async {
    Database dbGasto = await db;

    return await dbGasto
        .delete(tabela, where: "$idColumn = ?", whereArgs: [id]);
  }

  static Future<int> atualizar(Gasto gasto) async {
    Database dbGasto = await db;
    return await dbGasto.update(tabela, gasto.toMap(),
        where: "$idColumn = ?", whereArgs: [gasto.id]);
  }

  static Future<List> getAllGasto() async {
    Database dbGastos = await db;

    List listMap = await dbGastos.rawQuery("SELECT * FROM $tabela");
    List<Gasto> lista = List();

    for (Map m in listMap) {
      lista.add(Gasto.fromMap(m));
    }

    return lista;
  }

  static Future<int> contar(String categoria) async {
    Database dbGastos = await db;

    return Sqflite.firstIntValue(
        await dbGastos.rawQuery("SELECT COUNT(*) $tabela WHERE $categoria"));
  }

  Future close() async {
    Database dbGastos = await db;
    dbGastos.close();
  }
}
