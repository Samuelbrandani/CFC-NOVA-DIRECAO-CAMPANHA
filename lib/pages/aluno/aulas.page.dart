import 'package:cfc_nova_direcao_campanha/model/aulas-direcao.dart';
import 'package:cfc_nova_direcao_campanha/pages/components/header.dart';
import 'package:cfc_nova_direcao_campanha/services/service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AulasPages extends StatefulWidget {
  final String cpf;
  AulasPages(this.cpf);
  @override
  _AulasPagesState createState() => _AulasPagesState();
}

class _AulasPagesState extends State<AulasPages> {
  static Future<List<AulasDirecao>> _resultAulasDirecao;
  @override
  void initState() {
    _resultAulasDirecao = ServiceHttp.aulasDirecaoAluno(widget.cpf);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Header(
            text: "Aulas de direção",
          ),
          SizedBox(
            height: 35,
          ),
          SingleChildScrollView(
            child: Container(
              child: FutureBuilder<List<AulasDirecao>>(
                future: _resultAulasDirecao,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return Column(
                      children: snapshot.data
                              ?.map((item) => _buildItemAula(item))
                              ?.toList() ??
                          [],
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItemAula(AulasDirecao aula) {
    final formatter = new DateFormat('dd/MM/yyyy');
    String data = formatter.format(aula.data);
    aula.instrutor = aula.instrutor.split(" ")[0];
    return Column(
      children: <Widget>[
        ListTile(
          title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "${aula.hora}",
                  style: TextStyle(fontSize: 20),
                )
              ]),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("N° aula: ${aula.numeroAula}"),
              Text("Instrutor: ${aula.instrutor}"),
              Divider()
            ],
          ),
        )
      ],
    );
  }
}
