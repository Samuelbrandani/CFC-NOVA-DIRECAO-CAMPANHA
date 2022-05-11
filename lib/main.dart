import 'package:cfc_nova_direcao_campanha/pages/login.page.dart';
import 'package:flutter/material.dart';

import 'config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: config.applicationName,
    theme: ThemeData(primarySwatch: config.primary),
    home: Start(),
    debugShowCheckedModeBanner: false,
  ));
}

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    Config config = new Config();

    return Scaffold(
      bottomSheet: yourWidget(),
      appBar: AppBar(
        elevation: 1,
        title: Text(config.applicationName),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50),
              ),
              Image.asset("assets/images/logo.png"),
              Padding(padding: EdgeInsets.all(10)),
              ButtonTheme(
                minWidth: 400.0,
                height: 45.0,
                child: RaisedButton(
                  shape: StadiumBorder(),
                  color: config.primary,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Login(
                                type: 'aluno',
                              )),
                    );
                  },
                  child: Text(
                    'Login aluno',
                    style: TextStyle(
                      fontSize: 18,
                      color: config.txtColorButton,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(6),
              ),
              ButtonTheme(
                minWidth: 400.0,
                height: 45.0,
                child: RaisedButton(
                  shape: StadiumBorder(),
                  color: config.primary,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Login(
                                type: 'instrutor',
                              )),
                    );
                  },
                  child: Text(
                    'Login instrutor',
                    style: TextStyle(
                      fontSize: 18,
                      color: config.txtColorButton,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget yourWidget() {
  return Container(
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: Text("Desenvolvido por WaySoft LTDA"),
        )
      ],
    ),
  );
}
