
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nsic/Models/DocumentToBeUploadedModel.dart';
import 'package:nsic/Models/expansion_panel_model.dart';
import 'package:nsic/Providers/progress_indicator.dart';
import 'package:nsic/Screens/Components/components_5.dart';
import 'package:nsic/Utilities/customAppbar.dart';
import 'package:nsic/Utilities/validators_for_component1.dart';
import 'package:nsic/api_call.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart';

import '../../Widgets/Performance Statement/performance_prefs.dart';

import '../../Models/Step2_Data_Fetched_ForStatusOfApplicantMSE.dart';
import '../../Models/step4FetchModel.dart';
import '../../Widgets/CompanyCapital/step_4_capital_model.dart';
import '../../Widgets/CompanyCapital/step_4_capital_pref.dart';
import '../../Widgets/DetailsOfFactory/step_4_factory_model.dart';
import '../../Widgets/DetailsOfFactory/step_4_factory_pref.dart';
import '../../Widgets/TechinalFacilities/step_4_facilities_model.dart';
import '../../Widgets/TechinalFacilities/step_4_facilities_pref.dart';

class Component4 extends StatefulWidget {
  const Component4({Key? key}) : super(key: key);

  @override
  State<Component4> createState() => _Component4State();
}

class _Component4State extends State<Component4> {
  bool _isLoading = true;
  late TextEditingController nameConfirmController;
  late TextEditingController designationConfirmController;
  late TextEditingController fullyTestedController;
  late TextEditingController resultOfOperationsAndFinancialPositionController;
  late TextEditingController nameAndAddressBankersController;
  late TextEditingController bisMarkedController;
  late TextEditingController isoCertificationController;
  final GlobalKey<FormState> formKey0 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey3 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey4 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey5 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey6 = GlobalKey<FormState>();
  List<ExpansionPanelModel> _steps = [];

  void initializeControllers() {
    nameConfirmController = TextEditingController();
    designationConfirmController = TextEditingController();
    fullyTestedController = TextEditingController();
    resultOfOperationsAndFinancialPositionController = TextEditingController();
    nameAndAddressBankersController = TextEditingController();
    bisMarkedController = TextEditingController();
    isoCertificationController = TextEditingController();
  }

   loadControllerValuesFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nameConfirmController.text = prefs.getString("nameConfirmController") ?? "";
    designationConfirmController.text =
        prefs.getString("designationConfirmController") ?? "";
    fullyTestedController.text =
        prefs.getString("fullyTestedController") ?? "N.A.";
    resultOfOperationsAndFinancialPositionController.text =
        prefs.getString("resultOfOperationsAndFinancialPositionController") ??
            "N.A.";
    nameAndAddressBankersController.text =
        prefs.getString("nameAndAddressBankersController") ?? "N.A.";
    bisMarkedController.text = prefs.getString("bisMarkedController") ?? "N.A.";
    isoCertificationController.text =
        prefs.getString("isoCertificationController") ?? "N.A.";
  }

   saveControllerValuesToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ApiCall api = ApiCall();

    String? companyid = prefs.getString("step1OutputCompanyId");
    List<Step4FetchModel> data = await api.fetchStep4(companyid);


    prefs.setString("fullyTestedController",data[0].fGPtblCUnit8);
    prefs.setString("resultOfOperationsAndFinancialPositionController",
        data[0].fGPtblCUnit10);
    prefs.setString("nameAndAddressBankersController",
        data[0].fGPtblCUnit11);
    prefs.setString("bisMarkedController", data[0].fGPtblCUnit12A);
    prefs.setString(
        "isoCertificationController", data[0].fGPtblCUnit12B);
    prefs.setString("nameConfirmController", data[0].fGPtblCUnit13A.toString());
    prefs.setString(
        "designationConfirmController", data[0].fGPtblCUnit13B);



  //  Step 4 factory/godown details fetch
    List<Step4FactoryModel> factoryDetailsList = [];
    List<Step4CapitalModel> capitalDetailsList = [];
    List<Step4FacilitiesModel> technicalFacilitiesList = [];

