import 'package:cfc_nova_direcao_campanha/pages/components/header.dart';
import 'package:cfc_nova_direcao_campanha/pages/aluno/exames/direcao.dart';
import 'package:cfc_nova_direcao_campanha/pages/aluno/exames/legislacao.dart';
import 'package:flutter/material.dart';

class ExamesPages extends StatefulWidget {
  final String cpf;
  ExamesPages(this.cpf);
  @override
  _ExamesPagesState createState() => _ExamesPagesState();
}

class _ExamesPagesState extends State<ExamesPages> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _widgetOptions = <Widget>[
      ExamesDirecao(widget.cpf),
      ExamesLegislacao(widget.cpf),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Exames"),
      // ),
      body: ListView(
        children: [
          Header(
            text: "Exames",
          ),
          SizedBox(
            height: 35,
          ),
          SingleChildScrollView(
            child: _widgetOptions.elementAt(_selectedIndex),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Direção'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Legislação'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
