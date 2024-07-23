import 'package:flutter/material.dart';
import 'package:money_follower/pages/add_recurring_movement_page.dart';

import '../widgets/recurring_movements_card.dart';

class RecurringMovements extends StatelessWidget {
  static const String id = "recurring_movements_page";
  const RecurringMovements({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movimientos recurrentes'),
      ),
      body: ListView(
        children: const [
          RecurringMovementsCard(
              title: "Sueldo",
              desc: "Pago quincenal",
              icon: Icons.savings,
              savingType: "income",
              amount: 90000.50),
          RecurringMovementsCard(
            title: "Renta",
            desc: "Pago mensual",
            icon: Icons.payments,
            savingType: "outbound",
            amount: 15000.00,
          ),
          RecurringMovementsCard(
            title: "Mensualidad Casa",
            desc: "Pago mensual",
            icon: Icons.payments,
            savingType: "outbound",
            amount: 11000.25,
          ),
          RecurringMovementsCard(
            title: "Mensualidad Carro",
            desc: "Pago mensual",
            icon: Icons.payments,
            savingType: "outbound",
            amount: 10000.15,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          Navigator.pushNamed(context, AddRecurringMovementPage.id);
        },
        tooltip: 'Agregar movimiento recurrente',
        child: const Icon(Icons.add),
      ),
    );
  }
}
