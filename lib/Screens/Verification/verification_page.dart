import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:nsic/Models/existingDataExceptGridModel.dart';
import 'package:nsic/Models/existingDataModel.dart';
import 'package:nsic/Models/statusCheckModel.dart';
import 'package:nsic/Models/xmlParse.dart';
import 'package:nsic/api_call.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Models/step1Model.dart';
import '../../app.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage>
    with InputValidationMixin {
  xmlParse a = xmlParse();

  bool isChecked = false;
  bool isLoading = false;


  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _udyam = TextEditingController();
  final _pan = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: const [
                Color(0x33dbfff0),
                Color(0xfff3e9db),
                Color(0x47f6f6b5),
              ],
              tileMode: TileMode.clamp,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
              physics: ClampingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(
                  top: screenSize.height / 90,
                  left: screenSize.width / 16,
                  right: screenSize.width / 16,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: screenSize.width * 0.4,
                      height: screenSize.height * 0.2,
                      child: Image.asset('assets/images/nsic.png'),
                    ),
                    SizedBox(height: screenSize.width / 18),
                    Text(
                      "Single Point Registration Scheme",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontFamily: 'Poppins',
                        fontSize: screenSize.width / 23,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        height: 1.125,
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height / 25,
                    ), //30
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'New Unit Registration',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromRGBO(42, 47, 49, 1),
                              fontFamily: 'Poppins',
                              fontSize: screenSize.width / 18,
                            ),
                          ),
                          SizedBox(
                            height: screenSize.height / 55,
                          ),
                          Text(
                            'Continue with new unit registration if you have MSME Databank Registration',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromRGBO(42, 47, 49, 1),
                              fontFamily: 'Poppins',
                              fontSize: screenSize.width / 26,
                            ),
                          ),
                          SizedBox(
                            height: screenSize.height / 30,
                          ),
                          TextFormField(
                            controller: _udyam,
                            decoration: InputDecoration(
                              labelText: 'Udyam Registration Number',
                              hintText: "Ex-UDYAM-AA-000000",
                              floatingLabelStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Required";
                              } else if (!_isValidudyam(value)) {
                                return "Enter Valid Udyam Number";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: screenSize.height / 30,
                          ),
                          TextFormField(
                            controller: _pan,
                            decoration: InputDecoration(
                              labelText: 'PAN Number',
                              hintText: "Ex-AAAAA9999A",
                              floatingLabelStyle: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Required";
                              } else if (!_isValidPAN(value)) {
                                return "Enter a valid PAN Number";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: screenSize.height / 30,
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0x88000000),
                              ),
                              children: [
                                TextSpan(
                                  text: "VIew New Unit Registration Intro Again? ",
                                ),
                                TextSpan(
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                  text: "Click here",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(context, "/intro");
                                    },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenSize.height / 30,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: screenSize.height / 15,
                            child: isLoading?
                            ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(
                              alignment: Alignment.center,
                            ), child: CircularProgressIndicator(color: Colors.white,),):
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {

                                  setState((){
                                    isLoading=true;
                                  });
                                  StatusCheckModel status = await ApiCall().checkStatus(_pan.text.trim(), _udyam.text.trim());
                                  setState((){
                                    isLoading=false;
                                  });
                                  if (status.status == 123) {
                                    setState((){
                                      isLoading=true;
                                    });
                                    List<ExistingDataModel> data =[];
                                    List<ExistingDataExceptGridModel> data2 = [];
                                    Step1Model newData = await a.fetchAndParse(_udyam.text.trim(), _pan.text.trim());
                                    setState((){
                                      isLoading=false;
                                    });
                                    Get.to(() => Step1(xmlData: newData, existingData: data,status: status.status, existingDataMain: data2,));
                                  }
                                  else if (status.status == 1) {
                                    Get.defaultDialog(
                                        title: "Status: Confirm",
                                        middleText:
                                        "This PAN exists with Confirm Status at ${status.branchName}  Branch",
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text("Confirm"))
                                        ]);
                                  }
                                  else if (status.status == 2) {
                                    Get.defaultDialog(
                                        title: "Status: In-process",
                                        middleText:
                                        "This PAN exists with In-process Status at ${status.branchName}  Branch",
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text("Confirm"))
                                        ]);
                                  }
                                  else if (status.status == 3) {
                                    Get.defaultDialog(
                                        title: "Status: Waiting",
                                        middleText: "This PAN exists with Waiting Status at ${status.branchName}  Branch",
                                        actions: [ElevatedButton(onPressed: () {Get.back();}, child: Text("Confirm"))
                                        ]);
                                  }
                                  else if (status.status == 4) {
                                    Get.defaultDialog(
                                        title: "Status: Expired",
                                        middleText: "This PAN exists with Expired Status at ${status.branchName}  Branch",
                                        actions: [ElevatedButton(onPressed: () {Get.back();}, child: Text("Confirm"))]);
                                  }
                                  else if (status.status == 5 && status.accessId == 0) {
                                    setState((){
                                      isLoading=true;
                                    });
                                    int constitutionType = await ApiCall().checkConstitutionInitially(_pan.text.trim(), _udyam.text.trim());
                                    setState((){
                                      isLoading=false;
                                    });
                                    if (constitutionType == 4) {
                                      setState((){
                                        isLoading=true;
                                      });
                                      List<ExistingDataModel> data = await ApiCall().getExistingDataProprietorship(_pan.text.trim(), _udyam.text.trim());
                                      List<ExistingDataExceptGridModel> data2 = await ApiCall().getExistingDataWholeProprietorship(_pan.text.trim(), _udyam.text.trim());
                                      Step1Model newData = await a.fetchAndParse(_udyam.text.trim(), _pan.text.trim());
                                      setState((){
                                        isLoading=false;
                                      });
                                      Get.to(() => Step1(xmlData: newData, existingData: data,status: status.status,existingDataMain: data2, constitutionId: constitutionType,
                                      branchId: status.branchId,));
                                    }
                                    else{
                                      setState((){
                                        isLoading=true;
                                      });
                                      List<ExistingDataModel> data = await ApiCall().getExistingData(_pan.text.trim());
                                      List<ExistingDataExceptGridModel> data2 = await ApiCall().getExistingDataWhole(_pan.text.trim());
                                      Step1Model newData = await a.fetchAndParse(_udyam.text.trim(), _pan.text.trim());
                                      setState((){
                                        isLoading=false;
                                      });
                                      Get.to(() => Step1(xmlData: newData,existingData: data,status: status.status, existingDataMain: data2,constitutionId: constitutionType
                                         , branchId: status.branchId));
                                    }
                                  }
                                  else if (status.status == 5 && status.accessId == 4) {
                                    Get.defaultDialog(
                                        title: "Status: Incomplete",
                                        middleText:
                                        "This PAN exists with Incomplete Status at ${status.branchName}  Branch. \n This has been filled using BackLog Registration link",
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text("Confirm"))
                                        ]);
                                  }
                                  else if (status.status == 6) {
                                    setState((){
                                      isLoading=true;
                                    });
                                    int constitutionType = await ApiCall().checkConstitutionInitially(_pan.text.trim(), _udyam.text.trim());
                                    setState((){
                                      isLoading=false;
                                    });
                                    Get.defaultDialog(
                                        title: "Status: Rejected",
                                        middleText:
                                        "This PAN exists with Rejected Status at ${status.branchName}  Branch. \n Do you wish to edit it? ",
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text("Cancel")),
                                          ElevatedButton(
                                              onPressed: () async {
                                                if (constitutionType == 4) {
                                                  setState((){
                                                    isLoading=true;
                                                  });
                                                  List<ExistingDataModel> data = await ApiCall().getExistingDataProprietorship(_pan.text.trim(), _udyam.text.trim());
                                                  List<ExistingDataExceptGridModel> data2 = await ApiCall().getExistingDataWholeProprietorship(_pan.text.trim(), _udyam.text.trim());
                                                  Step1Model newData = await a.fetchAndParse(_udyam.text.trim(), _pan.text.trim());
                                                  setState((){
                                                    isLoading=false;
                                                  });
                                                  Get.to(() => Step1(xmlData: newData, existingData: data,status: status.status,existingDataMain: data2,constitutionId: constitutionType));
                                                }
                                                else{
                                                  setState((){
                                                    isLoading=true;
                                                  });
                                                  List<ExistingDataModel> data = await ApiCall().getExistingData(_pan.text.trim());
                                                  List<ExistingDataExceptGridModel> data2 = await ApiCall().getExistingDataWhole(_pan.text.trim());
                                                  Step1Model newData = await a.fetchAndParse(_udyam.text.trim(), _pan.text.trim());
                                                  setState((){
                                                    isLoading=false;
                                                  });
                                                  Get.to(() => Step1(xmlData: newData,existingData: data,status: status.status, existingDataMain: data2,constitutionId: constitutionType));
                                                }
                                              },
                                              child: Text("Yes"))
                                        ]);
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                alignment: Alignment.center,
                              ),
                              child: Text('VERIFY'),
                            ),
                          ),
                          SizedBox(
                            height: screenSize.width / 12,
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0x88000000),
                              ),
                              children: [
                                TextSpan(
                                  text: "Don’t have MSME Databank Registration? ",
                                ),
                                TextSpan(
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                  text: "Click here",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      _launchURL("https://www.msmedatabank.in/");
                                    },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenSize.width / 36,
                          ),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0x88000000),
                              ),
                              children: [
                                TextSpan(
                                  text: "Don’t have Udyam Registration ? ",
                                ),
                                TextSpan(
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                  text: "Click here",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      _launchURL(
                                          "https://udyamregistration.gov.in/Government-India/Ministry-MSME-registration.htm");
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )

      // }),
    );
  }
}

mixin InputValidationMixin {
  bool _isValidPAN(String pan) {
    const pattern = r'[A-Z]{5}[0-9]{4}[A-Z]{1}';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(pan);
  }

  bool _isValidudyam(String udyam) {
    const pattern = r'^UDYAM-[A-Z]{2}-\d{2}-\d{7}$';
    final regExp = RegExp(pattern);
    return regExp.hasMatch(udyam);
  }
}
