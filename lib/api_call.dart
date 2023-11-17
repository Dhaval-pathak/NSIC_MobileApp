import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nsic/Models/DocumentToBeUploadedModel.dart';
import 'package:nsic/Models/MainModel.dart';
import 'package:nsic/Models/existingDataExceptGridModel.dart';
import 'package:nsic/Models/statusCheckModel.dart';
import 'package:nsic/Models/step4FetchModel.dart';
import 'package:nsic/Widgets/Proprietor%20having%20stake%20in%20the%20MSE%20unit/proprietor_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Models/Step2_Data_Fetched_ForProprietor.dart';
import 'Models/Step2_Data_Fetched_ForStatusOfApplicantMSE.dart';
import 'Models/Step3_Data_Fetched_ForStore.dart';
import 'Models/Step3_Data_Fetched_ForUpperFields.dart';
import 'Models/existingDataModel.dart';
import 'Models/step1InsertResultModel.dart';

class ApiCall {
  var link = 'http://sprapp.nsicnet.in';
  var port = 3001;

  Future<bool> insertData(
    String udyam,
    String pan,
    String name,
    String date,
    String branch,
    String special,
    String isAyush,
    String gst,
    String share,
    String constitution,
    String address,
    String pin,
    String state,
    String tele,
    String mobile,
    String email,
    String city,
    String branchAdd,
    String branchPin,
    String branchState,
    String branchCity,
    String branchTele,
    String branchEmail,
    String social,
    String entrepreneur,
    String unitSize,
    String factoryAddress,
    String factoryPin,
    String factoryState,
    String factoryDistrict,
    String factoryTel,
    String factoryEmail,
    String enterprisedefnition,
  ) async {
    var url = '$link/insertStep1';

    // change date format to yyyy-mm-dd
    List<String> parts = date.split('-');
    String formattedDate = '${parts[2]}-${parts[1]}-${parts[0]}';

    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'BranchId': int.parse(branch),
          'Company_Name': name,
          'Pan': pan,
          'HeadOffice_Address': address,
          'HeadOffice_Zip': pin,
          'HeadOffice_StateId': int.parse(state),
          'HeadOffice_CityId': int.parse(city),
          'HeadOffice_Phone': tele,
          "HeadOffice_Fax": null,
          'HeadOffice_Email': email,
          "Provisional": 0,
          'HeadOffice_Mobile': mobile,
          "B1_FactoryAddress": factoryAddress,
          "B1_FactoryZip": factoryPin,
          "B1_FactoryStateid": int.parse(factoryState),
          "B1_FactoryCityid": int.parse(factoryDistrict),
          "B1_FactoryPhone": factoryTel,
          "B1_FactoryFax": null,
          "B1_FactoryEmail": factoryEmail,
          'CategoryAreaId': int.parse(social),
          'CategoryCastId': int.parse(entrepreneur),
          'CategoryUnitSizeId': int.parse(unitSize),
          'Branch_Address': branchAdd,
          'Branch_Zip': branchPin,
          'Branch_Stateid': branchState == "" ? 0 : int.parse(branchState),
          'Branch_Cityid': branchCity == "" ? 0 : int.parse(branchCity),
          'Branch_Phone': branchTele,
          'Branch_Fax': null,
          'Branch_Email': branchEmail,
          "CUserID": 0,
          "MSMEtype": true,
          'ShareInfo': share == "Yes" ? true : false,
          "enterprisedefnition": enterprisedefnition,
          'ProposalDate': formattedDate.toString(),
          'AdharNumber': udyam,
          'GSTNumber': gst,
          "IsSCST_Initiative": 1,
          'IsAyush': isAyush == "Yes" ? true : false,
        }));
