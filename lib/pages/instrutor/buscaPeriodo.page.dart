import 'dart:convert';

import 'package:cfc_nova_direcao_campanha/config.dart';
import 'package:cfc_nova_direcao_campanha/pages/instrutor/result-aulas.page.dart';
import 'package:cfc_nova_direcao_campanha/services/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuscaPeriodoPage extends StatefulWidget {
  final String codInstrutor;
  BuscaPeriodoPage({Key key, this.codInstrutor}) : super(key: key);
  @override
  _BuscaPeriodoPageState createState() => _BuscaPeriodoPageState();
}

class _BuscaPeriodoPageState extends State<BuscaPeriodoPage> {
  String _date1 = "Escolha a data de início";
  String _date2 = "Escolha a data final";
  bool date1Validade = false;
  bool date2Validade = false;
  bool loadingPeriodo = false;
  Config config = new Config();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: 300.0,
        child: Text(
          'Busca por período',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2001),
                    lastDate: DateTime(2030),
                  ).then((date) {
                    setState(() {
                      var dia;
                      var mes;
                      if (date.month <= 9)
                        mes = "0" + date.month.toString();
                      else
                        mes = date.month;
                      if (date.day <= 9)
                        dia = "0" + date.day.toString();
                      else
                        dia = date.day;
                      _date1 = '$dia/$mes/${date.year}';
                      date1Validade = true;
                    });
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  size: 18.0,
                                  color: Colors.black,
                                ),
                                Text(
                                  " $_date1",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Início",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2001),
                    lastDate: DateTime(2030),
                  ).then((date) {
                    setState(() {
                      var dia;
                      var mes;
                      if (date.month <= 9)
                        mes = "0" + date.month.toString();
                      else
                        mes = date.month;
                      if (date.day <= 9)
                        dia = "0" + date.day.toString();
                      else
                        dia = date.day;
                      _date2 = '$dia/$mes/${date.year}';
                      date2Validade = true;
                    });
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  size: 18.0,
                                  color: Colors.black,
                                ),
                                Text(
                                  " $_date2",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Fim",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              SizedBox(
                height: 20.0,
              ),
              ButtonTheme(
                minWidth: 400.0,
                height: 45.0,
                child: RaisedButton(
                  shape: StadiumBorder(),
                  color: config.primary,
                  onPressed: () {
                    if (date2Validade && date1Validade) {
                      if (!dateValidatePeriod()) {
                        _showDialog(
                            'O limite de perído das datas é de 7 dias!');
                      } else {
                        setState(() {
                          loadingPeriodo = true;
                        });
                        ServiceHttp.checkClassesOfDayInstrutor(
                                widget.codInstrutor,
                                "${_date1.split("/")[2]}-${_date1.split("/")[1]}-${_date1.split("/")[0]}",
                                data2:
                                    "${_date2.split("/")[2]}-${_date2.split("/")[1]}-${_date2.split("/")[0]}")
                            .then((res) => _processOfClasses(res));
                      }
                    } else {
                      _showDialog('Selecione as datas!');
                    }
                  },
                  child: !loadingPeriodo
                      ? Text('Buscar aulas de período',
                          style: TextStyle(
                              fontSize: 18, color: config.txtColorButton))
                      : CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(config.txtColorButton),
                        ),
                ),
              )
            ],
          ),
        ),
      )
    ]);
  }

  _processOfClasses(res) {
    var jsonData = jsonDecode(res);
    if (jsonData == "erro") {
      _showDialog('Não há aulas neste período!');
      setState(() {
        loadingPeriodo = false;
      });
    } else if (jsonData == 'net_erro') {
      _showDialog('Erro de conexão!');
      setState(() {
        loadingPeriodo = false;
      });
    } else if (jsonData == 'ok') {
      var date1parsed = formatDate(_date1);
      var date2parsed = formatDate(_date2);
      Navigator.push(
          context,
          MaterialPageRoute<Null>(
            builder: (BuildContext context) {
              return AulasInstrutorPage(
                cpf: widget.codInstrutor,
                data1:
                    "${date1parsed.year}-${date1parsed.month}-${date1parsed.day}",
                data2:
                    "${date2parsed.year}-${date2parsed.month}-${date2parsed.day}",
              );
            },
            fullscreenDialog: true,
          ));
      setState(() {
        loadingPeriodo = false;
      });
    }
  }

  bool dateValidatePeriod() {
    var date1parsed = formatDate(_date1);
    var date2parsed = formatDate(_date2);

    var date1 =
        new DateTime.utc(date1parsed.year, date1parsed.month, date1parsed.day);
    var date2 =
        new DateTime.utc(date2parsed.year, date2parsed.month, date2parsed.day);
    Duration difference = date1.difference(date2);
    var diffDays = difference.inDays;
    if ((diffDays < 0)) diffDays = diffDays * -1;

    if (_date1 == "Escolha a data de início")
      return false;
    else if (_date2 == "Escolha a data final")
      return false;
    else if (diffDays > 7) return false;
    return true;
  }

  DateTime formatDate(String data) {
    var dia = int.parse(data.split("/")[0]);
    var mes = int.parse(data.split("/")[1]);
    var ano = int.parse(data.split("/")[2]);
    var formatedDay;
    var formatedMes;

    if (dia <= 9)
      formatedDay = "0$dia";
    else
      formatedDay = "$dia";

    if (mes <= 9)
      formatedMes = "0$mes";
    else
      formatedMes = "$mes";

    return DateTime.parse("$ano-$formatedMes-$formatedDay");
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
