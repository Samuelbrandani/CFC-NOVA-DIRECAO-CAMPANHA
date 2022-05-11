import 'dart:convert';

List<FinanceiroAluno> financeiroAlunoFromJson(String str) {
  if (str != null)
    return List<FinanceiroAluno>.from(
        json.decode(str).map((x) => FinanceiroAluno.fromJson(x)));
  else
    return null;
}

String financeiroAlunoToJson(List<FinanceiroAluno> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FinanceiroAluno {
  String dataError;

  FinanceiroAluno.dataTransform(Map<String, dynamic> json) {
    dataError = json['data'];
  }

  FinanceiroAluno({
    this.idFinanca,
    this.codAluno,
    this.descricaoCompra,
    this.valor,
    this.dataPagamento,
    this.dataVencimento,
    this.valorPago,
    this.restante,
    this.formaPagamento,
    this.statusPagamento,
    this.numeroParcela,
    this.nossoNum,
    this.numDoc,
    this.codCedente,
    this.codBarra,
  });

  String idFinanca;
  String codAluno;
  String descricaoCompra;
  String valor;
  DateTime dataPagamento;
  DateTime dataVencimento;
  String valorPago;
  String restante;
  String formaPagamento;
  String statusPagamento;
  String numeroParcela;
  String nossoNum;
  String numDoc;
  String codCedente;
  dynamic codBarra;

  factory FinanceiroAluno.fromJson(Map<String, dynamic> json) =>
      FinanceiroAluno(
        idFinanca: json["ID_FINANCA"] == null ? null : json["ID_FINANCA"],
        codAluno: json["COD_ALUNO"] == null ? null : json["COD_ALUNO"],
        descricaoCompra:
            json["DESCRICAO_COMPRA"] == null ? null : json["DESCRICAO_COMPRA"],
        valor: json["VALOR"] == null ? null : json["VALOR"],
        dataPagamento: json["DATA_PAGAMENTO"] == null
            ? null
            : DateTime.parse(json["DATA_PAGAMENTO"]),
        dataVencimento: json["DATA_VENCIMENTO"] == null
            ? null
            : DateTime.parse(json["DATA_VENCIMENTO"]),
        valorPago: json["VALOR_PAGO"] == null ? null : json["VALOR_PAGO"],
        restante: json["RESTANTE"] == null ? null : json["RESTANTE"],
        formaPagamento:
            json["FORMA_PAGAMENTO"] == null ? null : json["FORMA_PAGAMENTO"],
        statusPagamento:
            json["STATUS_PAGAMENTO"] == null ? null : json["STATUS_PAGAMENTO"],
        numeroParcela:
            json["NUMERO_PARCELA"] == null ? null : json["NUMERO_PARCELA"],
        nossoNum: json["NOSSO_NUM"] == null ? null : json["NOSSO_NUM"],
        numDoc: json["NUM_DOC"] == null ? null : json["NUM_DOC"],
        codCedente: json["COD_CEDENTE"] == null ? null : json["COD_CEDENTE"],
        codBarra: json["COD_BARRA"],
      );

  Map<String, dynamic> toJson() => {
        "ID_FINANCA": idFinanca == null ? null : idFinanca,
        "COD_ALUNO": codAluno == null ? null : codAluno,
        "DESCRICAO_COMPRA": descricaoCompra == null ? null : descricaoCompra,
        "VALOR": valor == null ? null : valor,
        "DATA_PAGAMENTO": dataPagamento == null ? null : dataPagamento,
        "DATA_VENCIMENTO": dataVencimento == null ? null : dataVencimento,
        "VALOR_PAGO": valorPago == null ? null : valorPago,
        "RESTANTE": restante == null ? null : restante,
        "FORMA_PAGAMENTO": formaPagamento == null ? null : formaPagamento,
        "STATUS_PAGAMENTO": statusPagamento == null ? null : statusPagamento,
        "NUMERO_PARCELA": numeroParcela == null ? null : numeroParcela,
        "NOSSO_NUM": nossoNum == null ? null : nossoNum,
        "NUM_DOC": numDoc == null ? null : numDoc,
        "COD_CEDENTE": codCedente == null ? null : codCedente,
        "COD_BARRA": codBarra,
      };
}
