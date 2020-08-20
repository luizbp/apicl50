import 'package:cl50app/models/concentracaoTeste.dart';
import 'package:cl50app/models/dbMortalidadeConcentracao.dart';
import 'package:cl50app/models/mortalidadesConcentracao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../lib/funcoesDart.dart';
import '../models/teste.dart';
import '../models/concentracaoTeste.dart';
import '../models/dbConcentracaoTeste.dart';
import 'package:intl/intl.dart';

class AvalTestes extends StatefulWidget {
  final Teste teste;

  AvalTestes(this.teste);

  @override
  _AvalTestesState createState() => _AvalTestesState();
}

class _AvalTestesState extends State<AvalTestes> {

  Teste _testeAval;
  List<ConcentracaoTeste> _dadosTeste = List<ConcentracaoTeste>();
  DbConcentracaoTeste dbConcetracao = DbConcentracaoTeste();

  List<MortalidadeConcentracao> _dadosMortalidade = List<MortalidadeConcentracao>();
  DbMortalidadeConcentracao dbMortalidade = DbMortalidadeConcentracao();
  int idConcentracaoSelecionada = 0;

  //
  String concentracao;

  @override
  void initState() {
    super.initState();
     _testeAval = Teste.fromMap(widget.teste.toMap());
    _atualizaConcentracao(); 
    _atualizaMortalidade();
  }

  _atualizaConcentracao() async{
    await dbConcetracao.getByTeste(_testeAval.id).then((lista){
      this.setState(() {
        _dadosTeste = lista;
      });
    });
  }

  _atualizaMortalidade() async{
    await dbMortalidade.getByConcentracao(idConcentracaoSelecionada).then((lista){
      this.setState(() {
        _dadosMortalidade = lista;
      });
    });
  }

  _listarMortalidade(){
    return ListView.builder(
      itemCount: _dadosMortalidade.length,
      itemBuilder: (context, index){
        
        if (_dadosMortalidade == null){
          return CircularProgressIndicator();
        }else if(_dadosMortalidade.length <= 0){
          print('Teste');
        }

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.orange,
                size: 35,
                ),
              title: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.red,
                        ),
                        Text(
                          'Mortes: ',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black
                          ),
                        ),
                        Text(
                          _dadosMortalidade[index].mortalidade.toString(),
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          size: 20,
                          color: Colors.green
                        ),
                        Text(
                          'Duracao: ',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black
                          ),
                        ),
                        Text(
                           _dadosMortalidade[index].duracao.toString(),
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              onLongPress: (){
                _popUpDeleta(
                  _dadosMortalidade[index].id, 
                  'Deletar Lançamento de M: ' + 
                    _dadosMortalidade[index].mortalidade.toString() + 
                    ' Duracao: ' + _dadosMortalidade[index].duracao.toString() + '?',
                  1
                );
              },
              onTap: (){

              }
            ),
          ),
        );
      },
    );
  }

  _listarConcentracao(){
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _dadosTeste.length,
      itemBuilder: (context, index){
        
        if (_dadosTeste == null){
          return CircularProgressIndicator();
        }else if(_dadosTeste.length <= 0){
          return Text('Nenhum Lançamento encontrado');
        }

        return Padding(
          padding: EdgeInsets.all(3),
          child: Card(
            color: (idConcentracaoSelecionada == _dadosTeste[index].id) ? Colors.black38 : null,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Material(
                // color: _color,
                color: (index&1 == 0) ? Colors.green : Colors.lightGreen,
                borderRadius: new BorderRadius.all(
                  Radius.circular(10),
                ),
                child: InkWell(
                  onTap: (){
                    idConcentracaoSelecionada = _dadosTeste[index].id;
                    _atualizaMortalidade();
                  },
                  onLongPress: (){
                    _popUpDeleta(
                      _dadosTeste[index].id, 
                      'Deseja deletar a concentracao ' + 
                        _dadosTeste[index].concentracao.toString() + '?',
                      0
                    );
                  },
                  borderRadius: new BorderRadius.all(
                    Radius.circular(10)
                  ),
                  // highlightColor: Colors.deepOrange,
                  child: Container(
                    width: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          _dadosTeste[index].concentracao.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),
                        )
                      ],
                    )
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _textField(String labelText, controller, typeInput, linhas, onChanged){
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        keyboardType: typeInput,
        onChanged: onChanged,
        controller: controller,
        maxLines: linhas,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
  }

  _openPopUpConcentracao(context) {
    return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Adicionar'),
          content: _textField(
            'Concetração', 
            null, 
            TextInputType.number, 
            1, 
            (valor){
              concentracao = valor;
            }),
          actions: [
            MaterialButton(
              child: Icon(
                Icons.check,
                color: Colors.green,
                ),
              onPressed: (){
                ConcentracaoTeste co = new ConcentracaoTeste(
                  concentracao: double.parse(concentracao),
                  idTeste: _testeAval.id
                );
                dbConcetracao.insert(co);
                _atualizaConcentracao();
                Navigator.pop(context);
              },
            ),
            MaterialButton(
              child: Icon(
                Icons.close,
                color: Colors.red,
                ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ],
        );
      }
    );
  }

  _openPopUpMortalidade(context, int idConcentracao) {
    return showDialog(
      context: context,
      builder: (context){
        return OpenDialogMortalidade(
          idConcentracao: idConcentracao,
        );
      }
    );
  }


  //OPERAÇÕES 

  _popUpDeleta(int id, String msg, int operacao){
    return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Atenção'),
          content: Text(
            msg
          ),
          actions: [
            MaterialButton(
              child: Icon(
                Icons.check,
                color: Colors.green,
                ),
              onPressed: (){
                if (operacao == 0){ //Concentração
                  dbConcetracao.delete(id);
                  _atualizaConcentracao();
                }else{
                  dbMortalidade.delete(id);
                  _atualizaMortalidade();
                }
                Navigator.pop(context);
              },
            ),
            MaterialButton(
              child: Icon(
                Icons.close,
                color: Colors.red,
                ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ],
        );
      }
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_testeAval.nome.toString()),
        centerTitle: true,
        backgroundColor: Color(getColorTheme()),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Concentrações',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 80,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Scrollbar(
                        child: _listarConcentracao()
                      ),
                    )
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(
                  textColor: Colors.lightBlue,
                  onPressed: (){
                    _openPopUpConcentracao(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      Text(
                        'Adicionar Concentração',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),  
                      )
                    ],
                  ),
                )
              ],
            ),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Lançamentos de Mortalidade',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Scrollbar(
                          child: _listarMortalidade(),
                        ),
                      ),
                    )
                  ],
                ),
              ) 
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(
                  textColor: Colors.lightBlue,
                  onPressed: (){
                    _openPopUpMortalidade(context, idConcentracaoSelecionada);
                    _atualizaMortalidade();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      Text(
                        'Adicionar Mortalidade',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),  
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     print(_dadosMortalidade.length);
      //   },
      //   child: Icon(Icons.add),
      //   backgroundColor: Color(0xFF065300),
      //   heroTag: 'Novo Lançamento'
      // ),
    );
  }
}




