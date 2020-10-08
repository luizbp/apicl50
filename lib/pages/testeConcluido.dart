import 'package:cl50app/lib/funcoesDart.dart';
import 'package:cl50app/models/apiCL50.dart';
import 'package:cl50app/models/dbTestes.dart';
import 'package:cl50app/models/teste.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class TesteConcluido extends StatefulWidget {
  final Teste mdTeste;

  const TesteConcluido({Key key, this.mdTeste}) : super(key: key);

  @override
  _TesteConcluidoState createState() => _TesteConcluidoState();
}

class _TesteConcluidoState extends State<TesteConcluido> {

  

  double fontSizeDescricao = 17;
  double fontSizeTitulo = 17;

  DbTestes db = DbTestes();
  Teste testeExibicao;
  bool progressionBool = false, progressionBool2 = false;

  @override
  void initState(){
    super.initState();
    testeExibicao = Teste.fromMap(widget.mdTeste.toMap());
  }

  _atualizaTeste(){
    setState(() {
      db.getById(testeExibicao.id).then((value){
        testeExibicao = value;
      });
    });
  }

  _openPopUpAlertaMessage(context, String message, int type) {
    return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Container(
            child: Row(
              children: [
                Icon(
                  (type == 0) ? Icons.check : Icons.close,
                  color: (type == 0) ? Colors.green : Colors.red,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  (type == 0) ? 'Sucesso' : 'Erro'
                )
              ],
            ),
          ),
          content: Text(message),
          actions: [
            MaterialButton(
              child: Icon(
                Icons.check,
                color: Colors.green,
                ),
              onPressed: (){
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
  }

  Future<int> _popUpOpcoes(int id) async{
    int result;
    await showDialog(
      context: context,
      builder: (context){
        return AlertOpcoes(idTeste: id,);
      }
    );
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finalizado'),
        centerTitle: true,
        backgroundColor: Color(getColorTheme()),
        actions: [
          FlatButton(
            child: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: (){
              _popUpOpcoes(widget.mdTeste.id);
            },
          )
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      backgroundColor: Color(getColorTheme()),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      testeExibicao.nome,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      testeExibicao.descricao,
                      style: TextStyle(
                        color: Colors.grey
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Informações",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(getColorTheme())
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Responsável",
                      style: TextStyle(
                        fontSize: fontSizeTitulo,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF36AA23)
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      testeExibicao.nomeResponsavel,
                      style: TextStyle(
                        fontSize: fontSizeDescricao,
                        color: Colors.black
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Organismo",
                      style: TextStyle(
                        fontSize: fontSizeTitulo,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF36AA23)
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      testeExibicao.nomeOrganismo,
                      style: TextStyle(
                        fontSize: fontSizeDescricao,
                        color: Colors.black
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Temperatura da Sala (ºC)",
                      style: TextStyle(
                        fontSize: fontSizeTitulo,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF36AA23)
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      testeExibicao.temperaturaSala,
                      style: TextStyle(
                        fontSize: fontSizeDescricao,
                        color: Colors.black
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Tipo do Teste",
                      style: TextStyle(
                        fontSize: fontSizeTitulo,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF36AA23)
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      testeExibicao.tipoTeste,
                      style: TextStyle(
                        fontSize: fontSizeDescricao,
                        color: Colors.black
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Substância Aplicada",
                      style: TextStyle(
                        fontSize: fontSizeTitulo,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF36AA23)
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      testeExibicao.substanciaAplicada,
                      style: TextStyle(
                        fontSize: fontSizeDescricao,
                        color: Colors.black
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 2,
                  endIndent: 20,
                  indent: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Resultados",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(getColorTheme())
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "CL50",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF36AA23)
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      testeExibicao.concentracaoLetal,
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.black
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Limite Inferior",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE00707)
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              testeExibicao.limiteInferior,
                              style: TextStyle(
                                fontSize: 23,
                                color: Colors.black
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Limite Superior",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0C82B5)
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              testeExibicao.limiteSuperior,
                              style: TextStyle(
                                fontSize: 23,
                                color: Colors.black
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            (!progressionBool) ?
                            RaisedButton(
                              child: Text('Recalcular'),
                              color: Color(getColorTheme()),
                              textColor: Colors.white,
                              onPressed: (){
                                setState(() {
                                  progressionBool = true;
                                });
                                DbTestes db = DbTestes();
                                CalculosAPIRepository _calculos = CalculosAPIRepository();
                                String comandCalculo;
                                db.getStringCalculo(testeExibicao.id, testeExibicao.qtdOrganimos).then((value) async{
                                  comandCalculo = value;
                                  Map<String, dynamic> maps = Map<String, dynamic>();
                                  await _calculos.calculacl50(comandCalculo).then((value) async{
                                    maps = value;
                                    if(maps['RESULT'] != 'FALHA'){
                                      await db.setResultados(testeExibicao.id, maps['CL50'], maps['MAX'], maps['MIN']);
                                    }else{
                                      _openPopUpAlertaMessage(context, 'Ocorreu um erro, Tente novamente!', 1);
                                    }
                                  });
                                  setState(() {
                                    progressionBool = false;
                                  });
                                  _atualizaTeste();
                                });
                              },
                            )
                            :
                            CircularProgressIndicator()
                            ,
                          ],
                        )
                      ],
                    ) 
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class AlertOpcoes extends StatefulWidget {
  final int idTeste;

  const AlertOpcoes({Key key, this.idTeste}) : super(key: key);
  @override
  _AlertOpcoesState createState() => _AlertOpcoesState();
}

class _AlertOpcoesState extends State<AlertOpcoes> {

  bool progressionBool = false; 
  DbTestes db = DbTestes();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          title: Text('Opções', textAlign: TextAlign.center,),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              !progressionBool ? ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  'Exportar para Excel'
                ),
                onTap: () async{
                  setState(() {
                    progressionBool = !progressionBool;
                  });
                  await db.gerarExcel(widget.idTeste).then((value){
                    Share.shareFiles([value], text: 'Great picture');
                  });
                  setState(() {
                    progressionBool = !progressionBool;
                  });
                  Navigator.pop(context);
                },
              )
              :
              CircularProgressIndicator()
            ],
          )
      );
  }
}