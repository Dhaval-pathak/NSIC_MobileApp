
import 'package:nsic/Widgets/Add%20Store/store_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorePrefs {
  static Future<List<StoreModel>> loadStore() async {
    final prefs = await SharedPreferences.getInstance();
    final storeJsonList = prefs.getStringList('StoreList');
    if (storeJsonList != null) {
      return storeJsonList.map((json) => storeFromJson(json)).toList();
    }
    return [];
  }

  static Future<void> saveStore(List<StoreModel> proprietorList) async {
    final prefs = await SharedPreferences.getInstance();
    final storeJsonList =
        proprietorList.map((proprietor) => storeToJson(proprietor)).toList();
    await prefs.setStringList('StoreList', storeJsonList);
  }
}
