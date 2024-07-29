import 'dart:ffi';
import 'package:money_follower/enums/recurring_movement_type.dart';
import '../enums/frequency_type.dart';

class Payment {
  final Int id;
  final MovementType movementType;
  final String name;
  final Double amount;
  final FrequencyType frequencyType;

  const Payment({
    required this.id,
    required this.movementType,
    required this.name,
    required this.amount,
    required this.frequencyType,
  });
}