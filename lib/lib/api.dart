import 'package:http/http.dart' as http;
const baseUrl = 'http://jsonplaceholder.typicode.com';

class API{
  static Future getProjects() async{
    var url = baseUrl + "/users";
    return await http.get(url);
  }

  // colocar na classe para fazer a leitura
  // var testes = new List<Teste>(); // Instanciei uma lista de objetos da classe Projetos 

  // _getProjetos(){ //Método privado para carregar a lista com a função da classe API que busca por uma requisição REST
  //   API.getProjects().then((response){
  //     setState(() {
  //       Iterable lista = json.decode(response.body); // Iterable funciona como um "for" para percorrer o json recebido
  //       testes = lista.map((model) => Teste.fromJson(model)).toList(); // Insere os dados recebidos como objetos
  //     });
  //   });
  // }

  // static Future getProjects() async{
  //   var retorno = ([{"id": 1,"status": 1,"descricao": "Teste Projeto","subDescricao": "Teste sub descrição!"}]).toString();

  //   return await retorno;
  // }
}