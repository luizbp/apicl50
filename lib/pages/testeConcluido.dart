import 'package:cl50app/lib/funcoesDart.dart';
import 'package:cl50app/models/apiCL50.dart';
import 'package:cl50app/models/dbTestes.dart';
import 'package:cl50app/models/teste.dart';
import 'package:flutter/material.dart';

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
  bool progressionBool = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finalizado'),
        centerTitle: true,
        backgroundColor: Color(getColorTheme()),
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
                                      _atualizaTeste();
                                    }else{
                                      print('Erro');
                                    }
                                  });
                                  setState(() {
                                    progressionBool = false;
                                  });
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