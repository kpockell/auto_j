import 'package:auto_j/src/data/data_model.dart';
import 'package:auto_j/src/service/interface/i_data_model_service.dart';
import 'package:auto_j/src/service/interface/i_data_service.dart';

class DataModelService implements IDataModelService {
  final _dataModel = DataModel();
  final IDataService _dataService;

  DataModelService(IDataService dataService): _dataService = dataService;

  @override
  DataModel get dataModel => _dataModel;

  @override
  FloorData get floorData => _dataModel.floorData;

  @override
  WallData get wallData => _dataModel.wallData;
  
  @override
  void updateFloorData(FloorData floorData) {
    _dataModel.floorData = floorData;
    _dataService.setValue('dataModel', _dataModel);
  }

  @override
  void updateWallData(WallData wallData) {
    _dataModel.wallData = wallData;
    _dataService.setValue('dataModel', _dataModel);
  }
}
