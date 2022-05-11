import 'dart:convert';

import 'package:cfc_nova_direcao_campanha/config.dart';
import 'package:cfc_nova_direcao_campanha/pages/instrutor/result-aulas.page.dart';
import 'package:cfc_nova_direcao_campanha/services/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuscaDiaPage extends StatefulWidget {
  final String codInstrutor;
  BuscaDiaPage({Key key, this.codInstrutor}) : super(key: key);
  @override
  _BuscaDiaPageState createState() => _BuscaDiaPageState();
}

Config config = new Config();
bool loadingDia = false;
var thisInstant = new DateTime.now();
var date = "${thisInstant.year}-${thisInstant.month}-${thisInstant.day}";

class _BuscaDiaPageState extends State<BuscaDiaPage> {
  _processOfClasses(res) {
    var jsonData = jsonDecode(res);
    if (jsonData == "erro") {
      _showDialog('Não há aulas!');
      setState(() {
        loadingDia = false;
      });
    } else if (jsonData == 'net_erro') {
      _showDialog('Erro de conexão!');
      setState(() {
        loadingDia = false;
      });
    } else if (jsonData == 'ok') {
      Navigator.push(
          context,
          MaterialPageRoute<Null>(
            builder: (BuildContext context) {
              return AulasInstrutorPage(
                cpf: widget.codInstrutor,
                data1: date,
                data2: null,
              );
            },
            fullscreenDialog: true,
          ));
      setState(() {
        loadingDia = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 300.0,
          child: Text(
            'Busca rápida',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: ButtonTheme(
            minWidth: 400.0,
            height: 45.0,
            child: RaisedButton(
              shape: StadiumBorder(),
              color: config.primary,
              onPressed: () {
                loadingDia = true;
                ServiceHttp.checkClassesOfDayInstrutor(
                        widget.codInstrutor, date)
                    .then((res) => _processOfClasses(res));
              },
              child: !loadingDia
                  ? Text('Buscar aulas de hoje',
                      style:
                          TextStyle(fontSize: 18, color: config.txtColorButton))
                  : CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          config.txtColorButton)),
            ),
          ),
        ),
      ],
    );
  }

  void showDemoDialog({BuildContext context, Widget child}) {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => child,
    );
  }

  dynamic _loadingButtom = Text('Ok');
  void _showDialog(String _text) {
    showDemoDialog(
      context: context,
      child: CupertinoAlertDialog(
        title: Text(_text),
        actions: <Widget>[
          CupertinoDialogAction(
            child: _loadingButtom,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
