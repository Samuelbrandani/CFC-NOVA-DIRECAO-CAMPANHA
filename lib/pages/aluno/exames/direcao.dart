import 'package:cfc_nova_direcao_campanha/model/exame-direcao.dart';
import 'package:cfc_nova_direcao_campanha/services/service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExamesDirecao extends StatefulWidget {
  final String cpf;
  ExamesDirecao(this.cpf);
  @override
  _ExamesDirecaoState createState() => _ExamesDirecaoState();
}

class _ExamesDirecaoState extends State<ExamesDirecao> {
  Future<List<ExameDirecao>> resultApi;
  @override
  void initState() {
    setData();
    super.initState();
  }

  setData() {
    resultApi = ServiceHttp.examesDirecaoAluno(widget.cpf);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ExameDirecao>>(
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
            children: snapshot.data
                    ?.map((item) => _buildItemExamesDirecao(item))
                    ?.toList() ??
                [],
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget _buildItemExamesDirecao(ExameDirecao direcao) {
    final formatterData = new DateFormat('dd/MM/yyyy');
    String data = formatterData.format(direcao.data2);

    return Column(
      children: <Widget>[
        ListTile(
          leading: null,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                data,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "Tipo: Direção",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "Categoria: ${direcao.categoria}",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Aprovado: ${direcao.aprovado}",
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              Divider()
            ],
          ),
        )
      ],
    );
  }
}
