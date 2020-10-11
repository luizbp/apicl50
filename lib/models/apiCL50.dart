import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:dio/dio.dart';

class CalculosAPIRepository{

  Future<Map<String, dynamic>> calculacl50(String comando) async{
    Response response;
    var dados = jsonDecode(comando);
    Dio dio = new Dio();
    try{
      // response = await dio.get("http://apicl50.herokuapp.com/cl50/$comando/");

      response = await dio.post(
        "http://apicl50.herokuapp.com/cl50/",
        data: {
          "c" : dados['c'],
          "i" : dados['i'],
          "m" : dados['m']
        }
      );
      if(response.statusCode == 200){
        if(response.data['response']['result']['cl50'] == response.data['response']['result']['min'] && 
        response.data['response']['result']['cl50'] == response.data['response']['result']['max']){
          return <String, dynamic>{
            'CL50': response.data['response']['result']['cl50'].toString(),
            'MIN': '-',
            'MAX': '-',
            'RESULT': 'SUCESSO'
          };
        }else{
          return <String, dynamic>{
            'CL50': response.data['response']['result']['cl50'].toString() ?? '-',
            'MIN': response.data['response']['result']['min'].toString() ?? '-',
            'MAX': response.data['response']['result']['max'].toString() ?? '-',
            'RESULT': 'SUCESSO'
          };
        }
      }
      else{
        return <String, dynamic>{
          'RESULT': 'FALHA',
          'MSG' : response.data['response']['result']['msg'].toString()
        };
      }
    }on Exception catch(_){
      return <String, dynamic>{
        'RESULT': 'FALHA',
        'MSG' : 'Ocorreu algum erro, verifique sua conexão e tente novamente'
      };
    }
  }
}