import 'package:flutter/material.dart';
import 'package:money_follower/pages/recurring_movements_page/add_recurring_movement_page.dart';
import 'package:money_follower/pages/recurring_movements_page/recurring_movements_page.dart';

void main() => runApp(const MoneyFollowerApp());

class MoneyFollowerApp extends StatelessWidget {
  const MoneyFollowerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      initialRoute: RecurringMovements.id,
      routes: {
        RecurringMovements.id: (context) => const RecurringMovements(),
        AddRecurringMovementPage.id: (context) => const AddRecurringMovementPage(),
      },
    );
  }
}
