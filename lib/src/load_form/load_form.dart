import 'package:auto_j/main.dart';
import 'package:auto_j/src/components/form/form_input.dart';
import 'package:auto_j/src/load_form/floor_load.dart';
import 'package:auto_j/src/load_form/wall_load.dart';
import 'package:auto_j/src/service/interface/i_data_model_service.dart';
import 'package:auto_j/src/service/interface/i_heat_loss_service.dart';
import 'package:auto_j/src/settings/settings_view.dart';
import 'package:flutter/material.dart';

class LoadForm extends StatefulWidget {
  static const routeName = '/load_form';

  const LoadForm({super.key});

  @override
  LoadFormState createState() => LoadFormState();
}

class LoadFormState extends State<LoadForm> {
  final _formKey = GlobalKey<FormState>();
  var dataModelService = getIt<IDataModelService>();
  var heatLossCalculatorService = getIt<IHeatLossCalculatorService>();

  @override
  Widget build(BuildContext context) {
    var dataModel = dataModelService.dataModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Load Form'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FormInput(
                label: 'Length',
                inputType: TextInputType.number,
                validationMessage: 'Please enter the length',
                initialValue: dataModel.length.toString(),
                onSaved: (value) {
                  if (value == null) {
                    return;
                  }
                  dataModel.length = int.parse(value);
                },
              ),
              FormInput(
                label: 'Width',
                inputType: TextInputType.number,
                validationMessage: 'Please enter the width',
                initialValue: dataModel.width.toString(),
                onSaved: (value) {
                  if (value == null) {
                    return;
                  }
                  dataModel.width = int.parse(value);
                },
              ),
              FormInput(
                label: 'Indoor Setpoint',
                inputType: TextInputType.number,
                validationMessage: 'Please enter the indoor setpoint temperature in Fahrenheit',
                initialValue: dataModel.indoorSetpoint.toString(),
                onSaved: (value) {
                  if (value == null) {
                    return;
                  }
                  dataModel.indoorSetpoint = int.parse(value);
                },
              ),
              FormInput(
                label: 'Outdoor Temperature',
                inputType: TextInputType.number,
                validationMessage: 'Please enter the outdoor temperature in Fahrenheit',
                initialValue: dataModel.outdoorTemperature.toString(),
                onSaved: (value) {
                  if (value == null) {
                    return;
                  }
                  dataModel.outdoorTemperature = int.parse(value);
                },
              ),
              ElevatedButton(
                child: const Text('Next: Floor Load'),
                onPressed: () {
                  if (_formKey.currentState == null) {
                    return;
                  }
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pushNamed(context, FloorLoadForm.routeName);
                  }
                },
              ),
              ElevatedButton(
                child: const Text('Next: Wall Load'),
                onPressed: () {
                  if (_formKey.currentState == null) {
                    return;
                  }
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pushNamed(context, WallLoadForm.routeName);
                  }
                },
              ),
              ElevatedButton(
                child: const Text('Calculate'),
                onPressed: () {
                  if (_formKey.currentState == null) {
                    return;
                  }
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    var hvacLoad = heatLossCalculatorService.calculateTotalHeatLoss(dataModel);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('HVAC Load'),
                            content: Text('The HVAC load is ${hvacLoad.toStringAsFixed(0)} BTU'),
                            actions: [
                              ElevatedButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
