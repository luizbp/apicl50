import 'package:cl50app/models/dadosTeste.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:random_color/random_color.dart';
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
  RandomColor _randomColor = RandomColor();
  
  @override
  void initState() {
    super.initState();
     _testeAval = Teste.fromMap(widget.teste.toMap());
    atualizaLancamentos(); 
  }

  atualizaLancamentos() async{
    await db.getDadosTesteToTeste(_testeAval.id).then((lista){
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // FlatButton(
                //   child: Text(
                //     '+',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 25
                //     ),
                //   ),
                //   color: Colors.blueAccent,
                //   shape: new RoundedRectangleBorder(
                //     borderRadius: new BorderRadius.circular(100)
                //     ),
                //   onPressed: (){

                //   },
                // ),
                Padding(
                  padding: const EdgeInsets.only(top:15, right: 20),
                  child: Material(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(100)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top:2,
                        left: 10,
                        right: 10,
                        bottom: 2
                      ),
                      child: InkWell(
                        child: Text(
                          '+',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25
                          ),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(100)
                        ),
                      ),
                    ),
                  ),
                )
              ],
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
                            Color _color = _randomColor.randomColor(
                              colorBrightness: ColorBrightness.light
                            );
                            return Padding(
                              padding: EdgeInsets.all(5),
                              child: Material(
                                color: _color,
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
            )
          ],
        ),
      ),
      // body: Container(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: [
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //           SizedBox(
      //             child: Scrollbar(
      //               child: ListView.builder(
      //                 itemCount: _dadosTeste.length,
      //                 scrollDirection: Axis.horizontal,
      //                 itemBuilder: (context, index){
      //                   return CircleAvatar(
      //                     child: Text(_dadosTeste[index].concentracao.toString()),
      //                   );
      //                 },
      //               ),
      //             ),
      //           ),
      //         ]
      //       )
      //     ],
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // DadosTeste op = new DadosTeste(4, 1, 1.5, 0, 0);
          // db.insertDadosTeste(op);
          //print(_dadosTeste.length);
          // print(_testeAval.id);
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF065300),
        heroTag: 'Novo Lançamento'
      ),
    );
  }
}