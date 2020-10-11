import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cl50app/models/concentracaoTeste.dart';
import 'package:cl50app/models/dbConcentracaoTeste.dart';
import 'package:cl50app/models/dbMortalidadeConcentracao.dart';
import 'package:cl50app/models/mortalidadesConcentracao.dart';
import 'package:cl50app/models/teste.dart';
import 'teste.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:path/path.dart';

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
    List<ConcentracaoTeste> concentracoes =  List<ConcentracaoTeste>();
    int op;
    String result, listaConcetracao = '(', listaMortalidade = '(';
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
      // result = listaConcetracao+','+qtdIndividuo.toString()+','+listaMortalidade;
      result = '{"c" : "'+listaConcetracao+'", "i" : "'+qtdIndividuo.toString()+'", "m" : "'+listaMortalidade+'"}';
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
      '$colStatusTeste': 0,
      '$colConcentracaoLetal' : '',
      '$colLimiteInferior' : '',
      '$colLimiteSuperior' : ''
    },
    where: '$colId = ?',
    whereArgs: [id]);

    return result;
  }

  Future<String> gerarExcel(int id) async{
    Database db = await this.database;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    var file = "modelos/Modelo.xlsx";
    var data = await rootBundle.load(file);
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);
    
    Teste teste = Teste(); 
    await getById(id).then((value){
      teste = value;
    });
    String nomeArquivo = teste.nome.replaceAll(' ', '_') + '_Planilhado';
    String outputFile = '${appDocDir.path}/docs/'+nomeArquivo+'.xlsx';

    var sheetObject = excel['Plan1'];

    //Nome do Responsavel
    var cell = sheetObject.cell(CellIndex.indexByString("B3"));
    cell.value = 'Responsável: ' + teste.nomeResponsavel;

    //Tipo Teste
    cell = sheetObject.cell(CellIndex.indexByString("B5"));
    cell.value = 'Teste: ' + teste.tipoTeste;

    // Espécie
    cell = sheetObject.cell(CellIndex.indexByString("B7"));
    cell.value = 'Espécie: ' + teste.nomeOrganismo;

    // Duração
    cell = sheetObject.cell(CellIndex.indexByString("B8"));
    cell.value = 'Duração: 48h';

    // Temperatura
    cell = sheetObject.cell(CellIndex.indexByString("B10"));
    cell.value = 'Temperatura da sala (ºC): ' + teste.temperaturaSala;

    // Subtância
    cell = sheetObject.cell(CellIndex.indexByString("B11"));
    cell.value = 'Ingrediente ativo: ' + teste.substanciaAplicada;

    // Nº Animais / Repetição
    cell = sheetObject.cell(CellIndex.indexByString("B12"));
    cell.value = 'Nº de animais/repetição: ' + teste.qtdOrganimos.toString() + '/' + teste.repeticoes;

    // Limite Superior
    cell = sheetObject.cell(CellIndex.indexByString("E44"));
    cell.value = teste.limiteSuperior;

    // CL50
    cell = sheetObject.cell(CellIndex.indexByString("E45"));
    cell.value = teste.concentracaoLetal;

    // Limite Inferior
    cell = sheetObject.cell(CellIndex.indexByString("E46"));
    cell.value = teste.limiteInferior;

    List<ConcentracaoTeste> concentracoes =  List<ConcentracaoTeste>();

    int op, tabela1 = 18, tabela2 = 34;

    await dbConcentracao.getByTeste(id).then((lista) async{
      concentracoes = lista;  
      for (op = 0; op < concentracoes.length; op++){
        
        // Adicionando as concentrações na primeira tabela
        cell = sheetObject.cell(CellIndex.indexByString("D"+(op + tabela1).toString()));
        cell.value = concentracoes[op].concentracao;

        // Adicionando as concentrações na segundo tabela
        cell = sheetObject.cell(CellIndex.indexByString("C"+(op + tabela2).toString()));
        cell.value = concentracoes[op].concentracao;

        List<MortalidadeConcentracao> mortalidades =  List<MortalidadeConcentracao>();
        await dbMortalidade.getByConcentracao(concentracoes[op].id).then((lista2){
          mortalidades = lista2;
          int op2;
          int quant24 = 0, quant48 = 0;
          for(op2 = 0; op2 < mortalidades.length; op2++){
            if(mortalidades[op2].duracao == '24h'){
              quant24 += mortalidades[op2].mortalidade;
            }else{
              quant48 += mortalidades[op2].mortalidade;
            }
          }

          // Adicionando as mortalidades de 24 na primeira tabela
          cell = sheetObject.cell(CellIndex.indexByString("E"+(op + tabela1).toString()));
          cell.value = quant24;
          // Adicionando as mortalidades de 48 na primeira tabela
          cell = sheetObject.cell(CellIndex.indexByString("F"+(op + tabela1).toString()));
          cell.value = quant48;

          // Adicionando a soma mortalidades na segunda tabela
          cell = sheetObject.cell(CellIndex.indexByString("D"+(op + tabela2).toString()));
          cell.value = quant24 + quant48;

          // Adicionando a média aritimetica na segunda tabela
          cell = sheetObject.cell(CellIndex.indexByString("E"+(op + tabela2).toString()));
          cell.value = num.parse(((quant48 * 100) / teste.qtdOrganimos).toStringAsPrecision(2));
        });
      }
    });


    // Saving the file
    await excel.encode().then((onValue) {
      File(join(outputFile))
        ..createSync(recursive: true)
        ..writeAsBytesSync(onValue);
    });

    return outputFile;
  }


  Future close() async{
    Database db = await this.database;
    db.close();
  }
}
