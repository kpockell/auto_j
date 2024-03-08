import 'package:auto_j/main.dart';
import 'package:auto_j/src/components/form/form_input.dart';
import 'package:auto_j/src/service/interface/i_data_model_service.dart';
import 'package:flutter/material.dart';

class FloorLoadForm extends StatefulWidget {
  static const routeName = '/floor_load_form';

  const FloorLoadForm({super.key});
  @override
  FloorLoadFormState createState() => FloorLoadFormState();
}

class FloorLoadFormState extends State<FloorLoadForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final dataModelService = getIt<IDataModelService>();
    final floorData = dataModelService.floorData;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Floor Calculator'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FormInput(
                label: 'Total floor length (in feet)',
                inputType: TextInputType.number,
                initialValue: floorData.floorLength,
                validationMessage: 'Please enter the total floor length',
                onSaved: (value) {
                  if (value != null) {
                    floorData.floorLength = int.parse(value);
                  }
                }
              ),
              FormInput(
                label: 'Total floor width (in feet)',
                inputType: TextInputType.number,
                initialValue: floorData.floorWidth,
                validationMessage: 'Please enter the total floor width',
                onSaved: (value) {
                  if (value != null) {
                    floorData.floorWidth = int.parse(value);
                  }
                }
              ),
              FormInput(
                label: 'Estimated floor R-value',
                inputType: TextInputType.number,
                initialValue: floorData.floorRValue.toString(),
                validationMessage: 'Please enter the estimated floor R-value',
                onSaved: (value) {
                  if (value != null) {
                    floorData.floorRValue = double.parse(value);
                  }
                }
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState == null) {
                    return;
                  }
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    dataModelService.updateFloorData(floorData);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}