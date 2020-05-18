import 'dart:convert';
import 'package:cl50app/models/dbTestes.dart';
import 'package:flutter/material.dart';
import '../models/teste.dart';
import 'testes_in.dart';
import '../lib/funcoesDart.dart';
import '../lib/modal.dart';

class testesPage extends StatefulWidget {
  @override
  _testesPageState createState() => _testesPageState();
}

class _testesPageState extends State<testesPage> {

  DbTestes db = DbTestes();
  List<Teste> testes = List<Teste>();

  @override
  void initState(){
    super.initState();
    _refreshListaTestes();
  }



  

  _deletarTeste(Teste teste){

  }

  void _refreshListaTestes(){
    db.getTestes().then((lista){
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
        await db.updateTeste(testeRecebido);
      }else{
        await db.insertTeste(testeRecebido);
      }
      _refreshListaTestes();
    }
  }

  listarTestes(){
    return ListView.builder(
      itemCount: testes.length,
      itemBuilder: (context, index){
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Color(int.parse(testes[index].cor)),
            child: Text(
              getIniciais(testes[index].nome, 2).toUpperCase(),
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
            _exibeTestePageIn(teste: testes[index]);
          },
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

