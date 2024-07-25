import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:money_follower/enums/recurring_movement_type.dart';

const String required = "Este campo es obligatorio";

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
      body: const AddMovementForm(),
    );
  }
}

class AddMovementForm extends StatefulWidget {
  const AddMovementForm({super.key});

  @override
  State<AddMovementForm> createState() => _AddMovementFormState();
}

class _AddMovementFormState extends State<AddMovementForm> {
  final GlobalKey<FormState> _outerFormKey = GlobalKey<FormState>();
  final GlobalKey<FormBuilderState> _innerFormKey =
      GlobalKey<FormBuilderState>();
  bool _visibility = true;

  void _updateForm(bool newValue) {
    setState(() {
      _visibility = newValue;
    });
  }

  List<DropdownMenuItem<RecurringMovementType>> _buildDropdownItems() {
    return RecurringMovementType.values
        .map<DropdownMenuItem<RecurringMovementType>>(
            (RecurringMovementType movementType) {
      return DropdownMenuItem<RecurringMovementType>(
        value: movementType,
        child: Text(movementType.label),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _outerFormKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            recurringMovementsForm(),
          ],
        ),
      ),
    );
  }

  FormBuilder recurringMovementsForm() {
    return FormBuilder(
      key: _innerFormKey,
      child: Column(
        children: [
          FormBuilderDropdown(
            name: 'movement_type',
            items: _buildDropdownItems(),
            isExpanded: true,
            initialValue: RecurringMovementType.income,
            onChanged: (selection) {
              _updateForm(selection == RecurringMovementType.income);
            },
          ),
          Visibility(
            visible: _visibility,
            child: FormBuilderTextField(
              name: 'email',
              decoration: const InputDecoration(labelText: 'Email'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: required),
                FormBuilderValidators.email(
                    errorText: "Debe ser un correo válido"),
              ]),
            ),
          ),
          const SizedBox(height: 10),
          Visibility(
            visible: _visibility,
            child: FormBuilderTextField(
              name: 'password',
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: required),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
              onPressed: () {
                if (_innerFormKey.currentState?.saveAndValidate() ?? false) {
                  debugPrint(_innerFormKey.currentState?.value.toString());
                } else {
                  debugPrint("Validation failed");
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text(
                'Agregar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
