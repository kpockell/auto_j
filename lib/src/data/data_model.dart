class DataModel {
  int length = 0;
  int width = 0;
  int indoorSetpoint = 0;
  int outdoorTemperature = 0;
  var floorData = FloorData();
  var wallData = WallData();
}

class FloorData {
  int floorLength = 0;
  int floorWidth = 0;
  double floorRValue = 0.0;

  get totalFloorArea => floorLength * floorWidth;
}

class WallData {
  int wallLength = 0;
  int wallWidth = 0;
  int wallHeight = 0;
  double wallRValue = 0.0;

  get totalWallArea => (wallLength * wallHeight) + (wallWidth * wallHeight);
}