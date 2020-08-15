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
    super.initState();
     _testeAval = Teste.fromMap(widget.teste.toMap());
    atualizaLancamentos(); 
  }

  atualizaLancamentos(){
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
        child: Column(
          children: [
            Row(
              children: [
                ListView.builder(
                  itemCount: _dadosTeste.length,
                  itemBuilder: (context, index){
                    return CircleAvatar(
                      child: Text(_dadosTeste[index].concentracao.toString()),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // DadosTeste op = new DadosTeste(1, idTeste, concentracao, mortalidade24, mortalidade48)
          // db.insertDadosTeste()
          print(_testeAval.id);
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF065300),
        heroTag: 'Novo Lançamento'
      ),
    );
  }
}