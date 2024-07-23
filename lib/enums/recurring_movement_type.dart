import 'package:flutter/material.dart';


enum RecurringMovementType {
  income('Ingreso', Icons.brush_outlined),
  outbound('Gasto', Icons.favorite);

  const RecurringMovementType(this.label, this.icon);
  final String label;
  final IconData icon;
}