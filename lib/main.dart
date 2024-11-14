import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_follower/pages/budget_config_page/budget_config_page.dart';
import 'package:money_follower/pages/recurring_movements_page/add_recurring_movement_page.dart';
import 'package:money_follower/pages/recurring_movements_page/recurring_movements_page.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  // make flutter draw behind navigation bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  openDatabase(
    join(await getDatabasesPath(), 'money_follower.db'),
    onCreate: (db, version) {
      return db.execute(
        '''
        CREATE TABLE IF NOT EXISTS payments( 
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        movementType TEXT, 
        name TEXT, 
        amount INTEGER,
        frequencyType TEXT
        )''',
      );
    },
    version: 1,
  );

  runApp(const MoneyFollowerApp());
}

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
      initialRoute: BudgetConfigPage.id,
      routes: {
        BudgetConfigPage.id: (context) => const BudgetConfigPage(),
        RecurringMovementsPage.id: (context) => const RecurringMovementsPage(),
        AddRecurringMovementPage.id: (context) =>
        const AddRecurringMovementPage(),
      },
    );
  }
}
