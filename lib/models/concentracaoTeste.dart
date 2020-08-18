class ConcentracaoTeste{

  int id;
  int idTeste;
  double concentracao;

  ConcentracaoTeste({this.id, this.idTeste, this.concentracao});


  //Transforma o objeto em um Map para gravar no banco
  Map<String, dynamic> toMap(){
    var map = <String,dynamic>{
      'id': id,
      'idTeste': idTeste,
      'concentracao':concentracao
    };
    return map;
  }

  //Recebe o map que vem do banco e transforma em um objeto "DadosTeste"
  ConcentracaoTeste.fromMap(Map<String, dynamic> map){
    id = map['id'];
    idTeste = map['idTeste'];
    concentracao = map['concentracao'];
  }

}