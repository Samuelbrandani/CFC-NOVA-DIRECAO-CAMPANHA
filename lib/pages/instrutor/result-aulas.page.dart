import 'package:cfc_nova_direcao_campanha/pages/components/header.dart';
import 'package:cfc_nova_direcao_campanha/services/service.dart';
import 'package:flutter/material.dart';
import 'package:cfc_nova_direcao_campanha/model/instrutor.dart';

class AulasInstrutorPage extends StatefulWidget {
  final String cpf;
  final String data1;
  final String data2;

  AulasInstrutorPage({Key key, this.cpf, this.data1, this.data2})
      : super(key: key);
  @override
  _AulasInstrutorPageState createState() => _AulasInstrutorPageState();
}

class _AulasInstrutorPageState extends State<AulasInstrutorPage> {
  static Future<List<AulasInstrutor>> resultApi;
  var _dateFormated1;
  var _dateFormated2;

  void initState() {
    super.initState();
    _initedState();
  }

  _initedState() {
    setState(() {
      resultApi =
          ServiceHttp.fetchPosts(widget.cpf, widget.data1, widget.data2);
      _dateFormated1 = widget.data1.split("-");
      if (_dateFormated1[1].length == 1)
        _dateFormated1[1] = "0" + _dateFormated1[1];

      if (widget.data2 != null) {
        _dateFormated2 = widget.data2.split('-');
        if (_dateFormated2[1].length == 1)
          _dateFormated2[1] = "0" + _dateFormated2[1];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Header(
              text:
                  widget.data2 == null ? "Aulas do dia" : "Aulas por período"),
          Center(
              child: Padding(
            padding: EdgeInsets.all(10),
            child: widget.data2 == null
                ? Text(
                    "${_dateFormated1[2]}/${_dateFormated1[1]}/${_dateFormated1[0]}",
                    style: TextStyle(fontSize: 20),
                  )
                : Text(
                    "${_dateFormated1[2]}/${_dateFormated1[1]}/${_dateFormated1[0]} - ${_dateFormated2[2]}/${_dateFormated2[1]}/${_dateFormated2[0]}",
                    style: TextStyle(fontSize: 20)),
          )),
          FutureBuilder<List<AulasInstrutor>>(
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
                            ?.map((item) => _buildItemAula(item))
                            ?.toList() ??
                        []);
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildItemAula(AulasInstrutor aula) {
    var dt = aula.dATAAULA.split("-");
    return Column(
      children: <Widget>[
        ListTile(
          leading: null,
          title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${dt[2]}/${dt[1]} às ${aula.hORAAULA}",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Aluno: ${aula.nOMEALUNO}",
                  style: TextStyle(fontSize: 20),
                ),
              ]),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              aula.nUMEROAULA != ''
                  ? Text("N° aula: ${aula.nUMEROAULA}")
                  : Container(),
              aula.vEICULOAULA != ''
                  ? Text("Veículo: ${aula.vEICULOAULA}")
                  : Container(),
              Divider()
            ],
          ),
        )
      ],
    );
  }
}
