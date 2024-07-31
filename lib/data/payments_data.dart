import 'package:money_follower/enums/frequency_type.dart';
import 'package:money_follower/enums/recurring_movement_type.dart';
import 'package:sqflite/sqflite.dart';
import '../models/payments_model.dart';

class PaymentsData {
  Future<void> insertPayment(PaymentModel payment) async {
    final db = await openDatabase('money_follower.db');
    await db.insert(
      'payments',
      payment.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    db.close();
  }

  Future<void> deletePayment() async {

    final db = await openDatabase('money_follower.db');

    await db.delete(
      'payments'
    );
  }

  Future<void> generateDemoData() async {

    final db = await openDatabase('money_follower.db');

    await db.delete(
        'payments'
    );
  }

  Future<List<PaymentModel>> getAllPayments() async {
    final db = await openDatabase('money_follower.db');
    final List<Map<String, Object?>> paymentsMaps = await db.query('payments');
    List<PaymentModel> allPayments = [];
    for (final {
          'id': id as int,
          'name': name as String,
          'amount': amount as num,
          'frequencyType': frequencyType as String,
          'movementType': movementType as String,
        } in paymentsMaps) {
      FrequencyType.values.toString();
      MovementType.values.toString();
      allPayments.add(PaymentModel(
          id: id,
          name: name,
          amount: amount,
          frequencyType: FrequencyType.values.firstWhere(
              (value) => value.toString() == 'FrequencyType.$frequencyType'),
          movementType: MovementType.values.firstWhere(
              (value) => value.toString() == 'MovementType.$movementType')));
    }
    db.close();
    return allPayments;
  }
}
