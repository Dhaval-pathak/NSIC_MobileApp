import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsic/Models/expansion_panel_model.dart';
import 'package:nsic/Providers/progress_indicator.dart';
import 'package:nsic/Utilities/validators_for_component1.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/Step2_Data_Fetched_ForProprietor.dart';
import '../../Models/Step2_Data_Fetched_ForStatusOfApplicantMSE.dart';
import '../../Utilities/customAppbar.dart';
import '../../Widgets/Proprietor having stake in the MSE unit/proprietor_model.dart';
import '../../Widgets/Proprietor having stake in the MSE unit/proprietor_prefs.dart';
import '../../api_call.dart';
import 'components_3.dart';

class Component2 extends StatefulWidget {
  const Component2({super.key});

  @override
  State<Component2> createState() => _Component2State();
}

class _Component2State extends State<Component2> {
  bool _isLoading = true;
  late TextEditingController inCopDate;
  late TextEditingController productionDate;
  late TextEditingController constControllerStep2;
  final GlobalKey<FormState> formKey0 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  List<ExpansionPanelModel> _steps = [];

  @override
  void initState() {
    super.initState();
    initializeControllers();
    saveAndLoad();

    _steps = getStep2(
      formKey0: formKey0,
      formKey1: formKey1,
      inCopDate: inCopDate,
      productionDate: productionDate,
      constController_Step2: constControllerStep2,
    );
  }

  void initializeControllers() {
    inCopDate = TextEditingController();
    productionDate = TextEditingController();
    constControllerStep2 = TextEditingController();
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

  loadControllerValuesFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("loaded ${prefs.getString("inCopDate")}");
    print("loaded ${prefs.getString("productionDate")}");
    inCopDate.text = prefs.getString("inCopDate") ?? "";
    productionDate.text = prefs.getString("productionDate") ?? "";
    constControllerStep2.text = prefs.getString("constController_Step2") ?? "0";
  }

  saveControllerValuesToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ApiCall api = ApiCall();

    //  Step 2
    //  Fetching for step 2
    Step2FetchedData_ForStatusofApplicantMSE data =
        await api.fetch_CUnitId_by_CompanyId_Step2();

    if(data.fGPtblCUnit3A==""){
      setState(() {
        _isLoading=false;
      });
      return;
    }
    // change date format to dd-mm-yyyy

    List<String>? step2partsOfCopdate = data.fGPtblCUnit3A?.split('/');
    String step2formatteddateOfCopdate =
        '${step2partsOfCopdate?[1]}-${step2partsOfCopdate?[0]}-${step2partsOfCopdate?[2]}';

    List<String>? step2partsOfProductiondate = data.fGPtblCUnit3B?.split('/');
    String step2formatteddateOfProductiondate =
        '${step2partsOfProductiondate?[1]}-${step2partsOfProductiondate?[0]}-${step2partsOfProductiondate?[2]}';

    prefs.setString("inCopDate", step2formatteddateOfCopdate);
    prefs.setString("productionDate", step2formatteddateOfProductiondate);
    prefs.setString("constController_Step2",
        data.fGPtblCUnit3C123ConstitutionId.toString());

    //  Step 2 Proprietor fetching
    List<Step2_Data_Fetched_ForProprietor> dataProprietor =
        await api.fetchDataForProprietorStep2();

    List<ProprietorModel> proprietorList = [];
    for (int i = 0; i < dataProprietor.length; i++) {
      ProprietorModel temp = ProprietorModel(
          name: dataProprietor[i].fGPtblCompanyDirectorsName!,
          address: dataProprietor[i].fGPtblCompanyDirectorsAddress!,
          state: dataProprietor[i].fGPtblCompanyDirectorsStateId!.toString(),
          adhar: dataProprietor[i].fGPtblCompanyDirectorsAdhar!,
          city: dataProprietor[i].fGPtblCompanyDirectorsCityId!.toString(),
          email: dataProprietor[i].fGPtblCompanyDirectorsEmail!,
          lengthOfExperience:
              dataProprietor[i].fGPtblCompanyDirectorsExperience!.toString(),
          pin: dataProprietor[i].fGPtblCompanyDirectorsZip!,
          shareholding: dataProprietor[i].fGPtblCompanyDirectorsShareholder!,
          telephone: dataProprietor[i].fGPtblCompanyDirectorsPhone!);
      proprietorList.add(temp);
    }

    ProprietorPrefs.saveProprietor(proprietorList);
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
        body: Container(
          color: Color(0x69fffadd),
          child: _isLoading?Center(
            child: CircularProgressIndicator(),
          ):SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(5, 20, 5, 50),
              child: Column(
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
                                        padding: EdgeInsets.symmetric(horizontal: 11),
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
      ),
    );
  }

  ValidatorForComponent1 validator = ValidatorForComponent1();

  bool checkStatusApplication() {
    if (validator.validationForValue_0(context, inCopDate.text,
            "Date of Incorporation", "Status of applicant MSE") ==
        false) {
      setState(() {
        _currentExpandedIndex = 0;
      });
      return false;
    }
    if (validator.validationForValue_0(context, productionDate.text,
            "Date of commencement", "Status of applicant MSE") ==
        false) {
      setState(() {
        _currentExpandedIndex = 0;
      });
      return false;
    }
    if (validator.validationForValue_0(context, constControllerStep2.text,
            "Constitution of the MSE", "Status of applicant MSE") ==
        false) {
      setState(() {
        _currentExpandedIndex = 0;
      });
      return false;
    }
    return true;
  }

  Future<bool> validateForProprietor() async {
    bool isValid = await ValidatorForComponent1().validateForProprietor(context,
        "Minimum One Proprietor is Required"); // Await the function call

    if (isValid) {
      return true;
    } else {
      setState(() {
        _currentExpandedIndex = 1;
      });
      return false;
    }
  }

  submitData() async {
    if (checkStatusApplication() == false) {
      return;
    }
    if (await validateForProprietor() == false) {
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
                // Provider.of<ProgressIndicatorProvider>(context, listen: false)
                //     .goForward();
                // Navigator.of(context).pop();
                ApiCall api = ApiCall();
                List<ProprietorModel> proprietorList =
                    await ProprietorPrefs.loadProprietor();
                bool isInserted = true;
                bool isInserted2 = true;
                isInserted = await api.insertStep2(
                  inCopDate.text,
                  productionDate.text,
                  constControllerStep2.text,
                );
                if (proprietorList.isNotEmpty) {
                  for (int i = 0; i < proprietorList.length; i++) {
                    isInserted2 = await api.insertProprietorStep2(
                        name: proprietorList[i].name,
                        address: proprietorList[i].address,
                        pin: proprietorList[i].pin,
                        state: proprietorList[i].state,
                        city: proprietorList[i].city,
                        telephone: proprietorList[i].telephone,
                        shareholding: proprietorList[i].shareholding,
                        email: proprietorList[i].email,
                        lengthOfExperience:
                            proprietorList[i].lengthOfExperience,
                        adhar: proprietorList[i].adhar,
                        delete: 0);
                  }
                }
                Get.back();

                if (isInserted == true && isInserted2 == true) {
                  successfulDataInsert();
                } else {
                  failureDuringInsert();
                  isInserted = true;
                  isInserted2 = true;
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
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
                  .updateScreenIndex(2);
              Get.to(Component3());
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
