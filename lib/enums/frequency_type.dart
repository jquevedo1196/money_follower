import 'package:flutter/material.dart';


enum FrequencyType {
  weekly('Pago Semanal', Icons.calendar_month),
  biweekly('Pago Quincenal', Icons.calendar_month),
  monthly('Pago Mensual', Icons.calendar_month),
  unique('Pago Único', Icons.calendar_month);

  const FrequencyType(this.label, this.icon);
  final String label;
  final IconData icon;
}