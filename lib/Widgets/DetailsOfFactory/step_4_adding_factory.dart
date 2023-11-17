import 'package:flutter/material.dart';
import 'package:nsic/Widgets/Add%20Factory%20Address/address_detail_model.dart';
import 'package:nsic/Widgets/DetailsOfFactory/step_4_factory_model.dart';
import '../Add Factory Address/address_prefs.dart';
import '../DetailsOfFactory/step_4_factory_pref.dart';
import '../DetailsOfFactory/step_4_factory_preview.dart';
import '../fieldLongWidget.dart';

class AddDetailFactory extends StatefulWidget {
  const AddDetailFactory({Key? key}) : super(key: key);

  @override
  State<AddDetailFactory> createState() => _AddDetailFactoryState();
}

class _AddDetailFactoryState extends State<AddDetailFactory> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController Step4factoryaddressController = TextEditingController();
  TextEditingController step4AddressController = TextEditingController();
  TextEditingController Step4teleController = TextEditingController();
  TextEditingController Step4powerController = TextEditingController();
  TextEditingController Step4power2Controller = TextEditingController();
  TextEditingController Step4descController = TextEditingController();

  List<Step4FactoryModel> step4FactoryList = [];
  List<AddressDetails> addressList = [];
  int editPriorIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAddressList();
    loadSavedStep4factory();
  }

  Future<void> loadAddressList() async {
    final addressList = await AddressPreferences.loadAddressList();
    setState(() {
      this.addressList = addressList;
    });
  }

  Future<void> loadSavedStep4factory() async {
    List<Step4FactoryModel> storeList = await Step4FactoryPrefs.loadStore();

    // Initialize step4FactoryList with addressList values
    step4FactoryList = addressList.map((address) {
      return Step4FactoryModel(
        step4factoryaddressController: address.address,
        step4AddressController: 'N.A.',
        step4teleController: 'N.A.',
        step4powerController: 'N.A.',
        step4power2Controller: 'N.A.',
        step4descController: 'N.A.',
      );
    }).toList();

    // Update existing storeList values if available
    for (int i = 0; i < storeList.length; i++) {
      if (i < step4FactoryList.length) {
        step4FactoryList[i] = storeList[i];
      } else {
        step4FactoryList.add(storeList[i]);
      }
    }

    // Remove any addresses from step4FactoryList that are not present in addressList
    step4FactoryList.removeWhere(
      (factory) => addressList.every((address) =>
          factory.step4factoryaddressController != address.address),
    );

    // Save the updated step4FactoryList to preferences
    await saveStep4FactoryToPrefs();

    setState(() {});
  }

  Future<void> saveStep4FactoryToPrefs() async {
    await Step4FactoryPrefs.saveStore(step4FactoryList);
  }

  void _showDialog({int? editIndex}) {
    final isEditing = editIndex != null;
    final editPrior = isEditing ? step4FactoryList[editIndex] : null;

    Step4factoryaddressController.text =
        isEditing ? editPrior!.step4factoryaddressController : 'N.A.';
    Step4teleController.text = isEditing ? editPrior!.step4teleController : 'N.A.';
    Step4powerController.text =
        isEditing ? editPrior!.step4powerController : 'N.A.';
    Step4power2Controller.text =
        isEditing ? editPrior!.step4power2Controller : 'N.A.';
    Step4descController.text = isEditing ? editPrior!.step4descController : 'N.A.';

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
                          'Add Factory Store',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    inputField('Factory Address', Step4factoryaddressController,
                        false),
                    inputField(
                      'Address',
                      step4AddressController,
                    ),
                    inputField(
                      'Tel. No.',
                      Step4teleController,
                    ),
                    inputField(
                      'Horse Power - allotted',
                      Step4powerController,
                    ),
                    inputField(
                      'Horse Power - installed:',
                      Step4power2Controller,
                    ),
                    FieldLongWidget(
                        title:
                            'Brief Description of the Factory/Godown Covered/Uncovered Area Departments and laboratories etc.',
                        controller: Step4descController,
                        mandatory: false,
                        validationRegex: RegExp(r'\w')),
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
                              Step4FactoryModel object = Step4FactoryModel(
                                step4factoryaddressController:
                                    Step4factoryaddressController.text,
                                step4AddressController:
                                    step4AddressController.text,
                                step4teleController: Step4teleController.text,
                                step4powerController: Step4powerController.text,
                                step4power2Controller:
                                    Step4power2Controller.text,
                                step4descController: Step4descController.text,
                              );

                              setState(() {
                                if (isEditing) {
                                  step4FactoryList[editIndex] = object;
                                } else {
                                  step4FactoryList.add(object);
                                }
                              });

                              saveStep4FactoryToPrefs();
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    loadAddressList();
    return Column(
      children: [
        Column(
          children: [
            DetailsOfFactoryPreview(
              storeList: step4FactoryList,
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
        // Container(
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10),
        //     color: Color(0xfff5ecc0),
        //   ),
        //   child: ListTile(
        //     leading: Icon(
        //       Icons.store,
        //       color: Colors.black,
        //     ),
        //     title: Text('Add Factory Store'),
        //     trailing: InkWell(
        //       onTap: () {
        //         setState(() {
        //           editPriorIndex = -1;
        //         });
        //         _showDialog();
        //       },
        //       child: CircleAvatar(
        //           backgroundColor: Color(0xffe7d2a4),
        //           child: Icon(
        //             Icons.add,
        //             color: Colors.black,
        //           )),
        //     ),
        //   ),
        // ),
      ],
    );
  }
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
