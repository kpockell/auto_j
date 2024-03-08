import 'package:auto_j/src/data/data_model.dart';
import 'package:auto_j/src/service/interface/i_heat_loss_service.dart';

class HeatLossCalculatorService implements IHeatLossCalculatorService {

  @override
  double calculateTotalHeatLoss(DataModel dataModel) {
    double totalHeatLoss = 0.0;
    int temperatureDelta = dataModel.indoorSetpoint - dataModel.outdoorTemperature;
    // Calculate heat loss for walls
    var wallData = dataModel.wallData;
    var wallUFactor = _getUFactor(wallData.wallRValue);
    double wallHeatLoss = _calculateSimpleHeatLoss(temperatureDelta, wallData.totalWallArea, wallUFactor);
    totalHeatLoss += wallHeatLoss;

    // // Calculate heat loss for windows
    // double windowHeatLoss = _calculateSimpleHeatLoss(windowSurfaceArea, windowUFactor);
    // totalHeatLoss += windowHeatLoss;

    // // Calculate heat loss for doors
    // double doorHeatLoss = _calculateSimpleHeatLoss(doorSurfaceArea, doorUFactor);
    // totalHeatLoss += doorHeatLoss;

    // // Calculate heat loss for ceiling
    // double ceilingHeatLoss = _calculateSimpleHeatLoss(ceilingSurfaceArea, ceilingUFactor);
    // totalHeatLoss += ceilingHeatLoss;

    // Calculate heat loss for floor
    var floorData = dataModel.floorData;
    var floorUFactor = _getUFactor(floorData.floorRValue);
    double floorHeatLoss = _calculateSimpleHeatLoss(temperatureDelta, floorData.totalFloorArea, floorUFactor);
    totalHeatLoss += floorHeatLoss;

    return totalHeatLoss;
  }

  double _getUFactor(double rValue) {
    return 1 / rValue;
  }

  double _calculateSimpleHeatLoss(int temperatureDelta, int surfaceArea, double uFactor) {
    return (temperatureDelta) * surfaceArea * uFactor;
  }

}
