import 'package:flutter/material.dart';
import 'package:nsic/Widgets/Performance%20Statement/performance_prefs.dart';

import '../Widgets/Add Factory Address/address_prefs.dart';
import '../Widgets/Proprietor having stake in the MSE unit/proprietor_prefs.dart';

class ValidatorForComponent1 {
  bool validationForValue_0(BuildContext context, String value,
      String textfieldTitle, String sectionTitle) {
    if (value == 0.toString() || value=='') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                "Please Select $textfieldTitle from $sectionTitle Section",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Ok')),
            ],
          );
        },
      );
      return false;
    }
    return true;
  }

  bool validationForValue_yes_no(BuildContext context, String value,
      String textfieldTitle, String sectionTitle) {
    if (value.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                "Please Agree to $textfieldTitle from $sectionTitle Section",
              style: TextStyle(
              fontSize: 20,
            ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Ok')),
            ],
          );
        },
      );
      return false;
    }

    return true;
  }

  bool validationForText(BuildContext context, String value, String textfieldTitle,
      String sectionTitle, RegExp? regExp) {
    if (value.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(" $textfieldTitle from $sectionTitle Section",
              style: TextStyle(
              fontSize: 20,
            ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Ok')),
            ],
          );
        },
      );
      return false;
    } else if (!regExp!.hasMatch(value)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Invalid input for $textfieldTitle from $sectionTitle Section",
            style: TextStyle(
                fontSize: 20
            ),),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Ok')),
            ],
          );
        },
      );
      return false;
    }
    return true;
  }


  Future<bool> validateForAddress(BuildContext context, String alertText) async {
    final addressList = await AddressPreferences.loadAddressList();
    if (addressList.isEmpty) {
      showAddressAlertDialog(context,alertText );
      return false;
    }
    else {
      return true;
    }
  }

  Future<bool> validateForProprietor(BuildContext context, String alertText) async {
    final proprietorList =
    await ProprietorPrefs.loadProprietor();
    print("proprietor length - ${proprietorList.length}");
    if (proprietorList.isEmpty) {
      showAddressAlertDialog(context,alertText );
      return false;
    }
    else {
      return true;
    }
  }

  Future<bool> validateForPerformanceStatemnet(BuildContext context, String alertText) async {
    final performanceList = await PerformancePreferences.loadPerformanceList();
    if (performanceList.isEmpty) {
      showAddressAlertDialog(context,alertText);
      return false;
    }
    else {
      return true;
    }
  }

  void showAddressAlertDialog(BuildContext context, String alertText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            alertText,
            // 'Minimum One Factory Address is Required',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          backgroundColor: Color(0xffff4545),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
// Provider.of<ProgressIndicatorProvider>(context, listen: false)
//     .goForward();
