import 'package:flutter/material.dart';
import '../models/teste.dart';

class Modal{

  exibeBottomSheet(BuildContext bsContext, acao){
    showModalBottomSheet(
      context: bsContext, 
      builder: (bsContext){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _criarBotaoDeAcao(bsContext, "Excluir", Icons.delete, acao),
            _criarBotaoDeAcao(bsContext, "Editar", Icons.edit, acao),
          ],
        );
      }
    );
  }

  ListTile _criarBotaoDeAcao(BuildContext context, String nome, IconData icon, acao){
    return ListTile(
      leading: Icon(icon),
      title: Text(nome),
      onTap: (){
        Navigator.pop(context);
        acao();
      },
    );
  }
}