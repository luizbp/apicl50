class Teste{
  int id;

  //Informações
  String nome;
  String descricao;
  String nomeResponsavel;
  String nomeOrganismo;
  String temperaturaSala; // Cº
  String tipoTeste; // Preliminar ou Definitivo
  String substanciaAplicada;
  String repeticoes;
  String unidadeMedidaConcetracao;
  String cor;

  //Dados
  int qtdOrganimos;
  int statusTeste;

  //Resultados
  String concentracaoLetal;
  String limiteSuperior;
  String limiteInferior;

  //Construtor
  Teste({
    this.id,
    this.nome,
    this.descricao,
    this.nomeResponsavel,
    this.nomeOrganismo,
    this.temperaturaSala,
    this.tipoTeste,
    this.substanciaAplicada,
    this.repeticoes,
    this.unidadeMedidaConcetracao,
    this.cor,
    this.qtdOrganimos,
    this.concentracaoLetal,
    this.limiteSuperior,
    this.limiteInferior,
    this.statusTeste
  });

  //Transforma o objeto em um Map para gravar no banco
  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
    'id' : id,
    'nome' : nome,
    'descricao' : descricao,
    'nomeResponsavel' : nomeResponsavel,
    'nomeOrganismo' : nomeOrganismo,
    'temperaturaSala' : temperaturaSala,
    'tipoTeste' : tipoTeste,
    'substanciaAplicada' : substanciaAplicada,
    'repeticoes' : repeticoes,
    'unidadeMedidaConcetracao' : unidadeMedidaConcetracao,
    'cor' : cor,
    'qtdOrganimos' : qtdOrganimos,
    'statusTeste' : statusTeste,
    'concentracaoLetal' : concentracaoLetal,
    'limiteSuperior' : limiteSuperior,
    'limiteInferior' : limiteInferior
    };

    return map;
  }

  //Recebe o map que vem do banco e transforma em um objeto "Teste"
  Teste.fromMap(Map<String, dynamic> map){
    id = map['id'];
    nome = map['nome'];
    descricao = map['descricao'];
    nomeResponsavel = map['nomeResponsavel'];
    nomeOrganismo = map['nomeOrganismo'];
    temperaturaSala = map['temperaturaSala'];
    tipoTeste = map['tipoTeste'];
    substanciaAplicada = map['substanciaAplicada'];
    repeticoes = map['repeticoes'];
    unidadeMedidaConcetracao = map['unidadeMedidaConcetracao'];
    cor = map['cor'];
    qtdOrganimos = map['qtdOrganimos'];
    concentracaoLetal = map['concentracaoLetal'];
    limiteSuperior = map['limiteSuperior'];
    limiteInferior = map['limiteInferior'];
    statusTeste = map['statusTeste'];
  }

  //inicia vazio
  Teste.novoTeste(){
    id = null;
    nome = '';
    descricao = '';
    nomeResponsavel = '';
    nomeOrganismo = '';
    temperaturaSala = '';
    tipoTeste = '';
    substanciaAplicada = '';
    repeticoes = '';
    unidadeMedidaConcetracao = '';
    cor = '';
    qtdOrganimos = 0;
    concentracaoLetal = '';
    limiteSuperior = '';
    limiteInferior = '';
    statusTeste = 0;
  }

}