import 'package:cl50app/models/concentracaoTeste.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  
  @override
  void initState() {
    super.initState();
     _testeAval = Teste.fromMap(widget.teste.toMap());
    atualizaLancamentos(); 
  }

  atualizaLancamentos() async{
    await dbConcetracao.getByTeste(_testeAval.id).then((lista){
      this.setState(() {
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
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _dadosTeste.length,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: EdgeInsets.all(5),
                              child: Material(
                                // color: _color,
                                color: (index&1 == 0) ? Colors.green : Colors.lightGreen,
                                borderRadius: new BorderRadius.all(
                                  Radius.circular(10)
                                ),
                                child: InkWell(
                                  onTap: (){
                                    
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
                            );
                          },
                        ),
                      ),
                    )
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(
                  textColor: Colors.lightBlue,
                  onPressed: (){

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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // ConcentracaoTeste op = new ConcentracaoTeste(
          //   concentracao: 2.5,
          //   idTeste: 1
          // );
          // dbConcetracao.insert(op);
          // setState(() {
          //   atualizaLancamentos();
          // });
          // print(_dadosTeste.length);
          // print(_testeAval.id);
          DateTime now = DateTime.now();
          String date = DateFormat('dd/MM/yyyy - HH:mm:ss').format(now);
          print(date);
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF065300),
        heroTag: 'Novo Lançamento'
      ),
    );
  }
}