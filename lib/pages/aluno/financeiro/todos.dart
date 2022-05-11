import 'package:cfc_nova_direcao_campanha/model/financeiro-aluno.dart';
import 'package:cfc_nova_direcao_campanha/services/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class FinanceiroTodos extends StatefulWidget {
  final String cpf;
  FinanceiroTodos(this.cpf);
  @override
  _FinanceiroTodosState createState() => _FinanceiroTodosState();
}

class _FinanceiroTodosState extends State<FinanceiroTodos> {
  Future<List<FinanceiroAluno>> resultApi;
  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() {
    resultApi = null;
    resultApi = ServiceHttp.financeiroAlunoTodos(widget.cpf);
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
                snapshot.data?.map((item) => _wTodos(item))?.toList() ?? [],
          );
        } else {
          return Center(
            child: Text("Não há dados para serem consultados"),
          );
        }
      },
    );
  }

  Widget _wTodos(FinanceiroAluno financeiro) {
    final formatterValor = new NumberFormat("R\$ ###,###.00", "pt-br");
    String valor = formatterValor.format(double.parse(financeiro.valor));

    final formatterData = new DateFormat('dd/MM/yyyy');
    String dataPagamento = '';
    String dataVencimento = '';
    if (financeiro.dataPagamento != null)
      dataPagamento = formatterData.format(financeiro.dataPagamento);
    if (financeiro.dataVencimento != null)
      dataVencimento = formatterData.format(financeiro.dataVencimento);

    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: financeiro.statusPagamento == 'S'
                ? Text("Pago")
                : Text(
                    "Não Pago",
                    style: TextStyle(color: Colors.red),
                  ),
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
            child: financeiro.dataPagamento != null
                ? Text(
                    "Data Pagamento: $dataPagamento",
                  )
                : null,
          ),
          Container(
            child: financeiro.codBarra != "" &&
                    financeiro.statusPagamento == "N"
                ? _buttonBoleto(context, financeiro.codBarra)
                : financeiro.codBarra == "" && financeiro.statusPagamento == "N"
                    ? Text("Código do boleto indisponível")
                    : null,
          ),
        ],
      ),
    );
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
