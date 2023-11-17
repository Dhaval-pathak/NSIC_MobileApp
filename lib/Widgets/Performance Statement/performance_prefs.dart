import 'package:nsic/Widgets/Performance%20Statement/performance_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerformancePreferences{
  static Future<List<PerformanceDetails>> loadPerformanceList() async{
    final prefs = await SharedPreferences.getInstance();
    final performanceJsonList = prefs.getStringList("performanceList");
    if(performanceJsonList != null){
      return performanceJsonList.map((json) => performanceFromJson(json)).toList();
    }
    return [];
  }

  static Future<void> savePerformanceList(List<PerformanceDetails> performanceList)async{
    final prefs = await SharedPreferences.getInstance();
    final performanceJsonList = performanceList.map((details) => performanceToJson(details)).toList();
    await prefs.setStringList("performanceList", performanceJsonList);
  }

}