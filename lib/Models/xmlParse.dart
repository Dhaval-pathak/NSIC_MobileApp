import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsic/Models/fetchUser.dart';
import 'package:nsic/Models/step1Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml2json/xml2json.dart';

class xmlParse {
  final Xml2Json xml2json = Xml2Json();
  Future<Step1Model> fetchAndParse(String udyam, String Pan) async {
    // udyam='UDYAM-GJ-14-0002023';
    // Pan='AADCL8897L';
    try {
      var xmlString = await fetchUser(udyam, Pan);
      xml2json.parse(xmlString);
      var jsonData = xml2json.toParker();
      var data = json.decode(jsonData);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('panController', Pan);
      return Step1Model.fromJson(data['GetXMLResponse']['GetXMLResult']);
    }catch (e){
      showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text('Udyam Number or PAN number is not valid'),
              content: Text('Please check'),
              actions: [
                TextButton(
                  child: Text('Go Back'),
                  onPressed: () {
                    if (Platform.isAndroid) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else if (Platform.isIOS) {
                      exit(0);
                    }
                  },
                ),
              ],
            ),
          );
        },
      );
      rethrow;
    }
  }
}