import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nsic/Widgets/Add%20Factory%20Address/address_detail_model.dart';
import 'package:nsic/Widgets/Add%20Factory%20Address/address_prefs.dart';
import 'package:nsic/Widgets/CompanyCapital/step_4_capital_model.dart';
import 'package:nsic/Widgets/CompanyCapital/step_4_capital_pref.dart';
import 'package:nsic/Widgets/CompanyCapital/step_4_capital_preview.dart';
import 'package:nsic/Widgets/fieldLongWidget.dart';

class AddCapitalDetails extends StatefulWidget {
  const AddCapitalDetails({Key? key}) : super(key: key);

  @override
  State<AddCapitalDetails> createState() => _AddCapitalDetailsState();
}

class _AddCapitalDetailsState extends State<AddCapitalDetails> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController step4CapitalAddressAddController =
      TextEditingController();
  TextEditingController step4CapitalLandAddController = TextEditingController();
  TextEditingController step4CapitalMachineAddController =
      TextEditingController();
  TextEditingController step4CapitalEquipmentAddController =
      TextEditingController();
  TextEditingController step4CapitalAssetsAddController =
      TextEditingController();
  TextEditingController step4CapitalServiceAssetsAddController =
      TextEditingController();
  TextEditingController step4CapitalTotalAddController =
      TextEditingController();

  List<Step4CapitalModel> step4CapitalList = [];
  List<AddressDetails> addressList = [];
  int editPriorIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAddressList();
    loadSavedStep4Capital();
  }

  Future<void> loadAddressList() async {
    final addressList = await AddressPreferences.loadAddressList();
    setState(() {
      this.addressList = addressList;
    });
  }

  Future<void> loadSavedStep4Capital() async {
    List<Step4CapitalModel> capitalList = await Step4CapitalPrefs.loadCapital();
    step4CapitalList = addressList.map((address) {
      return Step4CapitalModel(
          step4CapitalAddressController: address.address,
          step4CapitalLandController: "0.00",
          step4CapitalMachineController: "0.00",
          step4CapitalEquipmentController: "0.00",
          step4CapitalAssetsController: "0.00",
          step4CapitalServiceAssetsController: "0.00",
          step4CapitalTotalController: "0.00");
    }).toList();

    for (int i = 0; i < capitalList.length; i++) {
      if (i < step4CapitalList.length) {
        step4CapitalList[i] = capitalList[i];
      } else {
        step4CapitalList.add(capitalList[i]);
      }
    }

    step4CapitalList.removeWhere((factory) => addressList.every(
        (address) => factory.step4CapitalAddressController != address.address));

    await saveStep4CapitalToPrefs();

    setState(() {});
  }

  Future<void> saveStep4CapitalToPrefs() async {
    await Step4CapitalPrefs.saveCapital(step4CapitalList);
  }

  void _showDialog({int? editIndex}) {
    final isEditing = editIndex != null;
    final editPrior = isEditing ? step4CapitalList[editIndex] : null;

    step4CapitalAddressAddController.text =
        isEditing ? editPrior!.step4CapitalAddressController : "N.A.";
    step4CapitalLandAddController.text =
        isEditing ? editPrior!.step4CapitalLandController : "0.00";
    step4CapitalMachineAddController.text =
        isEditing ? editPrior!.step4CapitalMachineController : "0.00";
    step4CapitalEquipmentAddController.text =
        isEditing ? editPrior!.step4CapitalEquipmentController : "0.00";
    step4CapitalAssetsAddController.text =
        isEditing ? editPrior!.step4CapitalAssetsController : "0.00";
    step4CapitalServiceAssetsAddController.text =
        isEditing ? editPrior!.step4CapitalServiceAssetsController : "0.00";
    step4CapitalTotalAddController.text =
        isEditing ? editPrior!.step4CapitalTotalController : "0.00";

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
                          step4CapitalAddressAddController, false),
                      Divider(),
                      Text(
                          "Fixed Capital (original value without depreciation"),
                      FieldLongWidget(
                        title:
                        "(6.a.1) Land & Building",
                        controller: step4CapitalLandAddController,
                        validationRegex: RegExp(r'\w'),
                        onlyNumber: true,
                      ),
                      FieldLongWidget(
                        title:
                        "(6.a.2) Plant & Machinery ( In lacs )",
                        controller: step4CapitalMachineAddController,
                        validationRegex: RegExp(r'\w'),
                        onlyNumber: true,
                      ),
                      FieldLongWidget(
                        title:
                        "(6.a.3) Equipments & Tools ( In lacs )",
                        controller: step4CapitalEquipmentAddController,
                        validationRegex: RegExp(r'\w'),
                        onlyNumber: true,
                      ),
                      Divider(),
                      FieldLongWidget(
                        title:
                            "(6.b.1) Current Assets (this should include stock of Raw material. Consumable stores, semi finished/finished products, cash in hand, bank balance etc.)",
                        controller: step4CapitalAssetsAddController,
                        validationRegex: RegExp(r'\w'),
                        onlyNumber: true,
                      ),
                      FieldLongWidget(
                        title:
                            "(6.b.2)* Current assets for Service Sector(this should be include manpower, cash in hand, bank balanace etc.)",
                        controller: step4CapitalServiceAssetsAddController,
                        validationRegex: RegExp(r'\w'),
                        onlyNumber: true,
                      ),
                      inputField("Total(6.a.1 + 6.a.2 + 6.a.3 + 6.b.1 + 6.b.2)",
                          step4CapitalTotalAddController),
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
                                Step4CapitalModel object = Step4CapitalModel(
                                    step4CapitalAddressController:
                                        step4CapitalAddressAddController.text,
                                    step4CapitalLandController:
                                        step4CapitalLandAddController.text,
                                    step4CapitalMachineController:
                                        step4CapitalMachineAddController.text,
                                    step4CapitalEquipmentController:
                                        step4CapitalEquipmentAddController.text,
                                    step4CapitalAssetsController:
                                        step4CapitalAssetsAddController.text,
                                    step4CapitalServiceAssetsController:
                                        step4CapitalServiceAssetsAddController
                                            .text,
                                    step4CapitalTotalController:
                                        step4CapitalTotalAddController.text);

                                setState(() {
                                  if (isEditing) {
                                    step4CapitalList[editIndex] = object;
                                  } else {
                                    step4CapitalList.add(object);
                                  }
                                });

                                saveStep4CapitalToPrefs();
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
            CapitalOfFactoryPreview(
              capitalList: step4CapitalList,
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
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter
      ],
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
