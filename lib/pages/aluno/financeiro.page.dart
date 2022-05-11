import 'package:cfc_nova_direcao_campanha/pages/components/header.dart';
import 'package:cfc_nova_direcao_campanha/pages/aluno/financeiro/apagar.dart';
import 'package:cfc_nova_direcao_campanha/pages/aluno/financeiro/pagos.dart';
import 'package:cfc_nova_direcao_campanha/pages/aluno/financeiro/todos.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FinanceiroPage extends StatefulWidget {
  final String cpf;
  FinanceiroPage({Key key, this.cpf}) : super(key: key);
  @override
  _FinanceiroPageState createState() => _FinanceiroPageState();
}

final formatter = new NumberFormat("R\$ ###,###.00", "pt-br");

class _FinanceiroPageState extends State<FinanceiroPage> {
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
      FinanceiroAPagar(widget.cpf),
      FinanceiroPagos(widget.cpf),
      FinanceiroTodos(widget.cpf),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Financeiro"),
      // ),
      body: ListView(
        children: [
          Header(
            text: "Financeiro",
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
            icon: Icon(Icons.business),
            title: Text('A Pagar'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Pagos'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Todos'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