for(int i=0;i<data.length;i++){
  Step4FactoryModel temp=Step4FactoryModel(
      step4factoryaddressController: data[i].fGPtblCUnit1BFactoryAddress,
    step4AddressController: data[i].fGPtblCUnit5A1,
    step4teleController: data[i].fGPtblCUnit5A2,
    step4powerController: data[i].fGPtblCUnit5Bb1,
    step4power2Controller: data[i].fGPtblCUnit5Bb2,
    step4descController: data[i].fGPtblCUnit5C
  );
  factoryDetailsList.add(temp);

  Step4CapitalModel temp2=Step4CapitalModel(
    step4CapitalAddressController:  data[i].fGPtblCUnit1BFactoryAddress,
    step4CapitalLandController: data[i].fGPtblCUnit6A1.toString(),
    step4CapitalMachineController: data[i].fGPtblCUnit6A2.toString(),
    step4CapitalEquipmentController: data[i].fGPtblCUnit6A3.toString(),
    step4CapitalAssetsController: data[i].fGPtblCUnit6B.toString(),
    step4CapitalServiceAssetsController: data[i].fGPtblCUnit6B2.toString(),
step4CapitalTotalController: "0.00"
  );
  capitalDetailsList.add(temp2);


  Step4FacilitiesModel temp3=Step4FacilitiesModel(
    facilitiesAddressController:data[i].fGPtblCUnit1BFactoryAddress,
    plantAndMachineDetailsController: data[i].fGPtblCUnit7A ,
    technicalFlowDetailsController: data[i].fGPtblCUnit7C,
    qualityControlDetailsController: data[i].fGPtblCUnit7D,
    testingDetailsController: data[i].fGPtblCUnit7E,

  );
  technicalFacilitiesList.add(temp3);



}
    Step4FactoryPrefs.saveStore(factoryDetailsList);
    Step4CapitalPrefs.saveCapital(capitalDetailsList);
    Step4FacilitiesPrefs.saveFacilities(technicalFacilitiesList);
  }

  @override
  void initState() {
    super.initState();
    initializeControllers();
    saveAndLoad();
    _steps = getStep4(
        formKey0: formKey0,
        fullyTestedController: fullyTestedController,
        resultOfOperationsAndFinancialPositionController:
            resultOfOperationsAndFinancialPositionController,
        nameAndAddressBankersController: nameAndAddressBankersController,
        bisMarkedController: bisMarkedController,
        isoCertificationController: isoCertificationController,
        nameConfirmController: nameConfirmController,
        designationConfirmController: designationConfirmController,
        formKey1: formKey1,
        formKey2: formKey2,
        formKey3: formKey3,
        formKey4: formKey4,
        formKey5: formKey5,
        formKey6: formKey6);
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
        body: _isLoading?Center(
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      child: Text('Save & Continue'),
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

  bool checkStep4() {
    bool checkSignature = validator.validationForValue_0(
        context,
        nameConfirmController.text,
        "Name of the signatory of this application",
        "Additional/Optional information");
    bool checkDesignation = validator.validationForValue_0(
        context,
        designationConfirmController.text,
        "Designation of the signatory of this application",
        "Additional/Optional information");
    if (checkSignature == false) {
      setState(() {
        _currentExpandedIndex = 5;
      });
      return false;
    }
    if (checkDesignation == false) {
      setState(() {
        _currentExpandedIndex = 5;
      });
      return false;
    }
    return true;
  }

  Future<bool> checkForPerformanceStatemnet() async {
    bool isValid = await validator.validateForPerformanceStatemnet(
        context, "Pls add at least One performance statemnet");
    if (isValid) {
      return true;
    } else {
      setState(() {
        _currentExpandedIndex = 6;
      });
      return false;
    }
  }

  submitData() async {
    if (checkStep4() == false) {
      return;
    }
    if (await checkForPerformanceStatemnet() == false) {
      return;
    }
    final CunitAddressList = await loadCunitAddressList();
    final prefs = await SharedPreferences.getInstance();
    String companyid = prefs.getString("step1OutputCompanyId")!;
    List<Step4FactoryModel> Step4AddressList =
    await Step4FactoryPrefs.loadStore();
    List<Step4CapitalModel> Step4CapitalList = await Step4CapitalPrefs.loadCapital();

    List<Step4FacilitiesModel> Step4FacilitiesList = await Step4FacilitiesPrefs.loadFacilities();

    confirmForSubmission(CunitAddressList,companyid,Step4AddressList,Step4CapitalList,Step4FacilitiesList);
  }

  void confirmForSubmission(List<Step2FetchedData_ForStatusofApplicantMSE> CunitAddressList,
      String companyid,
      List<Step4FactoryModel> Step4AddressList, List<Step4CapitalModel> Step4CapitalList,
      List<Step4FacilitiesModel> Step4FacilitiesList) {
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
                int status=0;
                for (int i = 0; i < CunitAddressList.length; i++) {
                  api.insertStep4CertificateProprietorPartnerDirectorsStatus(CunitAddressList[i].fGPtblCUnitId!.toString(),
                      companyid
                  );
                  for (int j = 0; j < Step4AddressList.length; j++) {
                    if (CunitAddressList[i].fGPtblCUnit1BFactoryAddress ==
                        Step4AddressList[j].step4factoryaddressController) {

                      isInserted=await api.insertStep4(
                      cunitId: CunitAddressList[i].fGPtblCUnitId!,
                           companyId: int.parse(companyid),
                           address: Step4AddressList[j].step4AddressController,
                           telNo: Step4AddressList[j].step4teleController,
                           horsePowerAllotted: Step4AddressList[j].step4powerController,
                           horsePowerInstalled: Step4AddressList[j].step4power2Controller,
                           description: Step4AddressList[j].step4descController,

                           landBuilding: Step4CapitalList[j].step4CapitalLandController,
                           plantMachinery: Step4CapitalList[j].step4CapitalMachineController,
                          equipmentsTools:Step4CapitalList[j].step4CapitalEquipmentController,
                          currentAssets:Step4CapitalList[j].step4CapitalAssetsController,
                          currentAssetsServiceSector:Step4CapitalList[j].step4CapitalServiceAssetsController,

                          detailsOfPlantMachinery:Step4FacilitiesList[j].plantAndMachineDetailsController,
                          technicalInformation:Step4FacilitiesList[j].technicalFlowDetailsController,
                          qualityControl:Step4FacilitiesList[j].qualityControlDetailsController,
                           detailsOfTestingMachinery:Step4FacilitiesList[j].testingDetailsController,



                             fullyTested:fullyTestedController.text,
                          resultOfOperations:resultOfOperationsAndFinancialPositionController.text,
                               nameAndAddressBankers:nameAndAddressBankersController.text,
                               bisMarked:bisMarkedController.text,
                                isoCertification:isoCertificationController.text,
                                nameConfirm:nameConfirmController.text,
                              designationConfirm:designationConfirmController.text,

                         );
                    }
                  }

                  if(isInserted==false ) break;

                }
                final performanceJsonList = await PerformancePreferences.loadPerformanceList();
                final document = XmlDocument();
                final root = XmlElement(XmlName('PerformanceSheets'));
                for (int i =0; i< performanceJsonList.length; i++){
                  List<String> parts = performanceJsonList[i].date.split('-');
                  String formattedDate = '${parts[1]}-${parts[0]}-${parts[2]}';

                  List<String> parts2 = performanceJsonList[i].dateDelivery.split('-');
                  String formattedDate2 = '${parts2[1]}-${parts2[0]}-${parts2[2]}';

                  List<String> parts3 =performanceJsonList[i].dateMaterialDelivery.split('-');
                  String formattedDate3 = '${parts3[1]}-${parts3[0]}-${parts3[2]}';

                  final performanceSheet = XmlElement(XmlName('PerformanceSheet'), [XmlAttribute(XmlName("ID"), i.toString())]);
                  final orderNumber = XmlElement(XmlName("OrderNumber"), [], [XmlText(performanceJsonList[i].orderId)]);
                  final date = XmlElement(XmlName("Date_of_ReceiptOrder"), [], [XmlText(formattedDate)]);
                  final desc = XmlElement(XmlName("Store_Produt_Service_Desc"), [], [XmlText(performanceJsonList[i].description)]);
                  final quantity = XmlElement(XmlName("Quantity"), [], [XmlText(performanceJsonList[i].quantity)]);
                  final value = XmlElement(XmlName("Value"), [], [XmlText(performanceJsonList[i].value)]);
                  final nameConsignee = XmlElement(XmlName("Name_Consignee"), [], [XmlText(performanceJsonList[i].nameConsignee)]);
                  final deliveryDueDate = XmlElement(XmlName("DeliveryDueDate"), [], [XmlText(formattedDate2)]);
                  final materialDeliveryDate = XmlElement(XmlName("MaterialDeliveryDate"), [], [XmlText(formattedDate3)]);
                  final despatchingParticulars = XmlElement(XmlName("DespatchingParticulars"), [], [XmlText(performanceJsonList[i].despatchingParticulars)]);
                  final remarks = XmlElement(XmlName("Remarks"), [], [XmlText(performanceJsonList[i].remarks)]);
                  performanceSheet.children.addAll([orderNumber, date, desc, quantity, value, nameConsignee, deliveryDueDate,materialDeliveryDate,despatchingParticulars, remarks ]);
                  root.children.add(performanceSheet);
                }
                document.children.add(root);

                status = await ApiCall().insertPerformanceSheetData(document.toXmlString(pretty: true), companyid);


                Get.back();
                if (isInserted == true && status==200) {
                  successfulDataInsert(CunitAddressList[0].fGPtblCUnitId);
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

  void successfulDataInsert(int? fGPtblCUnitId) {
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
            onPressed: () async {              
              // This is for next step documents
              final prefs = await SharedPreferences.getInstance();
              String companyid = prefs.getString("step1OutputCompanyId")!;
              List<DocumentToBeUploadedModel> data =
              await ApiCall().documentToBeUploadedList(fGPtblCUnitId!.toString());
              Get.back(); // Close the success dialog
              Provider.of<ProgressIndicatorProvider>(context, listen: false)
                  .updateScreenIndex(4);
              Get.to(Component5(
                documents: data,
                companyId: companyid,
              ));
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
