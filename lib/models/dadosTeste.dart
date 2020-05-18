class DadosTeste{

  int id;
  int idTeste;
  double concentracao;
  int mortalidade24;
  int mortalidade48;

  DadosTeste(this.id, this.idTeste, this.concentracao, this.mortalidade24, this.mortalidade48);


  //Transforma o objeto em um Map para gravar no banco
  Map<String, dynamic> toMap(){
    var map = <String,dynamic>{
      'id': id,
      'idTeste': idTeste,
      'concentracao':concentracao,
      'mortalidade24': mortalidade24,
      'mortalidade48': mortalidade48,
    };
    return map;
  }

  //Recebe o map que vem do banco e transforma em um objeto "DadosTeste"
  DadosTeste.fromMap(Map<String, dynamic> map){
    id = map['id'];
    idTeste = map['idTeste'];
    concentracao = map['concentracao'];
    mortalidade24 = map['mortalidade24'];
    mortalidade48 = map['mortalidade48'];
  }

}