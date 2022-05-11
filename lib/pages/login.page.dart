import 'dart:convert';

import 'package:cfc_nova_direcao_campanha/config.dart';
import 'package:cfc_nova_direcao_campanha/main.dart';
import 'package:cfc_nova_direcao_campanha/pages/aluno/aluno.page.dart';
import 'package:cfc_nova_direcao_campanha/services/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'instrutor/instrutor.page.dart';

class Login extends StatefulWidget {
  final String type;
  Login({Key key, this.type}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

Config config = new Config();
bool loading = false;

class _LoginState extends State<Login> {
  ServiceHttp loginService = new ServiceHttp();
  TextEditingController cpf = TextEditingController();
  TextEditingController senha = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.type == 'aluno') {
      _setValuesAluno();
    } else {
      _setValuesinstrutor();
    }
  }

  _setValuesAluno() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cpf.text = prefs.get('cpf_aluno');
    senha.text = prefs.get('senha_aluno');
  }

  _setValuesinstrutor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cpf.text = prefs.get('cpf_instrutor');
    senha.text = prefs.get('senha_instrutor');
  }

  _validateLogin(res) async {
    var jsonData = jsonDecode(res);

    if (jsonData == "erro") {
      _showDialog('Usuário ou senha incorretos, tente novamente!');
      setState(() {
        loading = false;
      });
    } else if (jsonData == 'net_erro') {
      _showDialog('Erro de conexão!');
      setState(() {
        loading = false;
      });
    } else {
      if (widget.type == 'aluno') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('cpf_aluno', cpf.text);
        prefs.setString('senha_aluno', senha.text);

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AlunoPage(
                    codAluno: jsonData[0]['COD_ALUNO'],
                    nomeAluno: jsonData[0]['NOME_ALUNO'].split(" ")[0],
                  )),
        );
        setState(() {
          loading = false;
        });
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('cpf_instrutor', cpf.text);
        prefs.setString('senha_instrutor', senha.text);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InstrutorMainPage(
                  codInstrutor: jsonData[0]['COD_INSTRUTOR'],
                  nomeInstrutor: jsonData[0]['NOME_INSTRUTOR'].split(" ")[0])),
        );
        setState(() {
          loading = false;
        });
      }
    }
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Column(children: <Widget>[
              Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 40, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Start()));
                        },
                      ),
                      Container(
                        width: 300.0,
                        child: Text(
                          'Login ${widget.type}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: cpf,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'CPF',
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    TextFormField(
                      controller: senha,
                      decoration: const InputDecoration(
                        hintText: 'Senha',
                      ),
                      obscureText: true,
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    _buildLogginButton()
                  ],
                ),
              ),
            ]),
          ],
        )),
      ),
    );
  }

  Widget _buildLogginButton() {
    if (loading)
      return ButtonTheme(
        minWidth: 200.0,
        height: 45.0,
        child: RaisedButton(
          shape: StadiumBorder(),
          color: config.primary,
          onPressed: () async {},
          child: Text('Aguarde...',
              style: TextStyle(fontSize: 18, color: config.txtColorButton)),
        ),
      );
    else
      return ButtonTheme(
        minWidth: 200.0,
        height: 45.0,
        child: RaisedButton(
          shape: StadiumBorder(),
          color: config.primary,
          onPressed: () async {
            // verifica se o usuário preencheu os campos
            if (cpf.text == '' || senha.text == '') {
              _showDialog('Preencha todos campos!');
            } else {
              setState(() {
                loading = true;
              });
              if (widget.type == 'aluno') {
                loginService
                    .loginAluno(cpf.text, senha.text)
                    .then((res) => _validateLogin(res));
              } else {
                loginService
                    .loginInstrutor(cpf.text, senha.text)
                    .then((res) => _validateLogin(res));
              }
            }
          },
          child: Text('Entrar',
              style: TextStyle(fontSize: 18, color: config.txtColorButton)),
        ),
      );
  }
}
