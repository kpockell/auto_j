import 'package:auto_j/src/data/data_model.dart';

abstract class IHeatLossCalculatorService {
  double calculateTotalHeatLoss(DataModel dataModel);
}