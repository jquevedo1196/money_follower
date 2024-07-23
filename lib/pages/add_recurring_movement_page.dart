import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            RecurringMovementsForm(context),
            DropdownMenu<RecurringMovementType>(
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
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your name.';
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              // Label for the email field
              validator: (value) {
                // Validation function for the email field
                if (value!.isEmpty) {
                  return 'Please enter your email.';
                }
                return null;
              },
              onSaved: (value) {
                _email = value!;
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

FormBuilder RecurringMovementsForm(BuildContext context) {
  final _formKey = GlobalKey<FormBuilderState>();
  final _emailFieldKey = GlobalKey<FormBuilderFieldState>();

  List<DropdownMenuItem> values = RecurringMovementType.values
      .map<DropdownMenuItem<RecurringMovementType>>(
          (RecurringMovementType movementType) {
        return DropdownMenuItem<RecurringMovementType>(
          value: movementType,
          child: Text(movementType.label),
        );
      }).toList();

  return FormBuilder(
    key: _formKey,
    child: Column(
      children: [
        FormBuilderDropdown(
          name: 'movement_type',
          items: values,
        ),
        FormBuilderTextField(
          key: _emailFieldKey,
          name: 'email',
          decoration: const InputDecoration(labelText: 'Email'),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.email(),
          ]),
        ),
        const SizedBox(height: 10),
        Visibility(
          visible: false,
          child: FormBuilderTextField(
            name: 'password',
            enabled: false,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
        ),
        MaterialButton(
          color: Theme.of(context).colorScheme.secondary,
          onPressed: () {
            // Validate and save the form values
            _formKey.currentState?.saveAndValidate();
            debugPrint(_formKey.currentState?.value.toString());

            // On another side, can access all field values without saving form with instantValues
            _formKey.currentState?.validate();
            debugPrint(_formKey.currentState?.instantValue.toString());
          },
          child: const Text('Login'),
        )
      ],
    ),
  );
}
