import 'package:cl50app/models/dadosTeste.dart';
import 'package:flutter/material.dart';
import '../lib/funcoesDart.dart';
import '../models/teste.dart';
import '../models/dadosTeste.dart';
import '../models/dbDadosTeste.dart';

class AvalTestes extends StatefulWidget {
  final Teste teste;

  AvalTestes(this.teste);

  @override
  _AvalTestesState createState() => _AvalTestesState();
}

class _AvalTestesState extends State<AvalTestes> {

  Teste _testeAval;
  List<DadosTeste> _dadosTeste = List<DadosTeste>();
  DbDadosTeste db = DbDadosTeste();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _testeAval = Teste.fromMap(widget.teste.toMap());

    // DadosTeste d = DadosTeste(4,2,1.8,3,0);
    
    // db.insertDadosTeste(d);

    _listaAvaliacoes(); 
  }

  _listaAvaliacoes(){
    this.setState(() {
      db.getDadosTesteToTeste(_testeAval.id).then((lista){
        _dadosTeste = lista;
      });
    });
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
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: _dadosTeste.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text('Teste'),
            );
          },
        ),
      ),
    );
  }
}