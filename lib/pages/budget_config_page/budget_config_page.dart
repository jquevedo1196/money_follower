import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class BudgetConfigPage extends StatelessWidget {
  static const String id = "budget_config_page";

  const BudgetConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Presupuesto mensual',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.lightBlue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 630,
                columns: const [
                  DataColumn2(
                    label: Text('Nombre'),
                    size: ColumnSize.L,
                  ),
                  DataColumn2(label: Text('Tipo'), size: ColumnSize.L),
                  DataColumn2(label: Text('Costo estimado'), numeric: true),
                  DataColumn2(label: Text('Costo real'), numeric: true),
                  DataColumn2(label: Text('Diferencia'), numeric: true),
                ],
                rows: List<DataRow>.generate(
                    100,
                    (index) => DataRow(cells: [
                          DataCell(Text('A' * (10 - index % 10))),
                          DataCell(Text('Entretenimiento')),
                          DataCell(Text('10.12')),
                          DataCell(Text('10.13')),
                          DataCell(Text('10.14')),
                        ]))),
          ),
        ));
  }
}
