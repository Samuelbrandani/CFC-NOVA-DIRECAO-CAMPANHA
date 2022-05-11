import 'dart:convert';

List<ExameDirecao> exameDirecaoFromJson(String str) {
  if (str != null)
    return List<ExameDirecao>.from(
        json.decode(str).map((x) => ExameDirecao.fromJson(x)));
  else
    return null;
}

String exameDirecaoToJson(List<ExameDirecao> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExameDirecao {
  ExameDirecao({
    this.id,
    this.codAluno,
    this.categExame,
    this.obs,
    this.data2,
    this.hora,
    this.tipoExame,
    this.aprovado,
    this.pontuacao,
    this.categoria,
    this.veiculo,
    this.instrutor,
    this.codExame,
  });

  String id;
  String codAluno;
  String categExame;
  String obs;
  DateTime data2;
  String hora;
  String tipoExame;
  String aprovado;
  String pontuacao;
  String categoria;
  String veiculo;
  String instrutor;
  String codExame;

  factory ExameDirecao.fromJson(Map<String, dynamic> json) => ExameDirecao(
        id: json["ID"] == null ? null : json["ID"],
        codAluno: json["COD_ALUNO"] == null ? null : json["COD_ALUNO"],
        categExame: json["CATEG_EXAME"] == null ? null : json["CATEG_EXAME"],
        obs: json["OBS"] == null ? null : json["OBS"],
        data2: json["DATA_2"] == null ? null : DateTime.parse(json["DATA_2"]),
        hora: json["HORA"] == null ? null : json["HORA"],
        tipoExame: json["TIPO_EXAME"] == null ? null : json["TIPO_EXAME"],
        aprovado: json["APROVADO"] == null ? null : json["APROVADO"],
        pontuacao: json["PONTUACAO"] == null ? null : json["PONTUACAO"],
        categoria: json["CATEGORIA"] == null ? null : json["CATEGORIA"],
        veiculo: json["VEICULO"] == null ? null : json["VEICULO"],
        instrutor: json["INSTRUTOR"] == null ? null : json["INSTRUTOR"],
        codExame: json["COD_EXAME"] == null ? null : json["COD_EXAME"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id == null ? null : id,
        "COD_ALUNO": codAluno == null ? null : codAluno,
        "CATEG_EXAME": categExame == null ? null : categExame,
        "OBS": obs == null ? null : obs,
        "DATA_2": data2 == null
            ? null
            : "${data2.year.toString().padLeft(4, '0')}-${data2.month.toString().padLeft(2, '0')}-${data2.day.toString().padLeft(2, '0')}",
        "HORA": hora == null ? null : hora,
        "TIPO_EXAME": tipoExame == null ? null : tipoExame,
        "APROVADO": aprovado == null ? null : aprovado,
        "PONTUACAO": pontuacao == null ? null : pontuacao,
        "CATEGORIA": categoria == null ? null : categoria,
        "VEICULO": veiculo == null ? null : veiculo,
        "INSTRUTOR": instrutor == null ? null : instrutor,
        "COD_EXAME": codExame == null ? null : codExame,
      };
}
