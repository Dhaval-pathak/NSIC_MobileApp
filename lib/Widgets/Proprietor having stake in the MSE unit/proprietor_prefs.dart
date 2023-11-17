import 'package:nsic/Widgets/Proprietor%20having%20stake%20in%20the%20MSE%20unit/proprietor_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProprietorPrefs {
  static Future<List<ProprietorModel>> loadProprietor() async {
    final prefs = await SharedPreferences.getInstance();
    final proprietorJsonList = prefs.getStringList('proprietorList');
    if (proprietorJsonList != null) {
      return proprietorJsonList.map((json) => proprietorFromJson(json)).toList();
    }
    return [];
  }

  static Future<void> saveProprietor(List<ProprietorModel> proprietorList) async {
    final prefs = await SharedPreferences.getInstance();
    final proprietorJsonList =
        proprietorList.map((proprietor) => proprietorToJson(proprietor)).toList();
    await prefs.setStringList('proprietorList', proprietorJsonList);
  }
}
