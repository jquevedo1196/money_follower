import 'package:flutter/material.dart';

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
      body: FormExample(),
    );
  }
}

class FormExample extends StatefulWidget {
  const FormExample({super.key});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name = ''; // Variable to store the entered name
  String _email = ''; // Variable to store the entered email

  void _submitForm() {
    // Check if the form is valid
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save the form data
      // You can perform actions with the form data here and extract the details
      print('Name: $_name'); // Print the name
      print('Email: $_email'); // Print the email
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // Associate the form key with this Form widget
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'), // Label for the name field
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
              decoration: InputDecoration(labelText: 'Email'), // Label for the email field
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
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _submitForm, // Call the _submitForm function when the button is pressed
              child: Text('Submit'), // Text on the button
            ),
          ],
        ),
      ),
    );
  }
}
