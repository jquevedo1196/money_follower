import 'package:money_follower/enums/recurring_movement_type.dart';
import '../enums/frequency_type.dart';

class PaymentModel {
  final int id;
  final MovementType movementType;
  final String name;
  final num amount;
  final FrequencyType frequencyType;

  const PaymentModel({
    required this.id,
    required this.movementType,
    required this.name,
    required this.amount,
    required this.frequencyType,
  });

  Map<String, Object?> toMap() {
    return {
      'movementType': movementType.name,
      'name': name,
      'amount': amount,
      'frequencyType': frequencyType.name,
    };
  }

  @override
  String toString() {
    return 'Payment{id: $id, movementType: $movementType, name: $name, amount: $amount, frequencyType: $frequencyType}';
  }
}
