import 'package:flutter/material.dart';
import 'home.dart';
import 'testes.dart';
import 'devicesMqtt.dart';
import 'configuracoes.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
      appBar: AppBar(
        title: Text('TKS Mobile'),//Icon(Icons.people),
        centerTitle: true,
        backgroundColor: Color(0xFF065300),
        bottom: TabBar(
              labelColor: Colors.white,
            tabs: <Widget>[
             // Tab(icon: Icon(Icons.home)), // Pagina Inicial
              Tab(icon: Icon(Icons.assignment)), // Projetos em Aberto
              // Tab(icon: Icon(Icons.devices_other)), // Dispositivos MQTT
              // Tab(icon: Icon(Icons.brightness_7)), // Configurações
            ],
          ), 
        ),
      body: TabBarView(
        children: <Widget>[
          //homepage(), // Pagina Inicial
          testesPage(), // Projetos em Aberto
          // devicespage(), // Dispositivos MQTT
          // configuracaopage(), // Configurações
        ],
      ),
      ),
    );
  }
}
