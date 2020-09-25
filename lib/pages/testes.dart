import 'dart:convert';
import 'package:cl50app/models/dbTestes.dart';
import 'package:cl50app/pages/testeConcluido.dart';
import 'package:flutter/material.dart';
import '../models/teste.dart';
import 'testesEdit.dart';
import '../lib/funcoesDart.dart';
import 'avalTestes.dart';

class testesPage extends StatefulWidget {
  @override
  _testesPageState createState() => _testesPageState();
}

class _testesPageState extends State<testesPage> {

  DbTestes dbTeste = DbTestes();
  List<Teste> testes = List<Teste>();

  @override
  void initState(){
    super.initState();
    _refreshListaTestes();
  }

  _deletarTeste(Teste teste){

  }
  
  void _refreshListaTestes(){
    dbTeste.getAll().then((lista){
    setState(() {
      testes = lista;
    });
  });
  }

  Icon _verificaStatus(int parametro){
    if(parametro == 0){
      return Icon(
        Icons.access_time,
        color: Colors.deepOrange,
      );
    }else{
      return Icon(
        Icons.check_circle_outline,
        color: Colors.green,
      );
    }
  }

  void _exibeTestePageIn({Teste teste}) async{
    final testeRecebido = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => testesPageIn(teste:teste)
      )
    );

    if(testeRecebido != null){
      if(teste != null){
        await dbTeste.update(testeRecebido);
      }else{
        await dbTeste.insert(testeRecebido);
      }
      _refreshListaTestes();
    }else{
      _refreshListaTestes();
    }
  }

  void _exibeAvalTestes(Teste teste) async{
     if(teste.statusTeste == 0){
       Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => AvalTestes(teste)
            // builder: (context) => TesteConcluido(mdTeste: teste)
          )
        );
     }else{
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => TesteConcluido(mdTeste: teste)
        )
      );
     }
  }

  Future<bool> _openPopUpPergunta(context, String message) async {
    bool result;
    await showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Container(
            child: Row(
              children: [
                Icon(
                  Icons.device_unknown,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  message
                )
              ],
            ),
          ),
          actions: [
            MaterialButton(
              child: Icon(
                Icons.check,
                color: Colors.green,
                ),
              onPressed: (){
                result = true;
                Navigator.pop(context);
              },
            ),
            MaterialButton(
              child: Icon(
                Icons.close,
                color: Colors.red,
                ),
              onPressed: (){
                result = false;
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );

    return result;
  }

  Future<int> _popUpOpcoes() async{
    int result;
    await showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Opções', textAlign: TextAlign.center,),
          content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    'Editar Teste'
                  ),
                  onTap: (){
                    result = 0;
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.replay,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    'Reabrir Teste'
                  ),
                  onTap: (){
                    result = 1;
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.restore_from_trash,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    'Deletar Teste'
                  ),
                  onTap: () async{
                    bool op; 
                    await _openPopUpPergunta(context, "Deletar").then((value) => op = value);
                    if(op){
                      result = 3;
                    }else{
                      result = 4;
                    }
                    Navigator.pop(context);
                  },
                ),
              ],
            )
        );
      }
    );
    return result;
  }

  listarTestes(){
    return ListView.builder(
      itemCount: testes.length,
      itemBuilder: (context, index){
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(int.parse(testes[index].cor)),
              child: Text(
                getIniciais(testes[index].nome, 1).toUpperCase(),
                style: TextStyle(color: Colors.white),
              ),
            ), 
            trailing: _verificaStatus(testes[index].statusTeste),
            title: Text(
              testes[index].nome,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black
              ),
            ),
            subtitle: Text(
              testes[index].descricao.substring(0) + '...',
            ),
            onLongPress: (){
              _popUpOpcoes().then((value){
                switch(value){
                  case 0: // EDITA O TESTE
                    _exibeTestePageIn(teste: testes[index]);
                  break;
                  case 1: // REABRE O TESTE
                    dbTeste.reabrir(testes[index].id);
                    _refreshListaTestes();
                  break;
                  case 3: // DELETA O TESTE
                    dbTeste.delete(testes[index].id);
                    _refreshListaTestes();
                  break;
                }
              });
            },
            onTap: (){
              _exibeAvalTestes(testes[index]);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _exibeTestePageIn();
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF065300),
        heroTag: 'Adicionar',
      ),
      body: Scrollbar(
        child: listarTestes()
      ),
    );
  }
}

