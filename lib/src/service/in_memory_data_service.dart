import 'interface/i_data_service.dart';

/// A simple data service that stores data in an in-memory map. 
class InMemoryDataService implements IDataService {
  final Map<String, dynamic> _data = {};

  @override
  void setValue(String key, dynamic value) {
    _data[key] = value;
  }

  @override
  dynamic getValue(String key) {
    return _data[key];
  }

  @override
  void removeValue(String key) {
    _data.remove(key);
  }

  void clear() {
    _data.clear();
  }
}
