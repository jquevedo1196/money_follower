import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class BudgetConfigPage extends StatefulWidget {
  static const String id = "budget_config_page";

  const BudgetConfigPage({super.key});

  @override
  _BudgetConfigPageState createState() => _BudgetConfigPageState();
}

class _BudgetConfigPageState extends State<BudgetConfigPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Implement navigation logic based on index
    // You may want to push a new page or perform other actions here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Method to create AppBar
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Presupuesto mensual',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.lightBlue,
    );
  }

  // Method to create body with the DataTable
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: _buildDataTable(),
      ),
    );
  }

  // Method to create DataTable
  DataTable2 _buildDataTable() {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 630,
      columns: _createColumns(),
      rows: _createRows(),
    );
  }

  // Method to define table columns
  List<DataColumn2> _createColumns() {
    return const [
      DataColumn2(label: Text('Nombre'), size: ColumnSize.L),
      DataColumn2(label: Text('Tipo'), size: ColumnSize.L),
      DataColumn2(label: Text('Costo estimado'), numeric: true),
      DataColumn2(label: Text('Costo real'), numeric: true),
      DataColumn2(label: Text('Diferencia'), numeric: true),
    ];
  }

  // Method to define table rows
  List<DataRow> _createRows() {
    // For demo purposes, you can replace this with actual data models
    final budgetItems = List.generate(8, (index) => _createBudgetItem(index));
    return budgetItems;
  }

  // Method to generate a budget item
  DataRow _createBudgetItem(int index) {
    return DataRow(cells: [
      DataCell(Text('A' * (10 - index % 10))),
      DataCell(const Text('Entretenimiento')),
      DataCell(const Text('10.12')),
      DataCell(const Text('10.13')),
      DataCell(const Text('10.14')),
    ]);
  }

  // Method to create the bottom navigation bar
  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Messages',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: Colors.lightBlue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
    );
  }
}