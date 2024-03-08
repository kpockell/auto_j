import 'package:auto_j/src/service/data_model_service.dart';
import 'package:auto_j/src/service/heat_loss_calculator_service.dart';
import 'package:auto_j/src/service/in_memory_data_service.dart';
import 'package:auto_j/src/service/interface/i_data_model_service.dart';
import 'package:auto_j/src/service/interface/i_data_service.dart';
import 'package:auto_j/src/service/interface/i_heat_loss_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

final getIt = GetIt.instance;

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  _getItRegistration();
  runApp(MyApp(settingsController: settingsController));
}

void _getItRegistration() {
  getIt.registerSingleton<IDataService>(InMemoryDataService());
  getIt.registerSingleton<IHeatLossCalculatorService>(HeatLossCalculatorService());
  getIt.registerSingleton<IDataModelService>(DataModelService(getIt<IDataService>()));
}