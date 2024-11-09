import 'package:flutter/material.dart';
import 'package:money_follower/data/payments_data.dart';
import 'package:money_follower/models/payments_model.dart';
import 'package:money_follower/pages/recurring_movements_page/add_recurring_movement_page.dart';
import 'widgets/recurring_movements_card.dart';

class RecurringMovementsPage extends StatefulWidget {
  static const String id = "recurring_movements_page";

  const RecurringMovementsPage({super.key});

  @override
  State<RecurringMovementsPage> createState() => _RecurringMovementsPageState();
}

class _RecurringMovementsPageState extends State<RecurringMovementsPage> {
  List<PaymentModel> _payments = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<PaymentModel>> _allPayments() async {
    _payments = await PaymentsData().getAllPayments();
    print(_payments);
    return _payments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movimientos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        color: Colors.lightBlue,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: FutureBuilder<List<PaymentModel>>(
            future: _allPayments(),
            builder: (BuildContext context,
                AsyncSnapshot<List<PaymentModel>> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                return ListView(children: movements(payments: snapshot.data!));
              } else if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                ];
              } else {
                children = const <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  ),
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          Navigator.pushNamed(context, AddRecurringMovementPage.id);
        },
        tooltip: 'Agregar movimiento recurrente',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

List<RecurringMovementsCard> movements({required List<PaymentModel> payments}) {
  List<RecurringMovementsCard> cards = [];

  for (PaymentModel payment in payments) {
    cards.add(RecurringMovementsCard(
        title: payment.name,
        desc: payment.frequencyType.label,
        icon: payment.movementType.icon,
        savingType: payment.movementType.name,
        amount: payment.amount));
  }

  return cards;
}
