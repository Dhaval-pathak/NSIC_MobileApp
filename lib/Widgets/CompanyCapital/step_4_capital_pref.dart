import 'package:nsic/Widgets/CompanyCapital/step_4_capital_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Step4CapitalPrefs{
  static Future<List<Step4CapitalModel>> loadCapital() async{
    final prefs = await SharedPreferences.getInstance();
    final capitalJsonList = prefs.getStringList('Step4CapitalList');
    if(capitalJsonList != null){
      return capitalJsonList.map((json) => capitalFromJson(json)).toList();
    }
    return [];
  }

  static Future<void> saveCapital(List<Step4CapitalModel> capitalList) async{
    final prefs = await SharedPreferences.getInstance();
    final capitalJsonList = capitalList.map((capital) => capitalToJson(capital)).toList();
    await prefs.setStringList("Step4CapitalList", capitalJsonList);
  }
}