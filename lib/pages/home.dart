import 'package:flutter/material.dart';
import '../lib/funcoesDart.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  var numConcluidos = 100;
  var numPendentes = 15;

  void atualizaEstatistica(var pConcluidos, pPendentes){
    setState((){
      numConcluidos = pConcluidos;
      numPendentes = pPendentes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            height: 130,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 0.5, color: Colors.black),
              borderRadius: BorderRadius.all(const Radius.circular(20))
            ),
            margin: EdgeInsets.only(top: 35, left: 60, right: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Meus Projetos',
                      style: TextStyle(
                        color: Color(getColorTheme()),
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      numPendentes.toString(),
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Pendentes',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        border: Border.all(width: 0.5, color: Colors.white),
                        borderRadius: BorderRadius.all(const Radius.circular(100))
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      numConcluidos.toString(),
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w800,
                        fontSize: 20
                      )
                    ),
                    Text(
                      'Concluidos',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 20
                      ),
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(width: 0.5, color: Colors.white),
                        borderRadius: BorderRadius.all(const Radius.circular(100))
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}