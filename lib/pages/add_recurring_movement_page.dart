import 'package:flutter/material.dart';
import 'package:money_follower/enums/recurring_movement_type.dart';

class AddRecurringMovementPage extends StatelessWidget {
  static const String id = "add_recurring_movements_page";

  const AddRecurringMovementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Agregar movimiento recurrente',
        ),
      ),
      body: AddMovementForm(),
    );
  }
}

class AddMovementForm extends StatefulWidget {
  const AddMovementForm({super.key});

  @override
  State<AddMovementForm> createState() => _AddMovementFormState();
}

class _AddMovementFormState extends State<AddMovementForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // Associate the form key with this Form widget
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  flex: 100,
                  child: DropdownMenu<RecurringMovementType>(
                    expandedInsets: EdgeInsets.zero,
                    enableSearch: false,
                    enableFilter: false,
                    errorText: "Valor no valido",
                    initialSelection: RecurringMovementType.outbound,
                    label: const Text('Tipo de movimiento'),
                    requestFocusOnTap: true,
                    dropdownMenuEntries: RecurringMovementType.values
                        .map<DropdownMenuEntry<RecurringMovementType>>(
                            (RecurringMovementType movementType) {
                      return DropdownMenuEntry<RecurringMovementType>(
                        value: movementType,
                        label: movementType.label,
                      );
                    }).toList(),
                    onSelected: (element) {
                      setState(() {

                      });
                    },
                  ),
                ),
              ],
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              // Label for the name field
              validator: (value) {
                // Validation function for the name field
                if (value!.isEmpty) {
                  return 'Please enter your name.'; // Return an error message if the name is empty
                }
                return null; // Return null if the name is valid
              },
              onSaved: (value) {
                _name = value!; // Save the entered name
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              // Label for the email field
              validator: (value) {
                // Validation function for the email field
                if (value!.isEmpty) {
                  return 'Please enter your email.'; // Return an error message if the email is empty
                }
                // You can add more complex validation logic here
                return null; // Return null if the email is valid
              },
              onSaved: (value) {
                _email = value!; // Save the entered email
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text(
                'Agregar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
