import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class RecurringMovementsCard extends StatelessWidget {
  final String title;
  final String desc;
  final IconData icon;
  final String savingType;
  final num amount;

  const RecurringMovementsCard(
      {super.key,
      required this.title,
      required this.desc,
      required this.icon,
      required this.savingType,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    Color color = Colors.red;

    if (savingType == "income") {
      color = Colors.green;
    }

    String formatAmount(double amount) {
      String formatedAmount = amount.toString();
      List<String> elements = formatedAmount.split(".");
      if (elements[1].length == 1) {
        elements[1] = "${elements[1]}0";
      }
      return elements.join(".");
    }

    return Card(
      child: ListTile(
        leading: Icon(
          icon,
          color: color,
        ),
        title: Text(title),
        subtitle: Text(desc),
        trailing: AutoSizeText(
          formatAmount(amount.toDouble()),
          style: const TextStyle(fontSize: 18),
          minFontSize: 18,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () => {
          debugPrint("Hola")
        },
      ),
    );
  }
}
