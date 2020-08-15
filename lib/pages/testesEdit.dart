import 'package:flutter/material.dart';
import '../models/teste.dart';
import '../lib/funcoesDart.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class testesPageIn extends StatefulWidget {

  final Teste teste;

  testesPageIn({this.teste}); // recebe o projeto como parametro na tela anterior

  @override
  _testesPageInState createState() => _testesPageInState();
}

class _testesPageInState extends State<testesPageIn> {

  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _nomeResponsavelController = TextEditingController();
  final _nomeOrganismoController = TextEditingController();
  final _temperaturaSalaController = TextEditingController(); // Cº
  final _tipoTesteController = TextEditingController(); // Preliminar ou Definitivo
  final _substanciaAplicadaController = TextEditingController();
  final _repeticoesController = TextEditingController();
  final _unidadeMedidaConcetracaoController = TextEditingController();
  final _corController = TextEditingController();
  final _qtdOrganimosController = TextEditingController();
  final _statusTesteController = TextEditingController();
  final _concentracaoLetalController = TextEditingController();
  final _limiteSuperiorController = TextEditingController();
  final _limiteInferiorController = TextEditingController();

  bool _editado = false;
  Teste _testeEdit;

  List<String> _listTipoTeste = List<String>();

  ColorSwatch _tempMainColor;
  Color _tempShadeColor;
  ColorSwatch _mainColor = Colors.blue;
  Color _shadeColor = Colors.blue[800];

  @override
  void initState(){
    super.initState();

    _listTipoTeste.addAll(["Definitivo", "Preliminar"]);

    if(widget.teste == null){
      _testeEdit = Teste.novoTeste();
    }else{
      _testeEdit = Teste.fromMap(widget.teste.toMap());

    _nomeController.text = _testeEdit.nome;
    _descricaoController.text = _testeEdit.descricao;
    _nomeResponsavelController.text = _testeEdit.nomeResponsavel;
    _nomeOrganismoController.text = _testeEdit.nomeOrganismo;
    _temperaturaSalaController.text = _testeEdit.temperaturaSala;
    _tipoTesteController.text = _testeEdit.tipoTeste;
    _substanciaAplicadaController.text = _testeEdit.substanciaAplicada;
    _repeticoesController.text = _testeEdit.repeticoes;
    _unidadeMedidaConcetracaoController.text = _testeEdit.unidadeMedidaConcetracao;
    _corController.text = _testeEdit.cor;
    _qtdOrganimosController.text = _testeEdit.qtdOrganimos.toString();
    _statusTesteController.text = _testeEdit.statusTeste.toString();
    _concentracaoLetalController.text = _testeEdit.concentracaoLetal;
    _limiteSuperiorController.text = _testeEdit.limiteSuperior;
    _limiteInferiorController.text = _testeEdit.limiteInferior;
    }
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

  _comboBox(String titulo, List<String> items, String valorInicial, onChange){
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InputDecorator(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(4),
          border: OutlineInputBorder(),
          labelText: titulo,
        ),
        child: Container(
          alignment: Alignment.center,
          child: DropdownButton(
            underline: Text(''),
            value: valorInicial == '' ? items[0] : valorInicial,
            items: items.map((String item){
              return DropdownMenuItem(
                value: item,
                child: Row(
                  children: <Widget>[
                    Text(item)
                  ],
                ),
              );
            }).toList(),
            onChanged: onChange,  
          ),
        ),
      )
    );
  }


  void _openDialog() {
    showDialog(
    context: context,
    builder: (alertContext) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(6.0),
        title: Text("Selecionar Cor"),
        content: MaterialColorPicker(
          selectedColor: _shadeColor,
          onColorChange: (color){
            setState(() => _tempShadeColor = color);
          },
          onMainColorChange: (color) => setState(() => _tempMainColor = color),
        ),
        actions: [
          FlatButton(
          child: Text('Cancelar'),
          onPressed: () => Navigator.pop(alertContext, false),
          ),
          FlatButton(
            child: Text('Alterar'),
            onPressed: () {
                Navigator.pop(alertContext, false);
                var color = _tempShadeColor.toString().replaceAll('Color(', '');
                color = color.replaceAll(')', '');
                setState(() => _testeEdit.cor = color);
                //print(_shadeColor.value);
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(getColorTheme()),
          title: Text(_testeEdit.nome == '' ? 'Novo Teste' : _testeEdit.nome),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: _textField("Nome do Teste",_nomeController, TextInputType.text, 1, (text){
                    _editado = true;
                    setState(() {
                      _testeEdit.nome = text;
                    });
                  }),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _textField("Descrição",_descricaoController, TextInputType.text, 4,(text){
                      _editado = true;
                      setState(() {
                        _testeEdit.descricao = text;
                      });
                    }),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _textField("Nome do Responsavel",_nomeResponsavelController, TextInputType.text, 1, (text){
                      _editado = true;
                      setState(() {
                        _testeEdit.nomeResponsavel = text;
                      });
                    }),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _textField("Nome do Organismo",_nomeOrganismoController, TextInputType.text, 1,(text){
                      _editado = true;
                      setState(() {
                        _testeEdit.nomeOrganismo = text;
                      });
                    }),
                  ),
                  Expanded(
                    child: _textField("Temp. Sala (Cº)",_temperaturaSalaController, TextInputType.text, 1,(text){
                      _editado = true;
                      setState(() {
                        _testeEdit.temperaturaSala = text;
                      });
                    }),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                Expanded(
                  child: _comboBox(
                    "Tipo teste",
                    _listTipoTeste, 
                    _testeEdit.tipoTeste, 
                    (String item){
                      setState(() {
                        _testeEdit.tipoTeste = item;
                      });
                    }
                  )
                ),
                Expanded(
                  child: _comboBox(
                    "Desativado",
                    _listTipoTeste, 
                    "Preliminar", 
                    (String item){
                      setState(() {
                        item = item;
                      });
                    }
                  )
                )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _textField("Substancia Aplicada",_substanciaAplicadaController, TextInputType.text, 1,(text){
                      _editado = true;
                      setState(() {
                        _testeEdit.substanciaAplicada = text;
                      });
                    }),
                  ),
                  Expanded(
                    child: _textField("Unidade Medida",_unidadeMedidaConcetracaoController, TextInputType.text, 1,(text){
                      _editado = true;
                      setState(() {
                        _testeEdit.unidadeMedidaConcetracao = text;
                      });
                    }),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _textField("Repetições",_repeticoesController, TextInputType.number, 1,(text){
                      _editado = true;
                      setState(() {
                        _testeEdit.repeticoes = text;
                      });
                    }),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: InputDecorator(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(4),
                          border: OutlineInputBorder(),
                          labelText: "Cor do Projeto",
                        ),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              CircleAvatar(
                                maxRadius: 15,
                                backgroundColor: Color(_testeEdit.cor == '' ? 0xFF000000 : int.parse(_testeEdit.cor)),
                                
                              ),
                              FlatButton(
                                child: Text('Alterar'),
                                onPressed: (){
                                  _openDialog();
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: RaisedButton(
                      child: Text('Salvar'),
                      color: Color(getColorTheme()),
                      textColor: Colors.white,
                      onPressed: (){
                        Navigator.pop(context, _testeEdit);
                      },
                    ),
                  ),
                ],
              )
            ],
          )
        )
      );
  }
}