class OpenDialogMortalidade extends StatefulWidget {
  
  final int idConcentracao;

  const OpenDialogMortalidade({Key key, this.idConcentracao}) : super(key: key);

  @override
  _OpenDialogMortalidadeState createState() => _OpenDialogMortalidadeState();
}

class _OpenDialogMortalidadeState extends State<OpenDialogMortalidade> {

  DbMortalidadeConcentracao dbMortalidade = DbMortalidadeConcentracao();

  String _character = '24h';
  String mortalidade;


    _textField(String labelText, controller, typeInput, linhas, onChanged){
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        keyboardType: typeInput,
        onChanged: onChanged,
        controller: controller,
        maxLines: linhas,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Adicionar'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: _textField(
                  'Mortes', 
                  null, 
                  TextInputType.number, 
                  1, 
                  (valor){
                    mortalidade = valor;
                  }
                )
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: const Text('24h'),
                  leading: Radio(
                    value: '24h',
                    groupValue: _character,
                    onChanged: (value) {
                      setState(() {
                        _character = value;
                      }); 
                    },
                  ),
                )
              ),
              Expanded(
                child: ListTile(
                  title: const Text('48h'),
                  leading: Radio(
                    value: '48h',
                    groupValue: _character,
                    onChanged: (value) {
                      setState(() {
                        _character = value;
                      }); 
                    },
                  ),
                )
              )
            ],
          )
        ],
      ),
      actions: [
        MaterialButton(
          child: Icon(
            Icons.check,
            color: Colors.green,
            ),
          onPressed: (){
            MortalidadeConcentracao mo = new MortalidadeConcentracao(
              duracao: _character,
              idConcentracao: widget.idConcentracao,
              mortalidade: int.parse(mortalidade)
            );
            dbMortalidade.insert(mo);
            Navigator.pop(context);
          },
        ),
        MaterialButton(
          child: Icon(
            Icons.close,
            color: Colors.red,
            ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}