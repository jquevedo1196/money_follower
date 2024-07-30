import 'package:money_follower/enums/recurring_movement_type.dart';
import '../enums/frequency_type.dart';

class Payment {
  final int id;
  final MovementType movementType;
  final String name;
  final double amount;
  final FrequencyType frequencyType;

  const Payment({
    required this.id,
    required this.movementType,
    required this.name,
    required this.amount,
    required this.frequencyType,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
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
