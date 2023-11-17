import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nsic/Providers/progress_indicator.dart';
import 'package:nsic/Screens/Components/components_2.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/existingDataExceptGridModel.dart';
import '../../Models/existingDataModel.dart';
import '../../Models/expansion_panel_model.dart';
import '../../Models/step1Model.dart';
import '../../Utilities/decode.dart';
import '../../Utilities/validators_for_component1.dart';
import '../../Widgets/Add Factory Address/address_detail_model.dart';
import '../../Widgets/Add Factory Address/address_prefs.dart';
import '../../api_call.dart';

class Component1 extends StatefulWidget {
  final Step1Model xmlData;
  final List<ExistingDataModel> existingData;
  final List<ExistingDataExceptGridModel> existingDataMain;
  final int status;
  final int branchId;
  final int constitutionId;

  const Component1(
      {super.key,
      required this.status,
      required this.xmlData,
      required this.existingData,
      required this.existingDataMain,
      required this.branchId,
      required this.constitutionId});

  @override
  _Component1State createState() => _Component1State();
}

class _Component1State extends State<Component1>
    with SingleTickerProviderStateMixin {
  // General
  late TextEditingController panController;
  late TextEditingController udyamController;
  late TextEditingController nameController;
  late TextEditingController dateController;
  late TextEditingController branchController;
  late TextEditingController specialController;
  late TextEditingController ayushController;
  late TextEditingController gstController;
  late TextEditingController shareController;
  late TextEditingController constController;

  // Head office
  late TextEditingController addressController;
  late TextEditingController pinController;
  late TextEditingController stateController;
  late TextEditingController teleController;
  late TextEditingController mobileController;
  late TextEditingController emailController;
  late TextEditingController cityController;

  // Branch
  late TextEditingController branchAddController;
  late TextEditingController branchPinController;
  late TextEditingController branchStateController;
  late TextEditingController branchCityController;
  late TextEditingController branchTeleController;
  late TextEditingController branchEmailController;

  // Extra
  late TextEditingController socialController;
  late TextEditingController entrepreneurController;
  late TextEditingController unitSizeController;

  List<ExpansionPanelModel> _steps = [];
  // var city;
  late GlobalKey<FormState> formKey0;
  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey3 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey4 = GlobalKey<FormState>();

  // bool isDefaultValuesSaved = false;
  @override
  void initState() {
    super.initState();
    formKey0 = GlobalKey<FormState>();

    initializeControllers();
    if (widget.status == 5 || widget.status == 6) {
      saveSharedPrefsForIncompleteApplication().then((_) {

        loadControllerValuesFromSharedPreferences();
      });
    } else if (widget.status == 123) {
      saveSharedPreferencesForNewApplication().then((_) {

        loadControllerValuesFromSharedPreferences();
      });
    } else {

      loadControllerValuesFromSharedPreferences();
    }

    _steps = getStep1Controller(
        // General
        panController: panController,
        udyamController: udyamController,
        nameController: nameController,
        dateController: dateController,
        branchController: branchController,
        specialController: specialController,
        ayushController: ayushController,
        gstController: gstController,
        shareController: shareController,
        constController: constController,

        //Head office
        addressController: addressController,
        pinController: pinController,
        stateController: stateController,
        teleController: teleController,
        mobileController: mobileController,
        emailController: emailController,
        cityController: cityController,

        // Branch
        branchAddController: branchAddController,
        branchPinController: branchPinController,
        branchStateController: branchStateController,
        branchCityController: branchCityController,
        branchTeleController: branchTeleController,
        branchEmailController: branchEmailController,

        // Extra
        socialController: socialController,
        entrepreneurController: entrepreneurController,
        unitSizeController: unitSizeController,
        formKey0: formKey0,
        formKey1: formKey1,
        formKey2: formKey2,
        formKey3: formKey3,
        formKey4: formKey4);
  }

  void initializeControllers() {
    // General
    udyamController = TextEditingController();
    panController = TextEditingController();
    nameController = TextEditingController();
    dateController = TextEditingController();
    branchController = TextEditingController();
    specialController = TextEditingController();
    ayushController = TextEditingController();
    gstController = TextEditingController();
    shareController = TextEditingController();
    constController = TextEditingController();

    // Head office
    addressController = TextEditingController();
    pinController = TextEditingController();
    stateController = TextEditingController();
    teleController = TextEditingController();
    mobileController = TextEditingController();
    emailController = TextEditingController();
    cityController = TextEditingController();

    // Branch
    branchAddController = TextEditingController();
    branchPinController = TextEditingController();
    branchStateController = TextEditingController();
    branchCityController = TextEditingController();
    branchTeleController = TextEditingController();
    branchEmailController = TextEditingController();

    // Extra

    socialController = TextEditingController();
    entrepreneurController = TextEditingController();
    unitSizeController = TextEditingController();
  }

  void loadControllerValuesFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // General
    udyamController.text = prefs.getString('udyamController') ?? '';
    panController.text = prefs.getString('panController') ?? '';
    nameController.text = prefs.getString('nameController') ?? '';
    dateController.text = prefs.getString('dateController') ?? '';
    branchController.text = prefs.getString('branchController') ?? '';
    specialController.text = prefs.getString('specialController') ?? '';
    ayushController.text = prefs.getString('ayushController') ?? '';
    gstController.text = prefs.getString('gstController') ?? '';
    shareController.text = prefs.getString('shareController') ?? '';
    constController.text = prefs.getString('constController') ?? '';

    // Head office
    addressController.text = prefs.getString('addressController') ?? '';
    pinController.text = prefs.getString('pinController') ?? '';
    stateController.text = prefs.getString('stateController') ?? '';
    teleController.text = prefs.getString('teleController') ?? '';
    mobileController.text = prefs.getString('mobileController') ?? '';
    emailController.text = prefs.getString('emailController') ?? '';
    cityController.text = prefs.getString('cityController') ?? '';

    // Branch
    branchAddController.text = prefs.getString('branchAddController') ?? '';
    branchPinController.text = prefs.getString('branchPinController') ?? '';
    branchStateController.text = prefs.getString('branchStateController') ?? '';
    branchCityController.text = prefs.getString('branchCityController') ?? '';
    branchTeleController.text = prefs.getString('branchTeleController') ?? '';
    branchEmailController.text = prefs.getString('branchEmailController') ?? '';

    // Extra
    socialController.text = prefs.getString('socialController') ?? '';
    entrepreneurController.text =
        prefs.getString('entrepreneurController') ?? '';
    unitSizeController.text = prefs.getString('unitSizeController') ?? '';
  }

  saveSharedPrefsForIncompleteApplication() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<AddressDetails> addressList = [];
    for (int i = 0; i < widget.existingData.length; i++) {
      AddressDetails newAddress = AddressDetails(
          address: widget.existingData[i].fGPtblCUnit1BFactoryAddress,
          pin: widget.existingData[i].fGPtblCUnit1BFactoryZip,
          state: widget.existingData[i].fGPtblCUnit1BFactoryStateId.toString(),
          district:
          widget.existingData[i].fGPtblCUnit1BFactoryCityId.toString(),
          tel: widget.existingData[i].fGPtblCUnit1BFactoryPhone,
          email: widget.existingData[i].fGPtblCUnit1BFactoryEmail,
          nature: widget.existingData[i].fGPtblCUnitEnterprise.toString());

      if (widget.existingData[i].fGPtblCUnit1BFactoryAddress == "" &&
          widget.existingData[i].fGPtblCUnit1BFactoryZip == "" &&
          widget.existingData[i].fGPtblCUnit1BFactoryPhone == "" &&
          widget.existingData[i].fGPtblCUnit1BFactoryEmail == "") {
        break;
      }

      addressList.add(newAddress);
    }
    await AddressPreferences.saveAddressList(addressList);

    prefs.setString('branchController', widget.branchId.toString());
    prefs.setString('constController', widget.constitutionId.toString());
    prefs.setString(
        'udyamController', widget.existingData[0].fGtblCompanyAdharNumber);
    prefs.setString('panController', widget.existingData[0].fGPtblCompanyPan);
    prefs.setString('nameController', widget.existingData[0].fGPtblCompanyName);

    // change date format to dd-mm-yyyy
    List<String> parts =
    widget.existingDataMain[0].fGPtblCompanyProposalDate.split('/');
    String formattedDate = '${parts[1]}-${parts[0]}-${parts[2]}';
    prefs.setString('dateController', formattedDate);

    // prefs.setString('specialController', widget.existingData[0].);
    prefs.setString('ayushController',
        widget.existingDataMain[0].fGPtblIsAyush == true ? "Yes" : "No");
    prefs.setString('gstController',
        widget.existingData[0].fGtblCompanyGstNumber.toString());
    prefs.setString(
        'shareController',
        widget.existingDataMain[0].fGPtblCompanyShareInfo == true
            ? "Yes"
            : "No");

    // Head office
    prefs.setString('addressController',
        widget.existingData[0].fGPtblCompanyHeadOfficeAddress);
    prefs.setString(
        'pinController', widget.existingData[0].fGPtblCompanyHeadOfficeZip);
    prefs.setString('stateController',
        widget.existingData[0].fGPtblCompanyHeadOfficeStateId.toString());
    prefs.setString('cityController',
        widget.existingData[0].fGPtblCompanyHeadOfficeCityId.toString());
    prefs.setString(
        'teleController', widget.existingData[0].fGPtblCompanyHeadOfficePhone);
    prefs.setString('mobileController',
        widget.existingData[0].fGPtblCompanyHeadOfficeMobile);
    prefs.setString(
        'emailController', widget.existingData[0].fGPtblCompanyHeadOfficeEmail);

    // Branch
    prefs.setString('branchAddController',
        widget.existingData[0].fGPtblCUnitBranchAddress!);
    prefs.setString(
        'branchPinController', widget.existingData[0].fGPtblCUnitBranchZip!);
    prefs.setString('branchStateController',
        widget.existingData[0].fGPtblCUnitBranchStateId.toString());
    prefs.setString('branchCityController',
        widget.existingData[0].fGPtblCUnitBranchCityId.toString());
    prefs.setString(
        'branchTeleController', widget.existingData[0].fGPtblCUnitBranchPhone!);
    prefs.setString('branchEmailController',
        widget.existingData[0].fGPtblCUnitBranchEmail!);

    // Extra
    prefs.setString('socialController',
        widget.existingData[0].fGPtblCUnitCategoryAreaId.toString());
    prefs.setString('entrepreneurController',
        widget.existingData[0].fGPtblCUnitCategoryCastId.toString());
    prefs.setString('unitSizeController',
        widget.existingData[0].fGPtblCUnitCategoryUnitSizeId.toString());

  }

  saveSharedPreferencesForNewApplication() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<AddressDetails> addressList = [];
    await AddressPreferences.saveAddressList(addressList);
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);

    // General
    prefs.setString('udyamController', widget.xmlData.msmeDataBank.uan);
    // prefs.setString('panController', "");
    prefs.setString(
        'nameController', widget.xmlData.msmeDataBank.enterpriseName);
    prefs.setString('dateController', formattedDate);
    prefs.setString('branchController', "0");
    prefs.setString('specialController', "");
    prefs.setString('ayushController', "");
    prefs.setString('gstController', "");
    prefs.setString('shareController', "");
    prefs.setString('constController',
        getConstitution(widget.xmlData.msmeDataBank.organisationType));

    // Head office
    prefs.setString(
        'addressController', widget.xmlData.msmeDataBank.communicationAddress);
    prefs.setString('pinController', widget.xmlData.msmeDataBank.pincode);
    prefs.setString('stateController', "");
    prefs.setString('teleController', widget.xmlData.msmeDataBank.mobile);
    prefs.setString('mobileController', widget.xmlData.msmeDataBank.mobile);
    prefs.setString('emailController', widget.xmlData.msmeDataBank.email);
    prefs.setString('cityController', "");

    // Branch
    prefs.setString('branchAddController', "");
    prefs.setString('branchPinController', '');
    prefs.setString('branchStateController', '');
    prefs.setString('branchCityController', '');
    prefs.setString('branchTeleController', '');
    prefs.setString('branchEmailController', '');

    // Extra
    prefs.setString('socialController',
        getSocialCat(widget.xmlData.msmeDataBank.socialCaterogy));
    prefs.setString(
        'entrepreneurController',
        getEntrepreneurType(
            pwd: widget.xmlData.msmeDataBank.pwDEntrepreneur,
            woman: widget.xmlData.msmeDataBank.womanEntrepreneur,
            minority: widget.xmlData.msmeDataBank.minority,
            exservice: widget.xmlData.msmeDataBank.exServiceman));
    prefs.setString('unitSizeController',
        getUnitCategory(widget.xmlData.msmeDataBank.unitCategory));
  }


  int _currentExpandedIndex = -1;

  void _handleExpansion(int index) {
    setState(() {
      _currentExpandedIndex = (_currentExpandedIndex == index) ? -1 : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
    );
  }

  ValidatorForComponent1 validator = ValidatorForComponent1();

  Future<bool> checkForFactoryAddresses() async {
    bool isValid = await ValidatorForComponent1().validateForAddress(context,
        "Minimum One Factory Address is Required"); // Await the function call

    if (isValid) {
      return true;
    } else {
      setState(() {
        _currentExpandedIndex = 2;
      });
      return false;
    }
  }

  bool checkforGeneralSection() {
    bool checkForBranchController = validator.validationForValue_0(
        context, (branchController.text), "Branch", "General");

    if (checkForBranchController == false) {
      setState(() {
        _currentExpandedIndex = 0;
      });
      return false;
    }

    bool checkForConstController = validator.validationForValue_0(
        context, (constController.text), "Constitution of the MSE", "General");

    if (checkForConstController == false) {
      setState(() {
        _currentExpandedIndex = 0;
      });
      return false;
    }

    bool checkForShareController = validator.validationForValue_yes_no(
        context,
        shareController.text,
        "share the information under IT ACT 2000",
        "General");

    if (checkForShareController == false) {
      setState(() {
        _currentExpandedIndex = 0;
      });
      return false;
    }

    bool checkForNameController = validator.validationForText(
        context,
        nameController.text,
        "Please Enter Name of Applicant",
        "General",
        RegExp(r'\w'));

    if (checkForNameController == false) {
      setState(() {
        _currentExpandedIndex = 0;
      });
      return false;
    }

    bool checkForGstController = validator.validationForText(
      context,
      gstController.text,
      "Please enter GST Number",
      "General",
      RegExp(r'^\d{2}[A-Z]{5}\d{4}[A-Z][1-9A-Z]Z[\dA-Z]$'),
    );
    if (checkForGstController == false) {
      setState(() {
        _currentExpandedIndex = 0;
      });
      return false;
    }
    return true;
  }

  bool checkForAnySpecialCategory() {
    bool checkForSocialController = validator.validationForValue_0(
        context,
        (socialController.text),
        "Enterprise Social Category",
        "Special Category");

    if (checkForSocialController == false) {
      setState(() {
        _currentExpandedIndex = 4;
      });
      return false;
    }
    bool checkForEntrepreneurController = validator.validationForValue_0(
        context,
        (entrepreneurController.text),
        "Special Category of Entrepreneur",
        "Special Category");

    if (checkForEntrepreneurController == false) {
      setState(() {
        _currentExpandedIndex = 4;
      });
      return false;
    }
    bool checkForUnitSizeController = validator.validationForValue_0(context,
        (unitSizeController.text), "Category Unit Size", "Special Category");

    if (checkForUnitSizeController == false) {
      setState(() {
        _currentExpandedIndex = 4;
      });
      return false;
    }
    return true;
  }

  bool checkforHeadOffice() {
    bool checkForAddressController = validator.validationForText(context,
        addressController.text, "Address", "Head Office", RegExp(r'\w'));
    if (checkForAddressController == false) {
      setState(() {
        _currentExpandedIndex = 1;
      });
      return false;
    }

    bool checkForPinController = validator.validationForText(context,
        pinController.text, "Pin", "Head Office", RegExp(r'^[1-9]\d{5}$'));
    if (checkForPinController == false) {
      setState(() {
        _currentExpandedIndex = 1;
      });
      return false;
    }

    bool checkForsStateController = validator.validationForValue_0(
        context, (stateController.text), "State", "Head Office");

    if (checkForsStateController == false) {
      setState(() {
        _currentExpandedIndex = 1;
      });
      return false;
    }

    bool checkForCityController = validator.validationForValue_0(
        context, (cityController.text), "City", "Head Office");

    if (checkForCityController == false) {
      setState(() {
        _currentExpandedIndex = 1;
      });
      return false;
    }

    bool checkForTeleController = validator.validationForText(
        context,
        teleController.text,
        "Please enter Telephone",
        "Head Office",
        RegExp(r'^[1-9]\d{9}$'));

    if (checkForTeleController == false) {
      setState(() {
        _currentExpandedIndex = 1;
      });
      return false;
    }

    bool checkForMobileController = validator.validationForText(
        context,
        mobileController.text,
        "Please enter Mobile",
        "Head Office",
        RegExp(r'^[1-9]\d{9}$'));

    if (checkForMobileController == false) {
      setState(() {
        _currentExpandedIndex = 1;
      });
      return false;
    }

    bool checkForEmailController = validator.validationForText(
      context,
      emailController.text,
      "Please enter Mobile",
      "Head Office",
      RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$'),
    );
    if (checkForEmailController == false) {
      setState(() {
        _currentExpandedIndex = 1;
      });
      return false;
    }

    return true;
  }

  submitData() async {
    if (checkforGeneralSection() == false) {
      return;
    }

    if (checkforHeadOffice() == false) {
      return;
    }

    if (await checkForFactoryAddresses() == false) {
      return;
    }

    if (checkForAnySpecialCategory() == false) {
      return;
    }

    confirmForSubmission();
  }

  void confirmForSubmission() {
    Get.defaultDialog(
        title: 'Confirmation',
        content: Text('Are you sure you want to submit the data?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back(); // Close the confirmation dialog
              loadingDialog();
              ApiCall api = ApiCall();
              final addressList = await AddressPreferences.loadAddressList();
              var isInserted = true;

              try {
                for (int i = 0; i < addressList.length; i++) {
                  isInserted = await api.insertData(
                    udyamController.text,
                    panController.text,
                    nameController.text,
                    dateController.text,
                    branchController.text,
                    specialController.text,
                    ayushController.text,
                    gstController.text,
                    shareController.text,
                    constController.text,
                    addressController.text,
                    pinController.text,
                    stateController.text,
                    teleController.text,
                    mobileController.text,
                    emailController.text,
                    cityController.text,
                    branchAddController.text,
                    branchPinController.text,
                    branchStateController.text,
                    branchCityController.text,
                    branchTeleController.text,
                    branchEmailController.text,
                    socialController.text,
                    entrepreneurController.text,
                    unitSizeController.text,
                    addressList[i].address,
                    addressList[i].pin,
                    addressList[i].state,
                    addressList[i].district,
                    addressList[i].tel,
                    addressList[i].email,
                    addressList[i].nature,
                  );
                  if (isInserted == false) {
                    break;
                  }
                }
              } catch (e) {
                print('Error occurred during data insertion: $e');
                isInserted = false;
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
        ]);
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
                  .updateScreenIndex(1);
              Get.to(Component2());
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
