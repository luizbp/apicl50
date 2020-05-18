import 'dart:async';
import 'dart:io';
import 'package:cl50app/models/teste.dart';
import 'teste.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbTestes{

  static DbTestes _dbTestes;
  static Database _database;

  //Padronizando nome das colunas
  String tabTestes = 'testes';
  String colId = 'id';
  String colNome = 'nome';
  String colDescricao = 'descricao';
  String colNomeResponsavel = 'nomeResponsavel';
  String colNomeOrganismo = 'nomeOrganismo';
  String colTemperaturaSala = 'temperaturaSala'; // Cº
  String colTipoTeste = 'tipoTeste'; // Preliminar ou Definitivo
  String colSubstanciaAplicada = 'substanciaAplicada';
  String colRepeticoes = 'repeticoes';
  String colUnidadeMedidaConcetracao = 'unidadeMedidaConcetracao';
  String colCor = 'cor';
  String colQtdOrganimos = 'qtdOrganimos';
  String colStatusTeste = 'statusTeste';
  String colConcentracaoLetal = 'concentracaoLetal';
  String colLimiteSuperior = 'limiteSuperior';
  String colLimiteInferior = 'limiteInferior';


  //Construtor padrão
  DbTestes._createInstance();

  factory DbTestes(){
    if(_dbTestes == null){
      _dbTestes = DbTestes._createInstance();
    }
    return _dbTestes;
  }

  Future<Database> get database async{
    if(_database == null){
      _database = await initializeDataBase();
    }
    return _database;
  }

  Future<Database> initializeDataBase() async{
    Directory directory = await getApplicationDocumentsDirectory(); // Pega o diretorio padrão do app pelo pacote path_procider
    String path = directory.path + '$tabTestes.db';

    var dadosTesteDataBase = await openDatabase(path, version: 1, onCreate: _createDb);
    return dadosTesteDataBase;
  }

  void _createDb(Database db, int newVersion) async{
    await db.execute('CREATE TABLE $tabTestes('
      '$colId INTEGER PRIMARY KEY AUTOINCREMENT, ' 
      '$colNome TEXT,'
      '$colDescricao TEXT,'
      '$colNomeResponsavel TEXT,'
      '$colNomeOrganismo TEXT,'
      '$colTemperaturaSala TEXT,'
      '$colTipoTeste TEXT,'
      '$colSubstanciaAplicada TEXT,'
      '$colRepeticoes TEXT,'
      '$colUnidadeMedidaConcetracao TEXT,'
      '$colCor TEXT,'
      '$colQtdOrganimos INTEGER,'
      '$colStatusTeste INTEGER,'
      '$colConcentracaoLetal TEXT,'
      '$colLimiteSuperior TEXT,'
      '$colLimiteInferior TEXT'
      ')');
  }

  //Insert no banco
  Future<int> insertTeste(Teste dados) async{
    Database db = await this.database;
    var result = await db.insert(tabTestes, dados.toMap());
    return result;
  }

 //Função de select por ID
  Future<Teste> getTeste(int id) async{
    Database db  = await this.database;

    List<Map> maps = await db.query(tabTestes, 
    columns: [
      colId,
      colNome,
      colDescricao,
      colNomeResponsavel,
      colNomeOrganismo,
      colTemperaturaSala,
      colTipoTeste,
      colSubstanciaAplicada,
      colRepeticoes,
      colUnidadeMedidaConcetracao,
      colCor,
      colQtdOrganimos,
      colStatusTeste,
      colConcentracaoLetal,
      colLimiteSuperior,
      colLimiteInferior
    ],
    where: "$colId = ?",
    whereArgs: [id]);

    if(maps.length > 0){
      return Teste.fromMap(maps.first);
    }else{
      return null;
    }
  }

  //Função de select por ID
  Future<List<Teste>> getTestes() async{
    Database db  = await this.database;

    var result = await db.query(tabTestes);

    List<Teste> lista = result.isNotEmpty ? result.map(
      (c) => Teste.fromMap(c)).toList() : [];
    
    return lista;
  }
  

  //Função de Update
  Future<int> updateTeste(Teste dados) async{
    Database db = await this.database;

    var result = await db.update(tabTestes, dados.toMap(),
    where: '$colId = ?',
    whereArgs: [dados.id]);

    return result;
  }

  //Deletar um objeto Contato do Banco de Dados
  Future<int> deleteTeste(int id) async{
    Database db = await this.database;

    var result = await db.delete(tabTestes,
    where: "$colId = ?",
    whereArgs: [id]);

    return result;
  }

  //Obtem o numero de linhas dentro da tabela
  Future<int> getCount() async{
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT(*) FROM $tabTestes');

    var result = Sqflite.firstIntValue(x);
    return result;
  }

  Future close() async{
    Database db = await this.database;
    db.close();
  }
}
