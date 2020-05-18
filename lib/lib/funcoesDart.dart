
int getColorTheme(){
  return 0xFF065300; //Cor padrão do App
}


String getIniciais(String parametro, int qtdIniciais){
  var quebra = parametro.split(' ');
  String result;

  if(qtdIniciais == 1){
    result = quebra[0][0];
    return result;
  }else if(qtdIniciais == 2){
    result = quebra[0][0] + quebra[1][0];
    return result;
  }else{
    result = quebra[0][0] + quebra[1][0] + quebra[2][0];
    return result;
  }
}