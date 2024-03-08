import 'package:auto_j/src/data/data_model.dart';

abstract class IDataModelService {
  DataModel get dataModel;
  FloorData get floorData;
  WallData get wallData;
  void updateFloorData(FloorData floorData);
  void updateWallData(WallData wallData);
}
