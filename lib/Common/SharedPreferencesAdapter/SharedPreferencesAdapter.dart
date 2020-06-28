import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesAdapter {
  setDouble(String key, double longitude);

  getDouble(String key);

}

class SharedPreferencesAdapterImpl implements SharedPreferencesAdapter {

  setDouble(String key, double value) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setDouble(key, value);
  }

  @override
  getDouble(String key) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(key);
  }


}