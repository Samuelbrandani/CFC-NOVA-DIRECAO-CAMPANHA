import 'package:cfc_nova_direcao_campanha/model/financeiro-aluno.dart';
import 'package:cfc_nova_direcao_campanha/services/service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FinanceiroPagos extends StatefulWidget {
  final String cpf;
  FinanceiroPagos(this.cpf);
  @override
  _FinanceiroPagosState createState() => _FinanceiroPagosState();
}

class _FinanceiroPagosState extends State<FinanceiroPagos> {
  Future<List<FinanceiroAluno>> resultApi;
  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() {
    resultApi = ServiceHttp.financeiroAlunoPagos(widget.cpf);
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
                snapshot.data?.map((item) => _wPagos(item))?.toList() ?? [],
          );
        } else {
          return Center(
            child: Text("Não há dados para serem consultados"),
          );
        }
      },
    );
  }

  Widget _wPagos(FinanceiroAluno financeiro) {
    final formatterValor = new NumberFormat("R\$ ###,###.00", "pt-br");
    String valor = formatterValor.format(double.parse(financeiro.valor));

    final formatterData = new DateFormat('dd/MM/yyyy');
    String dataPagamento = formatterData.format(financeiro.dataPagamento);
    String dataVencimento = formatterData.format(financeiro.dataVencimento);

    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
          child: financeiro.statusPagamento == 'S'
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Pago"),
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
                    Container(),
                  ],
                )
              : null),
    );
  }
}
