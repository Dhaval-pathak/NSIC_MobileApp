import 'package:flutter/material.dart';
import 'package:nsic/Widgets/TechinalFacilities/step_4_facilities_model.dart';
import 'package:nsic/Widgets/TechinalFacilities/step_4_facilities_pref.dart';
import 'package:nsic/Widgets/TechinalFacilities/step_4_facilities_preview.dart';
import 'package:nsic/Widgets/Add%20Factory%20Address/address_detail_model.dart';
import 'package:nsic/Widgets/Add%20Factory%20Address/address_prefs.dart';
import 'package:nsic/Widgets/fieldLongWidget.dart';

class AddFacilitiesDetails extends StatefulWidget {
  const AddFacilitiesDetails({Key? key}) : super(key: key);

  @override
  State<AddFacilitiesDetails> createState() => _AddFacilitiesDetailsState();
}

class _AddFacilitiesDetailsState extends State<AddFacilitiesDetails> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController facilitiesAddressController =
  TextEditingController();
  TextEditingController plantAndMachineDetailsController = TextEditingController();
  TextEditingController technicalFlowDetailsController =
  TextEditingController();
  TextEditingController qualityControlDetailsController =
  TextEditingController();
  TextEditingController testingDetailsController =
  TextEditingController();

  List<Step4FacilitiesModel> step4FacilitiesList = [];
  List<AddressDetails> addressList = [];
  int editPriorIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAddressList();
    loadSavedStep4Facilities();
  }

  Future<void> loadAddressList() async {
    final addressList = await AddressPreferences.loadAddressList();
    setState(() {
      this.addressList = addressList;
    });
  }

  Future<void> loadSavedStep4Facilities() async {
    List<Step4FacilitiesModel> facilitiesList = await Step4FacilitiesPrefs.loadFacilities();
    step4FacilitiesList = addressList.map((address) {
      return Step4FacilitiesModel(
          facilitiesAddressController: address.address,
          plantAndMachineDetailsController: "N.A.",
          qualityControlDetailsController: "N.A.",
          technicalFlowDetailsController: "N.A.",
          testingDetailsController: "N.A."
      );
    }).toList();

    for (int i = 0; i < facilitiesList.length; i++) {
      if (i < step4FacilitiesList.length) {
        step4FacilitiesList[i] = facilitiesList[i];
      } else {
        step4FacilitiesList.add(facilitiesList[i]);
      }
    }

    step4FacilitiesList.removeWhere((factory) => addressList.every(
            (address) => factory.facilitiesAddressController != address.address));

    await saveStep4FacilitiesToPrefs();

    setState(() {});
  }

  Future<void> saveStep4FacilitiesToPrefs() async {
    await Step4FacilitiesPrefs.saveFacilities(step4FacilitiesList);
  }

  void _showDialog({int? editIndex}) {
    final isEditing = editIndex != null;
    final editPrior = isEditing ? step4FacilitiesList[editIndex] : null;

    facilitiesAddressController.text =
    isEditing ? editPrior!.facilitiesAddressController : "N.A.";
    plantAndMachineDetailsController.text =
    isEditing ? editPrior!.plantAndMachineDetailsController : "N.A.";
    technicalFlowDetailsController.text =
    isEditing ? editPrior!.technicalFlowDetailsController : "N.A.";
    qualityControlDetailsController.text =
    isEditing ? editPrior!.qualityControlDetailsController : "N.A.";
    testingDetailsController.text =
    isEditing ? editPrior!.testingDetailsController : "N.A.";

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.store),
                          Spacer(),
                          Text(
                            'Detail of capital structure',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      inputField("Factory Address",
                          facilitiesAddressController, false),
                      FieldLongWidget(
                        title:
                        "Details of plant and machinery installed:",
                        controller: plantAndMachineDetailsController,
                        validationRegex: RegExp(r'\w'),
                        maxLines: 3,
                      ),
                      FieldLongWidget(
                        title:
                        "Full information of the technical know-how of products with flow chart.",
                        controller: technicalFlowDetailsController,
                        validationRegex: RegExp(r'\w'),
                        maxLines: 3,

                      ),
                      FieldLongWidget(
                        title:
                        "Quality control arrangement for routine and acceptance test: ",
                        controller: qualityControlDetailsController,
                        validationRegex: RegExp(r'\w'),
                        maxLines: 3,
                      ),
                      FieldLongWidget(
                        title:
                        "Details of testing machinery & facilities:",
                        controller: testingDetailsController,
                        validationRegex: RegExp(r'\w'),
                        maxLines: 3,
                      ),

                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                Step4FacilitiesModel object = Step4FacilitiesModel (
                                    facilitiesAddressController: facilitiesAddressController.text,
                                    plantAndMachineDetailsController: plantAndMachineDetailsController.text,
                                    qualityControlDetailsController: qualityControlDetailsController.text,
                                    technicalFlowDetailsController: technicalFlowDetailsController.text,
                                    testingDetailsController: testingDetailsController.text
                                );

                                setState(() {
                                  if (isEditing) {
                                    step4FacilitiesList[editIndex] = object;
                                  } else {
                                    step4FacilitiesList.add(object);
                                  }
                                });

                                saveStep4FacilitiesToPrefs();
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text('Save'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    loadAddressList();
    return Column(
      children: [
        Column(
          children: [
            FacilitiesOfFactoryPreview(
              facilitiesList: step4FacilitiesList,
              onEdit: (index) {
                setState(() {
                  editPriorIndex = index;
                });
                _showDialog(editIndex: index);
              },
            ),
            SizedBox(
              height: 18,
            ),
          ],
        ),
      ],
    );
  }

  Widget inputField(String text, TextEditingController controller,
      [bool? enable = true, RegExp? regExp]) {
    bool isValid(String value) {
      if (regExp != null) {
        return regExp.hasMatch(value);
      }
      return true;
    }

    return TextFormField(
      enabled: enable,
      controller: controller,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(fontSize: 18, color: Colors.black),
          label: Text(
            text,
            style: TextStyle(color: Colors.black),
          )),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Enter $text';
        }
        if (!isValid(value)) {
          return 'Please enter a valid $text';
        }

        return null;
      },
    );
  }
}

