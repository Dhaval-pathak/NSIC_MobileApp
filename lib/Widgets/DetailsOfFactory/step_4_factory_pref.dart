import 'package:nsic/Widgets/DetailsOfFactory/step_4_factory_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Step4FactoryPrefs {
  static Future<List<Step4FactoryModel>> loadStore() async {
    final prefs = await SharedPreferences.getInstance();
    final storeJsonList = prefs.getStringList('Step4FactoryList');
    if (storeJsonList != null) {
      return storeJsonList.map((json) => storeFromJson(json)).toList();
    }
    return [];
  }

  static Future<void> saveStore(List<Step4FactoryModel> proprietorList) async {
    final prefs = await SharedPreferences.getInstance();
    final storeJsonList =
        proprietorList.map((proprietor) => storeToJson(proprietor)).toList();
    await prefs.setStringList('Step4FactoryList', storeJsonList);
  }
}
