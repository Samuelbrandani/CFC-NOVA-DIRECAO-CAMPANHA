import 'package:cfc_nova_direcao_campanha/model/financeiro-aluno.dart';
import 'package:cfc_nova_direcao_campanha/services/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class FinanceiroAPagar extends StatefulWidget {
  final String cpf;
  FinanceiroAPagar(this.cpf);
  @override
  _FinanceiroAPagarState createState() => _FinanceiroAPagarState();
}

class _FinanceiroAPagarState extends State<FinanceiroAPagar> {
  Future<List<FinanceiroAluno>> resultApi;
  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() {
    resultApi = null;
    resultApi = ServiceHttp.financeiroAlunoAPagar(widget.cpf);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FinanceiroAluno>>(
      future: resultApi,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Container(
            padding: EdgeInsets.only(top: 15),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.data.isEmpty) {
          return Padding(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Text("Não há dados para serem consultados"),
            ),
          );
        }
        if (snapshot.hasData) {
          return Column(
            children:
                snapshot.data?.map((item) => _wApagar(item))?.toList() ?? [],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _wApagar(FinanceiroAluno financeiro) {
    final formatterData = new DateFormat('dd/MM/yyyy');
    String dataVencimento = formatterData.format(financeiro.dataVencimento);

    final formatterValor = new NumberFormat("R\$ ###,###.00", "pt-br");
    String valor = formatterValor.format(double.parse(financeiro.valor));

    return Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Não Pago",
              style: TextStyle(color: Colors.red),
            ),
            Text(
              "${financeiro.descricaoCompra}",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Valor: $valor",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              child: financeiro.dataVencimento != null
                  ? Text(
                      "Data Vencimento: $dataVencimento",
                    )
                  : null,
            ),
            Container(
              child:
                  financeiro.codBarra != "" && financeiro.statusPagamento == "N"
                      ? _buttonBoleto(context, financeiro.codBarra)
                      : financeiro.codBarra == "" &&
                              financeiro.statusPagamento == "N"
                          ? Text("Código do boleto indisponível")
                          : Container(),
            ),
            Container(),
          ],
        ));
  }
}

Widget _buttonBoleto(context, codBarra) {
  return RaisedButton(
    child: Text("Boleto bancário"),
    color: Theme.of(context).primaryColor,
    textColor: Colors.black,
    onPressed: () {
      Fluttertoast.showToast(
          msg:
              "Código de barras do boleto copiado para a Área de Transferência!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black54,
          textColor: Colors.black,
          fontSize: 16.0);
      Clipboard.setData(new ClipboardData(text: codBarra));
    },
  );
}
