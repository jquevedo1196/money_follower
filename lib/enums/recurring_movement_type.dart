import 'package:flutter/material.dart';


enum MovementType {
  income('Ingreso', Icons.brush_outlined),
  outbound('Gasto', Icons.favorite);

  const MovementType(this.label, this.icon);
  final String label;
  final IconData icon;
}