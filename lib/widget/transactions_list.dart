import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

class Try extends StatelessWidget {
  final List<Transaction> transactions;
  final delete;
  Try(this.transactions, this.delete);
  @override
  Widget build(BuildContext context) {
    return  transactions.isEmpty
          ? Column(
              children: [
                Text('No Transaction'),
                SizedBox(height: 20),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView(
              children: transactions.map((ta) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                        child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text('N' + '${ta.amount.toStringAsFixed(2)}')),
                    )),
                    title: Text(
                      ta.title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(ta.date),
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 10),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete_forever,
                        color: Theme.of(context).errorColor,
                      ),
                      onPressed:() => delete(ta.id),
                    ),
                  ),
                );
              }).toList(),

    );
  }
}
