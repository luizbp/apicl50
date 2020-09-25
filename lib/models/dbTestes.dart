import 'dart:async';
import 'dart:io';
import 'package:cl50app/models/concentracaoTeste.dart';
import 'package:cl50app/models/dbConcentracaoTeste.dart';
import 'package:cl50app/models/dbMortalidadeConcentracao.dart';
import 'package:cl50app/models/mortalidadesConcentracao.dart';
import 'package:cl50app/models/teste.dart';
import 'teste.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbTestes{

  static DbTestes _dbTestes;
  static Database _database;

  DbConcentracaoTeste dbConcentracao = DbConcentracaoTeste();
  DbMortalidadeConcentracao dbMortalidade = DbMortalidadeConcentracao();

  //Padronizando nome das colunas
  String tab = 'testes';
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
    String path = directory.path + '$tab.db';

    var dadosTesteDataBase = await openDatabase(path, version: 1, onCreate: _createDb);
    return dadosTesteDataBase;
  }

  void _createDb(Database db, int newVersion) async{
    await db.execute('CREATE TABLE $tab('
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
  Future<int> insert(Teste dados) async{
    Database db = await this.database;
    var result = await db.insert(tab, dados.toMap());
    return result;
  }

 //Função de select por ID
  Future<Teste> getById(int id) async{
    Database db  = await this.database;

    List<Map> maps = await db.query(tab, 
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
  Future<List<Teste>> getAll() async{
    Database db  = await this.database;

    var result = await db.query(tab);

    List<Teste> lista = result.isNotEmpty ? result.map(
      (c) => Teste.fromMap(c)).toList() : [];
    
    return lista;
  }
  

  //Função de Update
  Future<int> update(Teste dados) async{
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

    dbConcentracao.deleteByTeste(id);

    return result;
  }

  //Obtem o numero de linhas dentro da tabela
  Future<int> getCount() async{
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT(*) FROM $tab');

    var result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<String> getStringCalculo(int id, int qtdIndividuo) async{
    Database db = await this.database;
    List<ConcentracaoTeste> concentracoes =  List<ConcentracaoTeste>();
    int op;
    String result, listaConcetracao = 'c(', listaMortalidade = 'c(';
    await dbConcentracao.getByTeste(id).then((lista) async{
      concentracoes = lista;  
      for (op = 0; op < concentracoes.length; op++){
        if((op + 1) == concentracoes.length){
          listaConcetracao += concentracoes[op].concentracao.toString() + ')';
        }else{
          listaConcetracao += concentracoes[op].concentracao.toString() + ',';
        }
        List<MortalidadeConcentracao> mortalidades =  List<MortalidadeConcentracao>();
        await dbMortalidade.getByConcentracao(concentracoes[op].id).then((lista2){
          mortalidades = lista2;
          int op2;
          int quant = 0;
          for(op2 = 0; op2 < mortalidades.length; op2++){
            quant += mortalidades[op2].mortalidade;
          }
          if((op + 1) == concentracoes.length){
            listaMortalidade += quant.toString() + ')';
          }else{
            listaMortalidade += quant.toString() + ',';
          }
        });
      }
      result = listaConcetracao+','+qtdIndividuo.toString()+','+listaMortalidade;
      // print(result);
    });
    return result;
  }

    //Função de Update
  Future<int> setResultados(int id, String cl50, String max, String min) async{
    Database db = await this.database;

    var result = await db.update(tab,
    {
      '$colConcentracaoLetal': cl50,
      '$colLimiteInferior': min,
      '$colLimiteSuperior': max,
      '$colStatusTeste': 1
    },
    where: '$colId = ?',
    whereArgs: [id]);

    return result;
  }

  //Reabre Teste
  Future<int> reabrir(int id) async{
    Database db = await this.database;

    var result = await db.update(tab,
    {
      '$colStatusTeste': 0
    },
    where: '$colId = ?',
    whereArgs: [id]);

    return result;
  }


  Future close() async{
    Database db = await this.database;
    db.close();
  }
}
