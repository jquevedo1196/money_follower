import 'package:flutter/material.dart';


enum FrequencyType {
  weekly('Semanal', Icons.calendar_month),
  biweekly('Quincenal', Icons.calendar_month),
  monthly('Mensual', Icons.calendar_month);

  const FrequencyType(this.label, this.icon);
  final String label;
  final IconData icon;
}