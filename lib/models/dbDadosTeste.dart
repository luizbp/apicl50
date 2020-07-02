import 'dart:async';
import 'dart:io';
import 'dadosTeste.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbDadosTeste{

  static DbDadosTeste _dataBaseHelper;
  static Database _dataBase;

  //definir colunas padronizadas 
  String tabDadosTeste = 'dadosTeste'; // NOME DA TABELA
  String colId = 'id'; //NOME COLUNA
  String colIdTeste = 'idTeste'; //NOME COLUNA
  String colConcentracao = 'concentracao'; //NOME COLUNA
  String colMortalidade24 = 'mortalidade24'; //NOME COLUNA
  String colMortalidade48 = 'mortalidade48'; //NOME COLUNA

  // Construtor
  DbDadosTeste._createInstance();

  factory DbDadosTeste(){

    if (_dataBaseHelper == null){
      _dataBaseHelper = DbDadosTeste._createInstance();
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
    String path = directory.path + 'dadosTeste.db';

    var dadosTesteDatabase = await openDatabase(path, version: 1, onCreate: _createDb); // CRIA O BANCO NO DIRETORIO INFORMADO
    return dadosTesteDatabase;
  }

  void _createDb(Database db, int newVersion) async{
    await db.execute('CREATE TABLE $tabDadosTeste('
      '$colId INTEGER PRIMARY KEY AUTOINCREMENT,' 
      '$colIdTeste INTEGER,'
      '$colConcentracao REAL,'
      '$colMortalidade24 INTEGER,'
      '$colMortalidade48 INTEGER'
      ')');
  }

  //INCLUIR DADOS NO BANCO
  Future<int> insertDadosTeste(DadosTeste dados) async{
    Database db = await this.database;
    var result = await db.insert(tabDadosTeste, dados.toMap());
    return result;
  }

  //Função de select por ID
  Future<DadosTeste> getDadosTeste(int id) async{
    Database db  = await this.database;

    List<Map> maps = await db.query(tabDadosTeste, 
    columns: [colId, colIdTeste, colConcentracao, colMortalidade24, colMortalidade48],
    where: "$colId = ?",
    whereArgs: [id]);

    if(maps.length > 0){
      return DadosTeste.fromMap(maps.first);
    }else{
      return null;
    }
  }

  //Função de Update
  Future<int> updateDadosTeste(DadosTeste dados) async{
    Database db = await this.database;

    var result = await db.update(tabDadosTeste, dados.toMap(),
    where: '$colId = ?',
    whereArgs: [dados.id]);

    return result;
  }

  //Deletar um objeto Contato do Banco de Dados
  Future<int> deleteDadosTeste(int id) async{
    Database db = await this.database;

    var result = await db.delete(tabDadosTeste,
    where: "$colId = ?",
    whereArgs: [id]);

    return result;
  }

  //Obtem o numero de linhas dentro da tabela
  Future<int> getCount() async{
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT(*) FROM $tabDadosTeste');

    var result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<DadosTeste>> getDadosTesteToTeste(int testeId) async{
    Database db = await this.database;
    var result = await db.query(tabDadosTeste,
    where: "$colIdTeste = ?",
    whereArgs: [testeId]);

    List<DadosTeste> maps = result.isNotEmpty ? result.map(
    (e) =>  DadosTeste.fromMap(e)).toList() : [];

    return maps;
  }

  Future close() async{
    Database db = await this.database;
    db.close();
  }
}
