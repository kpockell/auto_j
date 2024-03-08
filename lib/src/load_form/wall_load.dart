import 'package:auto_j/main.dart';
import 'package:auto_j/src/components/form/form_input.dart';
import 'package:auto_j/src/service/interface/i_data_model_service.dart';
import 'package:flutter/material.dart';

class WallLoadForm extends StatefulWidget {
  static const routeName = '/wall_load_form';

  const WallLoadForm({super.key});

  @override
  WallLoadFormState createState() => WallLoadFormState();
}

class WallLoadFormState extends State<WallLoadForm> {
  final _formKey = GlobalKey<FormState>();
  final dataModelService = getIt<IDataModelService>();

  @override
  Widget build(BuildContext context) {
    final wallData = dataModelService.wallData;
    if (wallData.wallLength == 0) {
      wallData.wallLength = dataModelService.dataModel.length;
    }
    if (wallData.wallWidth == 0) {
      wallData.wallWidth = dataModelService.dataModel.width;
    }
    if (wallData.wallHeight == 0) {
      wallData.wallHeight = 8;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wall Calculator'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FormInput(
                label: 'Total wall length (in feet)',
                inputType: TextInputType.number,
                initialValue: wallData.wallLength,
                validationMessage: 'Please enter the total wall length',
                onSaved: (value) {
                  if (value != null) {
                    wallData.wallLength = int.parse(value);
                  }
                }
              ),
              FormInput(
                label: 'Total wall width (in feet)',
                inputType: TextInputType.number,
                initialValue: wallData.wallWidth,
                validationMessage: 'Please enter the total wall width',
                validate: (value){
                  if (value == null) {
                    return false;
                  }
                  int valueAsInt = int.parse(value);
                  if (valueAsInt <= 0) {
                    return false;
                  }
                  return true;
                },
                onSaved: (value) {
                  if (value != null) {
                    wallData.wallWidth = int.parse(value);
                  }
                }
              ),
              FormInput(
                label: 'Total wall height (in feet)',
                inputType: TextInputType.number,
                initialValue: wallData.wallHeight,
                validationMessage: 'Please enter the total wall height',
                validate: (value){
                  if (value == null) {
                    return false;
                  }
                  int valueAsInt = int.parse(value);
                  if (valueAsInt <= 0) {
                    return false;
                  }
                  return true;
                },
                onSaved: (value) {
                  if (value != null) {
                    wallData.wallHeight = int.parse(value);
                  }
                }
              ),
              FormInput(
                label: 'Estimated wall R-value',
                inputType: TextInputType.number,
                initialValue: wallData.wallRValue,
                validationMessage: 'Please enter the estimated wall R-value',
                validate: (value){
                  if (value == null) {
                    return false;
                  }
                  double valueAsDouble = double.parse(value);
                  if (valueAsDouble <= 0) {
                    return false;
                  }
                  return true;
                },
                onSaved: (value) {
                  if (value != null) {
                    wallData.wallRValue = double.parse(value);
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
                    dataModelService.updateWallData(wallData);
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