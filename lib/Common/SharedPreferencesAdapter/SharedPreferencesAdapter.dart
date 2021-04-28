import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesAdapter {
  setDouble(String key, double longitude);
  setString(String key, String json);
  Future<String?> getString(String key);
  setStringList(String key, List<String>  value);
  Future<List<String>?> getStringList(String key);
  Future<double?> getDouble(String key);
}

@LazySingleton(as: SharedPreferencesAdapter)
class SharedPreferencesAdapterImpl implements SharedPreferencesAdapter {

  setStringList(String key, List<String>  value) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList(key, value);
  }

  Future<List<String>?> getStringList(String key) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList(key);
  }

  setDouble(String key, double value) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setDouble(key, value);
  }

  @override
  Future<double?> getDouble(String key) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(key);
  }

  @override
  setString(String key, String json) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(key,json);
  }

  @override
  Future<String?> getString(String key) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }
}


class MemorySharePreferencesAdapterImpl implements SharedPreferencesAdapter {



  Map<String,dynamic> store = Map();
  
  setStringList(String key, List<String>  value) async {
    store[key] = value;
  }

  getStringList(String key) async {
    return store[key];
  }

  setDouble(String key, double value) async {
    store[key] = value;
  }

  @override
  getDouble(String key) async {
    return store[key];
  }

  @override
  setString(String key, String json) {
    store[key] = json;
  }

  @override
  Future<String> getString(String key) async {
    return store[key];
  }
}