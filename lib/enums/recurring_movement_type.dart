import 'package:flutter/material.dart';


enum MovementType {
  income('Ingreso', Icons.savings),
  outbound('Gasto', Icons.payments);

  const MovementType(this.label, this.icon);
  final String label;
  final IconData icon;
}