class MortalidadeConcentracao{

  int id;
  int idConcentracao;
  int mortalidade;
  String duracao;

  MortalidadeConcentracao({this.id, this.idConcentracao, this.mortalidade, this.duracao});

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      "id" : id,
      "idConcentracao" : idConcentracao,
      "mortalidade" : mortalidade,
      "duracao" : duracao
    };

    return map;
  }

  MortalidadeConcentracao.fromMap(Map <String, dynamic> map){
    id = map['id'];
    idConcentracao = map['idConcentracao'];
    mortalidade = map['mortalidade'];
    duracao = map['duracao'];
  }


}