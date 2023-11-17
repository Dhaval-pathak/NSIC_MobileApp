import 'package:flutter/material.dart';
import 'package:nsic/Widgets/Proprietor%20having%20stake%20in%20the%20MSE%20unit/proprietor_model.dart';
import 'package:nsic/Widgets/Proprietor%20having%20stake%20in%20the%20MSE%20unit/proprietor_prefs.dart';
import 'package:nsic/Widgets/Proprietor%20having%20stake%20in%20the%20MSE%20unit/proprietor_preview.dart';
import 'package:nsic/api_call.dart';
import '../../Utilities/validators_for_component1.dart';
import '../stateCityDropDownMenu.dart';

class AddProprietor extends StatefulWidget {
  const AddProprietor({Key? key}) : super(key: key);

  @override
  State<AddProprietor> createState() => _AddProprietorState();
}

class _AddProprietorState extends State<AddProprietor> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController lengthOfExperienceController = TextEditingController();
  TextEditingController adharController = TextEditingController();
  TextEditingController shareholdingController = TextEditingController();

  List<ProprietorModel> proprietorList = [];
  int editPriorIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadsavedproprietor();
  }

  Future<void> loadsavedproprietor() async {
    List<ProprietorModel> proprietorList =
        await ProprietorPrefs.loadProprietor();
    setState(() {
      this.proprietorList = proprietorList;
    });
  }

  Future<void> savedProprietoeToPrefs() async {
    await ProprietorPrefs.saveProprietor(proprietorList);
  }

  void _showDialog({int? editIndex}) {
    final isEditing = editIndex != null;
    final editPrior = isEditing ? proprietorList[editIndex] : null;

    nameController.text = isEditing ? editPrior!.name : '';
    addressController.text = isEditing ? editPrior!.address : '';
    pinController.text = isEditing ? editPrior!.pin : '';
    stateController.text = isEditing ? editPrior!.state : '';
    cityController.text = isEditing ? editPrior!.city : '';
    telController.text = isEditing ? editPrior!.telephone : '';
    emailController.text = isEditing ? editPrior!.email : '';
    lengthOfExperienceController.text =
        isEditing ? editPrior!.lengthOfExperience : '';
    adharController.text = isEditing ? editPrior!.adhar : '';
    shareholdingController.text = isEditing ? editPrior!.shareholding : '';

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
                        Icon(Icons.stacked_bar_chart),
                        Spacer(),
                        Text(
                          'Add Proprietor',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    inputField(
                      'Name',
                      nameController,
                    ),
                    inputField(
                      'Address',
                      addressController,
                    ),
                    inputField(
                        'pin', pinController, RegExp(r'^[1-9][0-9]{5}$')),
                    StateCityDropDownMenu(
                      title: '*State',
                      dropController: stateController,
                      dropController2: cityController,
                      options: ApiCall().showState(),
                      mandatory: true,
                    ),
                    inputField(
                        'Telephone', telController, RegExp(r'^[1-9][0-9]{9}$')),
                    inputField(
                      'Email',
                      emailController,
                      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'),
                    ),
                    inputField('Length of Experience(in years)',
                        lengthOfExperienceController, RegExp(r'^\d')),
                    inputField('Adhar No.(optional)', adharController,
                        RegExp(r'^\d{12}$'), true),
                    inputField(
                        'Shareholding', shareholdingController, RegExp(r'^\d')),
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
                            final validator = ValidatorForComponent1();
                            bool checkForsStateController =
                                validator.validationForValue_0(context,
                                    (stateController.text), "State", "");

                            if (checkForsStateController == false) {
                              return;
                            }

                            bool checkForDistrictController =
                                validator.validationForValue_0(
                                    context, (cityController.text), "City", "");

                            if (checkForDistrictController == false) {
                              return;
                            }
                            if (formKey.currentState!.validate()) {
                              ProprietorModel object = ProprietorModel(
                                name: nameController.text,
                                address: addressController.text,
                                pin: pinController.text,
                                state: stateController.text,
                                city: cityController.text,
                                telephone: telController.text,
                                email: emailController.text,
                                lengthOfExperience:
                                    lengthOfExperienceController.text,
                                adhar: adharController.text,
                                shareholding: shareholdingController.text,
                              );

                              setState(() {
                                if (isEditing) {
                                  proprietorList[editIndex] = object;
                                } else {
                                  proprietorList.add(object);
                                }
                              });

                              savedProprietoeToPrefs();
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
    bool empty = proprietorList.isEmpty;
    return Column(
      children: [
        empty
            ? SizedBox()
            : Column(
                children: [
                  ProprietorPreview(
                      proprietorList: proprietorList,
                      onEdit: (index) {
                        setState(() {
                          editPriorIndex = index;
                        });
                        _showDialog(editIndex: index);
                      },
                      onDelete: (index) {
                        setState(() {
                          proprietorList.removeAt(index);
                          savedProprietoeToPrefs();
                        });
                      }),
                  SizedBox(
                    height: 18,
                  ),
                ],
              ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xfff5ecc0),
          ),
          child: ListTile(
            leading: Icon(
              Icons.stacked_bar_chart,
              color: Colors.black,
            ),
            title: Text(
                'Add Proprietor/Partners/Directors/Karta having stake in the MSE unit'),
            trailing: InkWell(
              onTap: () {
                setState(() {
                  editPriorIndex = -1;
                });
                _showDialog();
              },
              child: CircleAvatar(
                  backgroundColor: Color(0xffe7d2a4),
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}

Widget inputField(String text, TextEditingController controller,
    [RegExp? regExp, bool? optional = false]) {
  bool isValid(String value) {
    if (regExp != null) {
      return regExp.hasMatch(value);
    }
    return true;
  }

  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        label: Text(
          text,
          style: TextStyle(color: Colors.black),
        )),
    validator: optional == false
        ? (value) {
            if (value!.isEmpty) {
              return 'Please Enter $text';
            }
            if (!isValid(value)) {
              return 'Please enter a valid $text';
            }

            return null;
          }
        : (value) {
            if (value!.isEmpty) {
              return null;
            }
            if (!isValid(value)) {
              return 'Please enter a valid $text';
            }

            return null;
          },
  );
}
