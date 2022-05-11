import 'package:cfc_nova_direcao_campanha/pages/components/header.dart';
import 'package:cfc_nova_direcao_campanha/pages/instrutor/buscaPeriodo.page.dart';
import 'package:cfc_nova_direcao_campanha/pages/instrutor/busca_dia.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InstrutorMainPage extends StatefulWidget {
  final String codInstrutor;
  final String nomeInstrutor;

  InstrutorMainPage({Key key, this.codInstrutor, this.nomeInstrutor})
      : super(key: key);
  @override
  _InstrutorMainPageState createState() => _InstrutorMainPageState();
}

class _InstrutorMainPageState extends State<InstrutorMainPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            Header(
              text: "Bem vindo ${widget.nomeInstrutor}",
            ),
            SizedBox(
              height: 20,
            ),
            BuscaDiaPage(
              codInstrutor: widget.codInstrutor,
            ),
            Padding(
              padding: EdgeInsets.only(top: 25),
            ),
            BuscaPeriodoPage(
              codInstrutor: widget.codInstrutor,
            )
          ],
        ),
      ),
    );
  }
}