// print((date.replaceAll("-", "/")).toString());
//     print('udyam: $udyam');
//     print('pan: $pan');
//     print('name: $name');
//     print('date: $date');
//     print('branch: $branch');
//     print('special: $special');
//     print('ayush: $isAyush');
//     print('gst: $gst');
//     print('share: $share');
//     print('constitution: $constitution');
//     print('address: $address');
//     print('pin: $pin');
//     print('state: $state');
//     print('tele: $tele');
//     print('mobile: $mobile');
//     print('email: $email');
//     print('city: $city');
//     print('branchAdd: $branchAdd');
//     print('branchPin: $branchPin');
//     print('branchState: $branchState');
//     print('branchCity: $branchCity');
//     print('branchTele: $branchTele');
//     print('branchEmail: $branchEmail');
//     print('social: $social');
//     print('entrepreneur: $entrepreneur');
//     print('unitSize: $unitSize');

    if (response.statusCode == 200) {
      print('Data inserted successfully');

      var step1Output = step1InsertResultModelFromJson(response.body);
      print(step1Output.companyId);
      var check = await updateConstitutionStep1(
          int.parse(step1Output.companyId), int.parse(constitution));

      final prefs = await SharedPreferences.getInstance();
      prefs.setString("step1OutputCompanyId", step1Output.companyId);

      if (check == true) {
        print("Constitution updated");
      } else {
        print("Constitution not updated");
      }
      return true;
    } else {
      print('Failed to insert data');
      return false;
    }
  }

  Future<bool> updateConstitutionStep1(
      int companyId, int constitutionId) async {
    var url = '$link/updateConstitutionStep1';
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
            {'CompanyId': companyId, 'ConstitutionId': constitutionId}));
    if (response.statusCode == 200) {
      print('Data inserted successfully');
      return true;
    } else {
      print('Failed to insert data');
      return false;
    }
  }

  Future<StatusCheckModel> checkStatus(String pan, String udyam) async {
    try {
      var url = '$link/checkStatus';
      var response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'pan': pan,
            'udyam': udyam,
          }));
      var status = json.decode(response.body);
      print(status);
      StatusCheckModel currentStatus = StatusCheckModel.fromJson(status[0]);
      return currentStatus;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> checkConstitutionInitially(String pan, String udyam) async {
    var url = '$link/checkConstitutionInitially';
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'pan': pan,
          'udyam': udyam,
        }));
    var constitution = json.decode(response.body);
    MainModel a = MainModel(
        id: constitution[0]["fGPtbl_ConstitutionId"],
        name: constitution[0]["fGPtbl_CUnit_3C123_ConstitutionId"].toString());
    return a.id;
  }

  Future<List<ExistingDataModel>> getExistingData(String pan) async {
    var url = '$link/getExistingData';
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'pan': pan,
        }));
    var data = existingDataModelFromJson(response.body);
    return data;
  }

  Future<List<ExistingDataModel>> getExistingDataProprietorship(
      String pan, String udyam) async {
    var url = '$link/getExistingDataProprietorship';
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'pan': pan, 'udyam': udyam}));
    var data = existingDataModelFromJson(response.body);
    return data;
  }

  Future<List<ExistingDataExceptGridModel>> getExistingDataWhole(
      String pan) async {
    var url = '$link/getExistingDataWhole';
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'pan': pan,
        }));
    var data = existingDataExceptGridModelFromJson(response.body);
    return data;
  }

  Future<List<ExistingDataExceptGridModel>> getExistingDataWholeProprietorship(
      String pan, String udyam) async {
    var url = '$link/getExistingDataWholeProprietorship';
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'pan': pan, 'udyam': udyam}));
    var data = existingDataExceptGridModelFromJson(response.body);
    return data;
  }

  Future<List<MainModel>> showState() async {
    List<MainModel> stateName = [];
    var response = await http.get(Uri.parse("$link/state"));
    var state = json.decode(response.body);
    stateName.add(MainModel(id: 0, name: "---Select State---"));
    for (var element in state) {
      stateName.add(MainModel(
          id: element["fGPtbl_MS_Id"], name: element["fGPtbl_MS_Name"]));
    }
    return stateName;
  }

  Future<List<MainModel>> showCity() async {
    List<MainModel> cityName = [];
    var response = await http.get(Uri.parse("$link/city"));
    var state = json.decode(response.body);
    cityName.add(MainModel(id: 0, name: "---Select City---"));
    for (var element in state) {
      cityName.add(MainModel(
          id: element["fGPtbl_MCty_Id"], name: element["fGPtbl_MCty_Name"]));
    }
    return cityName;
  }

  Future<List<MainModel>> showBranch() async {
    List<MainModel> branchName = [];
    var response = await http.get(Uri.parse("$link/branch"));
    var branch = json.decode(response.body);
    branchName.add(MainModel(id: 0, name: "---Select Branch---"));
    for (var element in branch) {
      branchName.add(MainModel(
          id: element["fGPtbl_MB_Id"], name: element["fGPtbl_MB_Name"]));
    }
    return branchName;
  }

  Future<List<MainModel>> showConstitution() async {
    List<MainModel> constitutionName = [];
    var response = await http.get(Uri.parse("$link/const"));
    var consti = json.decode(response.body);
    constitutionName
        .add(MainModel(id: 0, name: "---Select Constitution Type---"));
    for (var element in consti) {
      constitutionName.add(MainModel(
          id: element["fGPtbl_CUnit_Constitution_Id"],
          name: element["fGPtbl_CUnit_Constitution_Name_POI"]));
    }
    return constitutionName;
  }

  Future<List<MainModel>> checkCity(String stateid) async {
    List<MainModel> cityNames = [];
    if (stateid == "") {
      cityNames.add(MainModel(id: 0, name: "---Select City---"));
      return cityNames;
    } else {
      var response = await http.post(Uri.parse("$link/checkcity"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'stateid': stateid,
          }));
      var state = json.decode(response.body);
      cityNames.add(MainModel(id: 0, name: "---Select City---"));
      for (var element in state) {
        cityNames.add(MainModel(
            id: element["fGPtbl_MCty_Id"], name: element["fGPtbl_MCty_Name"]));
      }
      return cityNames;
    }
  }

  Future<List<MainModel>> showSocial() async {
    List<MainModel> socialNames = [];
    var response = await http.get(Uri.parse("$link/social"));
    var social = json.decode(response.body);
    socialNames
        .add(MainModel(id: 0, name: "--Select Enterprise Social Category--"));
    for (var element in social) {
      socialNames.add(MainModel(
          id: element["fGPtbl_CUnit_CC_Id"],
          name: element["fGPtbl_CUnit_CC_Name"]));
    }
    return socialNames;
  }

  Future<List<MainModel>> showEntrepreneur() async {
    List<MainModel> entrepreneurNames = [];
    var response = await http.get(Uri.parse("$link/entrepreneur"));
    var entrepreneur = json.decode(response.body);
    entrepreneurNames.add(
        MainModel(id: 0, name: "-- Select Special Category of Entrepreneur--"));
    for (var element in entrepreneur) {
      entrepreneurNames.add(MainModel(
          id: element["fGPtbl_CUnit_CA_Id"],
          name: element["fGPtbl_CUnit_CA_Name"]));
    }
    return entrepreneurNames;
  }

  Future<List<MainModel>> showUnitSize() async {
    List<MainModel> unitSizeNames = [];
    var response = await http.get(Uri.parse("$link/size"));
    var size = json.decode(response.body);
    unitSizeNames.add(MainModel(id: 0, name: "--Select Category Unit Size--"));
    for (var element in size) {
      unitSizeNames.add(MainModel(
          id: element["fGPtbl_CUnit_CUS_Id"],
          name: element["fGPtbl_CUnit_CUS_Name"]));
    }
    return unitSizeNames;
  }

  Future<List<MainModel>> showNature() async {
    List<MainModel> natureNames = [];
    natureNames.add(MainModel(id: 0, name: "--Select Category Unit Size--"));
    natureNames.add(MainModel(id: 1, name: "Manufacturing"));
    natureNames.add(MainModel(id: 2, name: "Services"));
    return natureNames;
  }

  Future<String> getState(String stateid) async {
    var response = await http.post(Uri.parse("$link/getState"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'stateid': stateid,
        }));
    // var state = json.decode(response.body);
    return response.body.toString();
  }

  Future<List<MainModel>> showAct() async {
    List<MainModel> actNames = [];
    actNames.add(MainModel(id: 0, name: "--Select--"));
    actNames.add(MainModel(id: 1, name: "Indian Factory Act 1948"));
    actNames.add(MainModel(id: 2, name: "Shops & Establishment Act."));
    return actNames;
  }

  //Step 2
  Future<bool> insertStep2(
      DateOfIncorporation, DateOfCommencement, constitutionStep2) async {
    var uri = "$link/insertStep2";

    // change date format to mm-dd-yyyy
    List<String> parts = DateOfIncorporation.split('-');
    String formattedDateofincorporation = '${parts[1]}-${parts[0]}-${parts[2]}';

    List<String> parts2 = DateOfCommencement.split('-');
    String formattedDateofcommencement =
        '${parts2[1]}-${parts2[0]}-${parts2[2]}';

    final prefs = await SharedPreferences.getInstance();
    var fgptblCunitCompanyid = prefs.getString("step1OutputCompanyId");

    var response = await http.post(Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'fGPtbl_CUnit_CompanyId': fgptblCunitCompanyid,
          'DateOfIncorporation': formattedDateofincorporation,
          "DateOfCommencement": formattedDateofcommencement,
          "constitutionStep2": constitutionStep2
        }));
    if (response.statusCode == 200) {
      print('Data inserted Step2 successfully');
      return true;
    } else {
      print('Failed to insert data Step2');
      return false;
    }
  }

  Future<bool> insertProprietorStep2(
      {String name = '',
      String address = '',
      String pin = '',
      String state = '',
      String city = '',
      String telephone = '',
      String shareholding = '',
      String email = '',
      String lengthOfExperience = '',
      String adhar = '',
      int delete = 0}) async {
    var uri = "$link/insertProprietorStep2";
    final prefs = await SharedPreferences.getInstance();
    var fgptblCunitCompanyid = prefs.getString("step1OutputCompanyId");
    print("iteration");
    var response = await http.post(Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "CompanyId": fgptblCunitCompanyid,
          "DirectorName": name,
          "DirectorAddress": address,
          "DirectorPincode": pin,
          "DirectorStateId": state,
          "DirectorCityId": city,
          "DirectorTelephone": telephone,
          "DirectorShare": shareholding,
          // "CreatedBYId": 1,
          "Email": email,
          "Experience": lengthOfExperience,
          "Adhar": adhar,
          "Delete": delete
        }));
    if (response.statusCode == 200) {
      print('propritor inserted Step2 successfully');
      return true;
    } else {
      print('Failed to insert propritor data Step2');
      return false;
    }
  }

  Future fetch_CUnitId_by_CompanyId_Step2() async {
    final prefs = await SharedPreferences.getInstance();
    var fgptblCunitCompanyid = prefs.getString("step1OutputCompanyId");
    var uri = "$link/FetchCUnitId_by_CompanyId_Step2";
    var response = await http.post(Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "fGPtbl_CUnit_CompanyId": fgptblCunitCompanyid,
        }));
    if (response.statusCode == 200) {
      print('Data fetched For Step2 successfully');
      var data = jsonDecode(response.body);
      Step2FetchedData_ForStatusofApplicantMSE temp =
          Step2FetchedData_ForStatusofApplicantMSE.fromJson(data[0]);
      print(temp.fGPtblCUnit3A);
      //save AllCunits ID and data
      List<Step2FetchedData_ForStatusofApplicantMSE> saveAllCunitsId = [];
      for (int i = 0; i < data.length; i++) {
        Step2FetchedData_ForStatusofApplicantMSE temp =
            Step2FetchedData_ForStatusofApplicantMSE.fromJson(data[i]);
        saveAllCunitsId.add(temp);
      }

      final jsonData = saveAllCunitsId
          .map((address) => CunitaddressToJson(address))
          .toList();

      await prefs.setStringList("saveAllCunitsId", jsonData);
print("temp- $temp");
print("temp- $temp");
      return temp;
    } else {
      print('Failed to fetched data Step2');
      return false;
    }
  }

  Future fetchDataForProprietorStep2() async {
    final prefs = await SharedPreferences.getInstance();
    var fgptblCunitCompanyid = prefs.getString("step1OutputCompanyId");
    var uri = "$link/fetchDataForProprietorStep2";
    var response = await http.post(Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "fGPtbl_Company_Directors_CompanyId": fgptblCunitCompanyid,
        }));
    if (response.statusCode == 200) {
      print('Data fetched For Step2 successfully');
      var data = jsonDecode(response.body);
      List<Step2_Data_Fetched_ForProprietor> temp = [];
      for (int i = 0; i < data.length; i++) {
        temp.add(Step2_Data_Fetched_ForProprietor.fromJson(data[i]));
      }
      return temp;
    } else {
      print('Failed to fetched data Step2');
      return false;
    }
  }

  //step 3
  Future<bool> insertStep3({
    fGPtbl_CUnit_Id,
    fGPtbl_CUnit_CompanyId,
    fGPtbl_CUnit_3D,
    fGPtbl_CUnit_3E,
    fGPtbl_CUnit_3F = null,
    fGPtbl_CUnit_3G = null,
    fGPtbl_CUnit_3H = null,
    fGPtbl_CUnit_3I = null,
    fGPtbl_CUnit_3J = null,
    fGPtbl_CUnit_3K1 = null,
    fGPtbl_CUnit_3L = null,
    fGPtbl_CUnit_3M = null,
    fGPtbl_CUnit_3N = null,
    fGPtbl_CUnit_3O = null,
    fGPtbl_CUnit_4A,
    fGPtbl_CUnit_4B,
    UserId = 0,
    ErrorId = 0,
  }) async {
    var uri = "$link/insertStep3";

    print("iteration");
    var response = await http.post(Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "fGPtbl_CUnit_Id": fGPtbl_CUnit_Id,
          "fGPtbl_CUnit_CompanyId": fGPtbl_CUnit_CompanyId,
          "fGPtbl_CUnit_3D": fGPtbl_CUnit_3D,
          "fGPtbl_CUnit_3E": fGPtbl_CUnit_3E,
          "fGPtbl_CUnit_3F": fGPtbl_CUnit_3F,
          "fGPtbl_CUnit_3G": fGPtbl_CUnit_3G,
          "fGPtbl_CUnit_3H": fGPtbl_CUnit_3H,
          "fGPtbl_CUnit_3I": fGPtbl_CUnit_3I,
          "fGPtbl_CUnit_3J": fGPtbl_CUnit_3J,
          "fGPtbl_CUnit_3K1": fGPtbl_CUnit_3K1,
          "fGPtbl_CUnit_3L": fGPtbl_CUnit_3L,
          "fGPtbl_CUnit_3M": fGPtbl_CUnit_3M,
          "fGPtbl_CUnit_3N": fGPtbl_CUnit_3N,
          "fGPtbl_CUnit_3O": fGPtbl_CUnit_3O,
          "fGPtbl_CUnit_4A": fGPtbl_CUnit_4A,
          "fGPtbl_CUnit_4B": fGPtbl_CUnit_4B,
          "UserId": UserId,
          "ErrorId": ErrorId,
        }));
    if (response.statusCode == 200) {
      print('Data inserted Step3 successfully');
      return true;
    } else {
      print('Failed to insert data Step3');
      return false;
    }
  }

  Future fetchDataForStep3(fGPtbl_CUnit_Id) async {
    var uri = "$link/fetchDataForStep3";
    var response = await http.post(Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "fGPtbl_CUnit_Id": fGPtbl_CUnit_Id,
        }));
    if (response.statusCode == 200) {
      print('Data fetched For Step3 successfully');
      var data = jsonDecode(response.body);
      Step3_Data_Fetched_ForUpperFields temp =
          Step3_Data_Fetched_ForUpperFields.fromJson(data[0]);

      return temp;
    } else {
      print('Failed to fetched data Step2');
      return false;
    }
  }

  // insert store

  static Future<List<Step2FetchedData_ForStatusofApplicantMSE>>
      loadCunitAddressList() async {
    final prefs = await SharedPreferences.getInstance();
    final addressJsonList = prefs.getStringList('saveAllCunitsId');
    if (addressJsonList != null) {
      return addressJsonList.map((json) => CunitaddressFromJson(json)).toList();
    }
    return [];
  }

  Future<bool> insertStoreStep3({
    required String location,
    required String Description,
    required String BIS,
    required String Model,
    required String Size,
    required String Capacity,
    required int NumberOfShifts,
    required int SerialNo,
    required int delete,
  }) async {
    var uri = "$link/insertStoreStep3";

    int Cunit = 0;
    final CunitAddressList = await loadCunitAddressList();
    for (int i = 0; i < CunitAddressList.length; i++) {
      if (CunitAddressList[i].fGPtblCUnit1BFactoryAddress == location) {
        Cunit = CunitAddressList[i].fGPtblCUnitId!;
      }
    }
    print("Cunit= $Cunit");
    var response = await http.post(Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "Cunit": Cunit,
          "Description": Description,
          "BIS": BIS,
          "Model": Model,
          "Size": Size,
          "Capacity": Capacity,
          "NumberOfShifts": NumberOfShifts,
          "SerialNo": SerialNo,
          "Delete": delete
        }));
    if (response.statusCode == 200) {
      print('Store inserted Step3 successfully');
      return true;
    } else {
      print('Store Failed to insert data Step3');
      return false;
    }
  }

  Future fetchStoreForStep3() async {
    final prefs = await SharedPreferences.getInstance();
    var Companyid = prefs.getString("step1OutputCompanyId");
    var uri = "$link/fetchStoreForStep3";
    var response = await http.post(Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "Companyid": Companyid,
        }));
    if (response.statusCode == 200) {
      print('Data Store fetched For Step3 successfully');
      var data = jsonDecode(response.body);

      List<Step3_Data_Fetched_ForStore> fetchedStoreFromApi = [];

      for (int i = 0; i < data.length; i++) {
        Step3_Data_Fetched_ForStore temp =
            Step3_Data_Fetched_ForStore.fromJson(data[i]);
        fetchedStoreFromApi.add(temp);
      }
      return fetchedStoreFromApi;
    } else {
      print('Failed to fetched data Step2');
      return false;
    }
  }

  Future insertStep4({
    required int cunitId,
    required int companyId,
    required String address,
    required String telNo,
    required String horsePowerAllotted,
    required String horsePowerInstalled,
    required String description,
    required String landBuilding,
    required String plantMachinery,
    required String equipmentsTools,
    required String currentAssets,
    required String currentAssetsServiceSector,
    required String detailsOfPlantMachinery,
    required String technicalInformation,
    required String qualityControl,
    required String detailsOfTestingMachinery,
    required String fullyTested,
    required String resultOfOperations,
    required String nameAndAddressBankers,
    required String bisMarked,
    required String isoCertification,
    required String nameConfirm,
    required String designationConfirm,
  }) async {
    var uri = "$link/insertStep4";

    var response = await http.post(Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "cunitId": cunitId,
          "companyId": companyId,
          "address": address,
          "telNo": telNo,
          "horsePowerAllotted": horsePowerAllotted,
          "horsePowerInstalled": horsePowerInstalled,
          "description": description,
          "landBuilding": landBuilding,
          "plantMachinery": plantMachinery,
          "equipmentsTools": equipmentsTools,
          "currentAssets": currentAssets,
          "currentAssetsServiceSector": currentAssetsServiceSector,
          "detailsOfPlantMachinery": detailsOfPlantMachinery,
          "technicalInformation": technicalInformation,
          "qualityControl": qualityControl,
          "detailsOfTestingMachinery": detailsOfTestingMachinery,
          "fullyTested": fullyTested,
          "resultOfOperations": resultOfOperations,
          "nameAndAddressBankers": nameAndAddressBankers,
          'bisMarked': bisMarked,
          'isoCertification': isoCertification,
          "nameConfirm": nameConfirm,
          "designationConfirm": designationConfirm,
        }));
    if (response.statusCode == 200) {
      print('Step 4 inserted');
      return true;
    } else {
      print('failed to insert step 4');
      return false;
    }
  }

  Future insertStep4CertificateProprietorPartnerDirectorsStatus(
      String cunit, String companyId) async {
    var uri = "$link/insertStep4CertificateProprietorPartnerDirectorsStatus";
    var response = await http.post(Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"cunitId": cunit, "conpanyId": companyId}));

    if (response.statusCode == 200) {
      print('Step 4 Certificate inserted');
      var data = jsonDecode(response.body);
      return data;
    } else {
      print('failed to insert step 4 Certificate');
      return false;
    }
  }

  Future<List<Step4FetchModel>> fetchStep4(companyId) async {
    var uri = "$link/fetchStep4";
    var response = await http.post(Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
        },

        body: jsonEncode({
          "companyId": companyId
        })
    );


    if (response.statusCode == 200) {
      List<Step4FetchModel> data = step4FetchModelFromJson(response.body);
      print("Data Fetched for step4 Successful");
      return data;
    } else {
      List<Step4FetchModel> data = [];
      print("Data Fetched for step4 Failed");
      return data;
    }
  }

  Future<int> insertPerformanceSheetData(String xmlData , String companyId) async{
    var uri = "$link/insertPerformanceSheetdata";
    var response = await http.post(Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "xmlData": xmlData,
          "companyId": companyId
        })
    );

    return response.statusCode;
  }


  Future<List<DocumentToBeUploadedModel>> documentToBeUploadedList(
      String companyId) async {
    var uri = "$link/fetchDocumentsToBeUploaded";
    var response = await http.post(Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "unitId": companyId,
        }));
    List<DocumentToBeUploadedModel> results =
        documentToBeUploadedModelFromJson(response.body);
    return results;
  }

  Future<String> uploadDocuments(
      String companyId, String path, String name, String documentType) async {
    var uri = "$link/uploadDocuments";
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(uri),
    );
    request.files.add(await http.MultipartFile.fromPath('file', path));

    request.fields["cunit"] = companyId;
    request.fields["documentType"] = documentType;

    var res = await request.send();
    return res.statusCode.toString();
  }

  Future<int> deleteUploadedDetailsDocuments(
      String companyId, String documentName) async {
    var uri = "$link/deleteUploadedDetailsDocuments";
    var response = await http.post(Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "unitId": companyId,
          "documentName": documentName,
        }));
    var results = jsonDecode(response.body);
    int errorId = int.parse(results["ErrorId"]);
    return errorId;
  }

  Future<String> step5Complete(String companyId, String cunit)async{
    var uri = "$link/step5Complete";
    var response = await http.post(Uri.parse(uri),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "companyId": companyId,
          "cunit": cunit,
        }));
    var results = jsonDecode(response.body);
    String Referenece = results["Referenece"];
    return Referenece;
  }
}
