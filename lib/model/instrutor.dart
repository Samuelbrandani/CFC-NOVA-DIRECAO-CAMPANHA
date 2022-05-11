class Instrutor {
  String cODINSTRUTOR;
  String nOMEINSTRUTOR;
  String sENHA;

  Instrutor({this.cODINSTRUTOR, this.nOMEINSTRUTOR, this.sENHA});

  Instrutor.fromJson(Map<String, dynamic> json) {
    cODINSTRUTOR = json['COD_INSTRUTOR'];
    nOMEINSTRUTOR = json['NOME_INSTRUTOR'];
    sENHA = json['SENHA'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['COD_INSTRUTOR'] = this.cODINSTRUTOR;
    data['NOME_INSTRUTOR'] = this.nOMEINSTRUTOR;
    data['SENHA'] = this.sENHA;
    return data;
  }
}

class AulasInstrutor {
  String dATAAULA;
  String vEICULOAULA;
  String hORAAULA;
  String nUMEROAULA;
  String iNSTRUTORAULA;
  String nOMEALUNO;
  String cODINSTRUTOR;
  String dataError;

  AulasInstrutor(
      {this.dATAAULA,
      this.vEICULOAULA,
      this.hORAAULA,
      this.nUMEROAULA,
      this.iNSTRUTORAULA,
      this.nOMEALUNO,
      this.cODINSTRUTOR});

  AulasInstrutor.dataTransform(Map<String, dynamic> json) {
    dataError = json['data'];
  }

  AulasInstrutor.fromJson(Map<String, dynamic> json) {
    dATAAULA = json['DATA_AULA'];
    vEICULOAULA = json['VEICULO_AULA'];
    hORAAULA = json['HORA_AULA'];
    nUMEROAULA = json['NUMERO_AULA'];
    iNSTRUTORAULA = json['INSTRUTOR_AULA'];
    nOMEALUNO = json['NOME_ALUNO'];
    cODINSTRUTOR = json['COD_INSTRUTOR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DATA_AULA'] = this.dATAAULA;
    data['VEICULO_AULA'] = this.vEICULOAULA;
    data['HORA_AULA'] = this.hORAAULA;
    data['NUMERO_AULA'] = this.nUMEROAULA;
    data['INSTRUTOR_AULA'] = this.iNSTRUTORAULA;
    data['NOME_ALUNO'] = this.nOMEALUNO;
    data['COD_INSTRUTOR'] = this.cODINSTRUTOR;
    return data;
  }
}
