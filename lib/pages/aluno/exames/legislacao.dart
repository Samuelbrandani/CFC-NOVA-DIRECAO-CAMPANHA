import 'package:flutter/material.dart';

class ExamesLegislacao extends StatefulWidget {
  final String cpf;
  ExamesLegislacao(this.cpf);
  @override
  _ExamesLegislacaoState createState() => _ExamesLegislacaoState();
}

class _ExamesLegislacaoState extends State<ExamesLegislacao> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Center(
        child: Text("Não há itens a serem consultados"),
      ),
      padding: EdgeInsets.all(15),
    );
  }
}
