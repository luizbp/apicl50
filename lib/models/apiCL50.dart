import 'package:dio/dio.dart';

import 'package:dio/dio.dart';

class CalculosAPIRepository{

  Future<Map<String, dynamic>> calculacl50(String comando) async{
    Response response;
    Dio dio = new Dio();

    // response = await dio.get("http://apicl50.herokuapp.com/cl50/c(0.01,0.1,0.56,1.00,1.36,2.44),%205,%20c(0,1,3,4,5,5)/");
    try{
      response = await dio.get("http://apicl50.herokuapp.com/cl50/$comando/");
      if(response.statusCode == 200){
        // print(response.data['CL50'].toString());
        if(response.data['CL50'] == response.data['min'] && response.data['CL50'] == response.data['max']){
          return <String, dynamic>{
            'CL50': response.data['CL50'].toString(),
            'MIN': '-',
            'MAX': '-',
            'RESULT': 'SUCESSO'
          };
        }else{
          return <String, dynamic>{
            'CL50': response.data['CL50'].toString(),
            'MIN': response.data['min'].toString(),
            'MAX': response.data['max'].toString(),
            'RESULT': 'SUCESSO'
          };
        }
      }
      else{
        return <String, dynamic>{
          'RESULT': 'FALHA'
        };
      }
    }on Exception catch(_){
      return <String, dynamic>{
        'RESULT': 'FALHA'
      };
    }
  }
}