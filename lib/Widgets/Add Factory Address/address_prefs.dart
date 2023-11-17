import 'package:shared_preferences/shared_preferences.dart';
import 'address_detail_model.dart';

class AddressPreferences {
  static Future<List<AddressDetails>> loadAddressList() async {
    final prefs = await SharedPreferences.getInstance();
    final addressJsonList = prefs.getStringList('addressList');
    if (addressJsonList != null) {
      return addressJsonList.map((json) => addressFromJson(json)).toList();
    }
    return [];
  }

  static Future<void> saveAddressList(List<AddressDetails> addressList) async {
    final prefs = await SharedPreferences.getInstance();
    final addressJsonList =
    addressList.map((address) => addressToJson(address)).toList();
    await prefs.setStringList('addressList', addressJsonList);
  }
}
