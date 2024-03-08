abstract class IDataService {
  void setValue(String key, dynamic value);
  dynamic getValue(String key);
  void removeValue(String key);
}
