import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:money_follower/data/payments_data.dart';
import 'package:money_follower/enums/recurring_movement_type.dart';
import 'package:money_follower/models/payments_model.dart';
import 'package:money_follower/pages/recurring_movements_page/recurring_movements_page.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
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
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Agregar movimiento',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        color: Colors.lightBlue,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: const AddMovementForm(),
        ),
      ),
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
            _recurringMovementsForm(),
          ],
        ),
      ),
    );
  }

  FormBuilder _recurringMovementsForm() {
    return FormBuilder(
      key: _innerFormKey,
      child: Column(
        children: [
          _buildDropdownField<MovementType>(
            name: 'movement_type',
            label: 'Tipo de movimiento',
            items: _buildDropdownItems<MovementType>(
                MovementType.values, (MovementType type) => type.label),
          ),
          const SizedBox(height: 10),
          _buildTextField(
            name: 'name',
            label: 'Nombre',
            validators: [
              FormBuilderValidators.required(errorText: required),
              FormBuilderValidators.maxLength(100,
                  errorText: "Debe tener menos de 100 caracteres"),
            ],
          ),
          const SizedBox(height: 10),
          _buildTextField(
            name: 'amount',
            label: 'Monto',
            keyboardType: TextInputType.number,
            validators: [
              FormBuilderValidators.required(errorText: required),
              FormBuilderValidators.positiveNumber(
                  errorText: "Debe ser un valor numérico mayor a 0"),
            ],
          ),
          const SizedBox(height: 10),
          _buildDropdownField<FrequencyType>(
            name: 'frequency',
            label: 'Frecuencia',
            items: _buildDropdownItems<FrequencyType>(
                FrequencyType.values, (FrequencyType type) => type.label),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
              onPressed: _onSubmit,
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
              child: const Text(
                'Agregar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSubmit() {
    if (_innerFormKey.currentState?.saveAndValidate() ?? false) {
      debugPrint(_innerFormKey.currentState?.value.toString());
      PaymentsData().insertPayment(fromMap(_innerFormKey.currentState));
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: "Exitoso",
        text: 'Movimiento agregado correctamente!',
        showConfirmBtn: true,
        confirmBtnText: "Aceptar",
        onConfirmBtnTap: () => Navigator.pushNamed(context, RecurringMovementsPage.id),
      );
    } else {
      debugPrint("Validation failed");
    }
  }

  PaymentModel fromMap(FormBuilderState? state) {
    Map<String, dynamic>? value = state?.value;
    MovementType movementType = value?["movement_type"];
    FrequencyType frequencyType = value?["frequency"];
    double amount = truncate(double.parse(value?["amount"]), 2);

    PaymentModel newPayment = PaymentModel(
        id: 1,
        movementType: movementType,
        name: value?["name"],
        amount: amount,
        frequencyType: frequencyType);

    return newPayment;
  }

  double truncate(double val, int fractionDigits) {
    var mod = pow(10.0, fractionDigits).toDouble();
    return ((val * mod).round().toDouble() / mod);
  }

  FormBuilderTextField _buildTextField({
    required String name,
    required String label,
    TextInputType? keyboardType,
    List<FormFieldValidator>? validators,
  }) {
    return FormBuilderTextField(
      name: name,
      keyboardType: keyboardType,
      decoration: InputDecoration(labelText: label),
      validator: FormBuilderValidators.compose(validators ?? []),
    );
  }

  FormBuilderDropdown<T> _buildDropdownField<T>({
    required String name,
    required String label,
    required List<DropdownMenuItem<T>> items,
  }) {
    return FormBuilderDropdown<T>(
      name: name,
      items: items,
      decoration: InputDecoration(labelText: label),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: required),
      ]),
    );
  }

  List<DropdownMenuItem<T>> _buildDropdownItems<T>(
      List<T> values, String Function(T) getLabel) {
    return values.map<DropdownMenuItem<T>>((T value) {
      return DropdownMenuItem<T>(
        value: value,
        child: Text(getLabel(value)),
      );
    }).toList();
  }
}
