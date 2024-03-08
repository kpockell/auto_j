import 'package:flutter/material.dart';

class SimpleHvacLoadForm extends StatefulWidget {
  static const routeName = '/simple_hvac_load_form';

  const SimpleHvacLoadForm({super.key});

  @override
  SimpleHvacLoadFormState createState() => SimpleHvacLoadFormState();
}

class SimpleHvacLoadFormState extends State<SimpleHvacLoadForm> {
  final _formKey = GlobalKey<FormState>();
  int _area = 100;
  int _occupancy = 0;
  int _equipment = 0;
  int _ceilingHeight = 8;
  int _exteriorDoors = 1;
  int _windows = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HVAC Load Calculator'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SimpleFormInput(
                label: 'Area (in square feet)',
                initialValue: _area,
                validationMessage: 'Please enter the area',
                onSaved: (value) {
                  if (value != null) {
                    _area = int.parse(value);
                  }
                },
              ),
              SimpleFormInput(
                label: 'Ceiling height (in feet)',
                initialValue: _ceilingHeight,
                validationMessage: 'Please enter the ceiling height',
                onSaved: (value) {
                  if (value != null) {
                    _ceilingHeight = int.parse(value);
                  }
                },
              ),
              SimpleFormInput(
                label: 'Windows',
                initialValue: _windows,
                validationMessage: 'Please enter the number of windows',
                onSaved: (value) {
                  if (value != null) {
                    _windows = int.parse(value);
                  }
                }
                ),
              SimpleFormInput(
                label: 'Exterior doors',
                initialValue: _exteriorDoors,
                validationMessage: 'Please enter the number of exterior doors',
                onSaved: (value) {
                  if (value != null) {
                    _exteriorDoors = int.parse(value);
                  }
                }
              ),
              SimpleFormInput(
                label: 'How many people occupy the space?',
                initialValue: _occupancy,
                validationMessage: 'Please enter the occupancy',
                onSaved: (value) {
                  if (value != null) {
                    _occupancy = int.parse(value);
                  }
                },
              ),
              SimpleFormInput(
                label: 'Equipment (in watts)',
                initialValue: _equipment,
                validationMessage: 'Please enter the equipment load',
                onSaved: (value) {
                  if (value != null) {
                    _equipment = int.parse(value);
                  }                  
                },
              ),
              const SizedBox(height: 16.0),
                ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState == null) {
                    return;
                  }
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Perform HVAC load calculation here
                    int baseLoad = _area * _ceilingHeight;
                    int occupancyLoad = _occupancy * 100;
                    int doorLoad = _exteriorDoors * 1000;
                    int windowLoad = _windows * 1000;
                    int hvacLoad = baseLoad + occupancyLoad + windowLoad + doorLoad + _equipment;
                    // Display the result
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('HVAC Load'),
                          content: Text('The HVAC load is $hvacLoad BTU'),
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
                child: const Text('Calculate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SimpleFormInput extends StatelessWidget {
  final String label;
  final String validationMessage;
  final int initialValue;
  final void Function(String?)? onSaved;

  const SimpleFormInput({super.key, 
    required this.label,
    required this.initialValue,
    required this.validationMessage,
    required this.onSaved,
  });

  @override

  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,

      initialValue: initialValue.toString(),
      decoration: InputDecoration(
        labelText: label,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationMessage;
        }
        return null;
      },
      onSaved: onSaved,
    );
  }
}