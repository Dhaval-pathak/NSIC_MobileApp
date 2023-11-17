import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsic/Models/expansion_panel_model.dart';
import 'package:nsic/Providers/progress_indicator.dart';
import 'package:nsic/Screens/Components/components_4.dart';
import 'package:nsic/Utilities/customAppbar.dart';
import 'package:nsic/Utilities/validators_for_component1.dart';
import 'package:nsic/Widgets/Add%20Store/store_prefs.dart';
import 'package:nsic/api_call.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/Step2_Data_Fetched_ForStatusOfApplicantMSE.dart';
import '../../Models/Step3_Data_Fetched_ForStore.dart';
import '../../Models/Step3_Data_Fetched_ForUpperFields.dart';
import '../../Widgets/Add Store/store_model.dart';

class Component3 extends StatefulWidget {
  const Component3({super.key});

  @override
  State<Component3> createState() => _Component3State();
}

class _Component3State extends State<Component3> {
  bool _isLoading = true;
  late TextEditingController actController;
  late TextEditingController holdingController;
  late TextEditingController gemController;
  late TextEditingController suppliersController;
  final GlobalKey<FormState> formKey0 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  List<ExpansionPanelModel> _steps = [];

  void initializeControllers() {
    actController = TextEditingController();
    holdingController = TextEditingController();
    gemController = TextEditingController();
    suppliersController = TextEditingController();
  }

  loadControllerValuesFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    actController.text = prefs.getString("actController") ?? "1";
    holdingController.text = prefs.getString("holdingController") ?? "N.A.";
    gemController.text = prefs.getString("gemController") ?? "N.A.";
    suppliersController.text = prefs.getString("suppliersController") ?? "N.A.";
    // inCopDate.text = prefs.getString("inCopDate") ?? "";
  }

  saveControllerValuesToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ApiCall api = ApiCall();
    final addressList = await loadCunitAddressList();
    Step3_Data_Fetched_ForUpperFields data = await api.fetchDataForStep3(addressList[0].fGPtblCUnitId);
    prefs.setString("actController", data.fGPtblCUnit3D == null ? "1": data.fGPtblCUnit3D.toString());
    prefs.setString("holdingController", data.fGPtblCUnit3E!);
    prefs.setString("gemController", data.fGPtblCUnit4A!);
    prefs.setString("suppliersController", data.fGPtblCUnit4B!);
    // prefs.setString("inCopDate", inCopDate.text);

    //  Step 3 Store fetching
    List<Step3_Data_Fetched_ForStore> dataStoreFromApi =
        await api.fetchStoreForStep3();

    List<StoreModel> storeList = [];
    String? location = '';

    for (int i = 0; i < dataStoreFromApi.length; i++) {
      for (int j = 0; j < addressList.length; j++) {
        if (addressList[j].fGPtblCUnitId ==
            dataStoreFromApi[i].fGPtblCUnitStoreUnitId) {
          location = addressList[j].fGPtblCUnit1BFactoryAddress;
          break;
        }
      }
      StoreModel temp = StoreModel(
          description: dataStoreFromApi[i]
              .fGPtblCUnitStoreDescriptionStoresProducts!
              .toString(),
          location: location!,
          bisSpecification: dataStoreFromApi[i]
              .fGPtblCUnitStoreRefOfBISSpecification!
              .toString(),
          limitingSizeCapacity: dataStoreFromApi[i]
              .fGPtblCUnitStoreLimitingSizeCapacityRating!
              .toString(),
          model: dataStoreFromApi[i].fGPtblCUnitStoreModelBrand!.toString(),
          monthlyProductionCapacity: dataStoreFromApi[i]
              .fGPtblCUnitStoreAnnualProductionCapacity!
              .toString(),
          numberOfShifts:
              dataStoreFromApi[i].fGPtblCUnitStoreNoOfShifts!.toString(),
          sno: dataStoreFromApi[i].fGPtblCUnitStoreSNo!.toString());
      storeList.add(temp);
    }
    StorePrefs.saveStore(storeList);
  }

  @override
  void initState() {
    super.initState();
    initializeControllers();
    saveAndLoad();
    _steps = getStep3(
        actController: actController,
        holdingController: holdingController,
        gemController: gemController,
        suppliersController: suppliersController,
        formKey0: formKey0,
        formKey1: formKey1);
  }

  saveAndLoad() async {
    // saveControllerValuesToSharedPreferences().then((_) {
    //   loadControllerValuesFromSharedPreferences();
    // });
    await saveControllerValuesToSharedPreferences();
    await loadControllerValuesFromSharedPreferences();
    setState(() {
      _isLoading = false; // Mark loading as complete
    });
  }

  int _currentExpandedIndex = -1;

  void _handleExpansion(int index) {
    setState(() {
      _currentExpandedIndex = (_currentExpandedIndex == index) ? -1 : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: CustomAppbar(),
        body:_isLoading?Center(
          child: CircularProgressIndicator(),
        ): SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(5, 20, 5, 50),
            child:
               Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.asset('assets/images/nsic.png'),
                          ),
                          Flexible(
                            child: Text(
                              "Registration under Single Point Registration Scheme",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: List.generate(_steps.length, (index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _handleExpansion(index);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: _currentExpandedIndex == index
                                        ? Color(0xfffff4af)
                                        : Color(0x59f8c335),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      _steps[index].title,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                    ),
                                    trailing: _currentExpandedIndex == index
                                        ? Icon(Icons.arrow_drop_up)
                                        : Icon(Icons.arrow_drop_down_sharp),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Form(
                                // key: _steps[index].key,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                child: AnimatedSize(
                                  duration: Duration(milliseconds: 1000),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xfffdfdff),
                                      // boxShadow:
                                      // BoxShadow(blurRadius: )
                                    ),
                                    child: SingleChildScrollView(
                                      physics: NeverScrollableScrollPhysics(),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 11),
                                      child: _currentExpandedIndex == index
                                          ? _steps[index].body
                                          : SizedBox(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          );
                        }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: submitData,
                            child: Text('Submit'),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  ValidatorForComponent1 validator = ValidatorForComponent1();



  bool checkStep3() {
    if (validator.validationForValue_0(
            context,
            actController.text,
            "Whether your MSE is registered under",
            "Status of applicant MSE (continue from step 2)") ==
        false) {
      setState(() {
        _currentExpandedIndex = 0;
      });
      return false;
    }
    return true;
  }

  submitData() async {
    if (checkStep3() == false) {
      return;
    }

    confirmForSubmission();
  }

  void confirmForSubmission() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to submit the data?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Get.back(); // Close the confirmation dialog
                loadingDialog();
                ApiCall api = ApiCall();
                bool isInserted = true;
                bool isInserted2 = true;
                final prefs = await SharedPreferences.getInstance();
                var fgptblCunitCompanyid =
                    prefs.getString("step1OutputCompanyId");

                final cUnitAddressList = await loadCunitAddressList();


                for (int i = 0; i < cUnitAddressList.length; i++) {
                  isInserted=await api.insertStep3(
                      fGPtbl_CUnit_Id: cUnitAddressList[i].fGPtblCUnitId,

                      fGPtbl_CUnit_CompanyId: fgptblCunitCompanyid,
                      fGPtbl_CUnit_3D: int.parse(actController.text),
                      fGPtbl_CUnit_3E: holdingController.text,
                      fGPtbl_CUnit_4A: gemController.text,
                      fGPtbl_CUnit_4B: suppliersController.text);
                }

                List<StoreModel> storeList = await loadSavedStore();
                if (storeList.isNotEmpty) {
                  for (int i = 0; i < storeList.length; i++) {
                    isInserted2 = await api.insertStoreStep3(
                        location: storeList[i].location,
                        Description: storeList[i].description,
                        BIS: storeList[i].bisSpecification,
                        Model: storeList[i].model,
                        Size: storeList[i].limitingSizeCapacity,
                        Capacity: storeList[i].monthlyProductionCapacity,
                        NumberOfShifts: int.parse(storeList[i].numberOfShifts),
                        SerialNo: int.parse(storeList[i].sno),
                        delete: 0);
                  }
                }

                Get.back();
                if (isInserted == true) {
                  successfulDataInsert();
                } else {
                  failureDuringInsert();
                  isInserted = true;
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Future<List<StoreModel>> loadSavedStore() async {
    List<StoreModel> storeList = await StorePrefs.loadStore();
    return storeList;
  }

  static Future<List<Step2FetchedData_ForStatusofApplicantMSE>>
      loadCunitAddressList() async {
    final prefs = await SharedPreferences.getInstance();
    final addressJsonList = prefs.getStringList('saveAllCunitsId');
    if (addressJsonList != null) {
      return addressJsonList.map((json) => CunitaddressFromJson(json)).toList();
    }
    return [];
  }

  void loadingDialog() {
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
  }

  void successfulDataInsert() {
    Get.defaultDialog(
        title: '',
        content: Column(
          children: const [
            Text(
              'Data inserted Successfully',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back(); // Close the success dialog
              Provider.of<ProgressIndicatorProvider>(context, listen: false)
                  .updateScreenIndex(3);
              Get.to(Component4());
            },
            child: Text('Ok'),
          ),
        ]);
  }

  void failureDuringInsert() {
    Get.defaultDialog(
        content: Column(
          children: const [
            SizedBox(height: 15),
            Text(
              'Some error occurred.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back(); // Close the failure dialog
            },
            child: Text('Please try again later'),
          ),
        ]);
  }
}
