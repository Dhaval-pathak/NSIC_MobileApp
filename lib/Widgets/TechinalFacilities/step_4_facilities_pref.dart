import 'package:nsic/Widgets/TechinalFacilities/step_4_facilities_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Step4FacilitiesPrefs{
  static Future<List<Step4FacilitiesModel>> loadFacilities() async{
    final prefs = await SharedPreferences.getInstance();
    final facilitiesJsonList = prefs.getStringList("Step4FacilitiesList");
    if(facilitiesJsonList != null){
      return facilitiesJsonList.map((json) => facilitiesFromJson(json)).toList();
    }
    return [];
  }

  static Future<void> saveFacilities(List<Step4FacilitiesModel> facilitiesList)async{
    final prefs = await SharedPreferences.getInstance();
    final facilitiesJsonList = facilitiesList.map((facilities) => facilitiesToJson(facilities)).toList();
    await prefs.setStringList("Step4FacilitiesList", facilitiesJsonList);
  }
}