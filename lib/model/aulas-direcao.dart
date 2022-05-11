import 'dart:convert';

List<AulasDirecao> aulasDirecaoFromJson(String str) {
  if (str != null)
    return List<AulasDirecao>.from(
        json.decode(str).map((x) => AulasDirecao.fromJson(x)));
  else
    return null;
}

String aulasDirecaoToJson(List<AulasDirecao> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AulasDirecao {
  String dataError;
  AulasDirecao.dataTransform(Map<String, dynamic> json) {
    dataError = json['data'];
  }

  AulasDirecao({
    this.id,
    this.codAluno,
    this.veiculo,
    this.numeroAula,
    this.data,
    this.hora,
    this.obs,
    this.instrutor,
  });

  String id;
  String codAluno;
  String veiculo;
  String numeroAula;
  DateTime data;
  String hora;
  String obs;
  String instrutor;

  factory AulasDirecao.fromJson(Map<String, dynamic> json) => AulasDirecao(
        id: json["ID"] == null ? null : json["ID"],
        codAluno: json["COD_ALUNO"] == null ? null : json["COD_ALUNO"],
        veiculo: json["VEICULO"] == null ? null : json["VEICULO"],
        numeroAula: json["NUMERO_AULA"] == null ? null : json["NUMERO_AULA"],
        data: json["DATA"] == null ? null : DateTime.parse(json["DATA"]),
        hora: json["HORA"] == null ? null : json["HORA"],
        obs: json["OBS"] == null ? null : json["OBS"],
        instrutor: json["INSTRUTOR"] == null ? null : json["INSTRUTOR"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id == null ? null : id,
        "COD_ALUNO": codAluno == null ? null : codAluno,
        "VEICULO": veiculo == null ? null : veiculo,
        "NUMERO_AULA": numeroAula == null ? null : numeroAula,
        "DATA": data == null
            ? null
            : "${data.day.toString().padLeft(2, '0')}-${data.month.toString().padLeft(2, '0')}-${data.year.toString().padLeft(4, '0')}",
        "HORA": hora == null ? null : hora,
        "OBS": obs == null ? null : obs,
        "INSTRUTOR": instrutor == null ? null : instrutor,
      };
}
