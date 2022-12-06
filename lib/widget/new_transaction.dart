import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  // late String titleInput;
  // late String amountInput;
  final addNT;

  NewTransaction(this.addNT);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitB() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredT = _titleController.text;
    final enteredAn = double.parse(_amountController.text);

    if (enteredT.isEmpty || enteredAn <= 0 || _selectedDate == null) {
      return;
    }

    widget.addNT(enteredT, enteredAn, _selectedDate);
    Navigator.of(context).pop();
  }

  void presentSDP() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1998),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
          child: Container(
        padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (_) => _submitB(),
              controller: _titleController,
              // onChanged: (vae) {
              //   titleInput = vae;
              // },
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (_) => _submitB(),
              // onChanged: (vae) {
              //   titleInput = vae;
              // },
              controller: _amountController,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date chosen!'
                          : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate!)}')),
                  OutlinedButton(
                      onPressed: presentSDP,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: _submitB,
                child: Text(
                  style: TextStyle(color: Colors.white),
                  'Create',
                ))
          ],
        ),
      )),
    );
  }
}
