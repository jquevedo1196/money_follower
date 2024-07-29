import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:money_follower/enums/recurring_movement_type.dart';

import '../../enums/frequency_type.dart';

const String required = "Este campo es obligatorio";

class AddRecurringMovementPage extends StatelessWidget {
  static const String id = "add_recurring_movements_page";

  const AddRecurringMovementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Agregar movimiento recurrente',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
          color: Colors.lightBlue,
          child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: const AddMovementForm())),
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
            items: _movementsDropdownItems(),
            decoration: const InputDecoration(
                labelText: 'Tipo de movimiento recurrente'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: required),
            ]),
          ),
          const SizedBox(height: 10),
          FormBuilderTextField(
            name: 'name',
            decoration: const InputDecoration(labelText: 'Nombre'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: required),
              FormBuilderValidators.maxLength(100,
                  errorText: "Debe tener menos de 100 caracteres"),
            ]),
          ),
          const SizedBox(height: 10),
          FormBuilderTextField(
            name: 'amount',
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Monto'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: required),
            ]),
          ),
          const SizedBox(height: 10),
          FormBuilderDropdown(
            name: 'frequency',
            items: _frequencyDropdownItems(),
            decoration: const InputDecoration(labelText: 'Frecuencia'),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: required),
            ]),
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
              style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
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

List<DropdownMenuItem<RecurringMovementType>> _movementsDropdownItems() {
  return RecurringMovementType.values
      .map<DropdownMenuItem<RecurringMovementType>>(
          (RecurringMovementType movementType) {
    return DropdownMenuItem<RecurringMovementType>(
      value: movementType,
      child: Text(movementType.label),
    );
  }).toList();
}

List<DropdownMenuItem<FrequencyType>> _frequencyDropdownItems() {
  return FrequencyType.values
      .map<DropdownMenuItem<FrequencyType>>((FrequencyType frequencyType) {
    return DropdownMenuItem<FrequencyType>(
      value: frequencyType,
      child: Text(frequencyType.label),
    );
  }).toList();
}
