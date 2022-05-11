import 'package:cfc_nova_direcao_campanha/pages/aluno/aulas.page.dart';
import 'package:cfc_nova_direcao_campanha/pages/aluno/exames.page.dart';
import 'package:cfc_nova_direcao_campanha/pages/aluno/financeiro.page.dart';
import 'package:cfc_nova_direcao_campanha/pages/components/header.dart';
import 'package:cfc_nova_direcao_campanha/services/service.dart';
import 'package:flutter/material.dart';

import '../../config.dart';

class AlunoPage extends StatefulWidget {
  final String codAluno;
  final String nomeAluno;
  AlunoPage({Key key, this.codAluno, this.nomeAluno}) : super(key: key);
  @override
  _AlunoPageState createState() => _AlunoPageState();
}

ServiceHttp service = new ServiceHttp();

class _AlunoPageState extends State<AlunoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Bem vindo ${widget.nomeAluno}"),
      // ),
      body: SafeArea(
          child: ListView(
        children: [
          Header(
            text: "Bem vindo ${widget.nomeAluno}",
          ),
          SizedBox(
            height: 35,
          ),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Selecione uma das opções para consulta"),
                SizedBox(
                  height: 50,
                ),
                _button("Aulas"),
                _button("Exames"),
                _button("Financeiro"),
              ],
            ),
          )
        ],
      )),
    );
  }

  Widget _button(String text) {
    Config config = new Config();
    return SizedBox(
      width: 300,
      child: RaisedButton(
        textColor: config.txtColorButton,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Theme.of(context).primaryColor,
        child: Text(text),
        onPressed: () {
          if (text == 'Financeiro') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FinanceiroPage(cpf: widget.codAluno)),
            );
          } else if (text == 'Aulas') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AulasPages(widget.codAluno)),
            );
          } else if (text == 'Exames') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ExamesPages(widget.codAluno)),
            );
          }
        },
      ),
    );
  }
}
