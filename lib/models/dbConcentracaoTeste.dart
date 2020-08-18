import 'dart:async';
import 'dart:io';
import 'concentracaoTeste.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbConcentracaoTeste{

  static DbConcentracaoTeste _dataBaseHelper;
  static Database _dataBase;

  //definir colunas padronizadas 
  String tab = 'concentracaoTeste'; // NOME DA TABELA
  String colId = 'id'; //NOME COLUNA
  String colIdTeste = 'idTeste'; //NOME COLUNA
  String colConcentracao = 'concentracao';

  // Construtor
  DbConcentracaoTeste._createInstance();

  factory DbConcentracaoTeste(){

    if (_dataBaseHelper == null){
      _dataBaseHelper = DbConcentracaoTeste._createInstance();
    }
    return _dataBaseHelper;
  }

  Future<Database> get database async{
    if(_dataBase == null){
      _dataBase = await initializeDatabase();
    }
    return _dataBase;
  }

  Future<Database> initializeDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory(); // PEGA O DIRETORIO PADRÃO FORNECIDO PELO PACOTE path_provider
    String path = directory.path + 'concentracaoTeste.db';

    var dadosTesteDatabase = await openDatabase(path, version: 1, onCreate: _createDb); // CRIA O BANCO NO DIRETORIO INFORMADO
    return dadosTesteDatabase;
  }

  void _createDb(Database db, int newVersion) async{
    await db.execute('CREATE TABLE $tab('
      '$colId INTEGER PRIMARY KEY AUTOINCREMENT,' 
      '$colIdTeste INTEGER,'
      '$colConcentracao REAL'
      ')');
  }

  //INCLUIR DADOS NO BANCO
  Future<int> insert(ConcentracaoTeste dados) async{
    Database db = await this.database;
    var result = await db.insert(tab, dados.toMap());
    return result;
  }

  //Função de select por ID
  Future<ConcentracaoTeste> getById(int id) async{
    Database db  = await this.database;

    List<Map> maps = await db.query(tab, 
    columns: [colId, colIdTeste, colConcentracao],
    where: "$colId = ?",
    whereArgs: [id]);

    if(maps.length > 0){
      return ConcentracaoTeste.fromMap(maps.first);
    }else{
      return null;
    }
  }

  //Função de Update
  Future<int> update(ConcentracaoTeste dados) async{
    Database db = await this.database;

    var result = await db.update(tab, dados.toMap(),
    where: '$colId = ?',
    whereArgs: [dados.id]);

    return result;
  }

  //Deletar um objeto Contato do Banco de Dados
  Future<int> delete(int id) async{
    Database db = await this.database;

    var result = await db.delete(tab,
    where: "$colId = ?",
    whereArgs: [id]);

    return result;
  }

  //Obtem o numero de linhas dentro da tabela
  Future<int> getCount() async{
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT(*) FROM $tab');

    var result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<ConcentracaoTeste>> getByTeste(int testeId) async{
    Database db = await this.database;
    var result = await db.query(tab,
    where: "$colIdTeste = ?",
    whereArgs: [testeId]);

    List<ConcentracaoTeste> maps = result.isNotEmpty ? result.map(
    (e) =>  ConcentracaoTeste.fromMap(e)).toList() : [];

    return maps;
  }

  Future close() async{
    Database db = await this.database;
    db.close();
  }
}
