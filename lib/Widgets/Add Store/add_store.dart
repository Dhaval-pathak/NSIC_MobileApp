import 'package:flutter/material.dart';
import 'package:nsic/Widgets/Add%20Store/store_model.dart';
import 'package:nsic/Widgets/Add%20Store/store_preview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/Step2_Data_Fetched_ForStatusOfApplicantMSE.dart';
import '../Add Factory Address/address_detail_model.dart';
import '../Add Factory Address/address_prefs.dart';
import '../Add Store/store_prefs.dart';
import '../fieldLongWidget.dart';

class AddStore extends StatefulWidget {
  const AddStore({Key? key}) : super(key: key);

  @override
  State<AddStore> createState() => _AddStoreState();
}

class _AddStoreState extends State<AddStore> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController sNoController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController BISSpecificationController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController limitingSizeCapacityController =
      TextEditingController();
  TextEditingController monthlyProductionController = TextEditingController();
  TextEditingController noOfShiftsController = TextEditingController();

  List<StoreModel> storeList = [];
  List<AddressDetails> addressList = [];
  int editPriorIndex = -1;
   late var CunitAddressList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSavedStore();
    loadAddressList();

    savedCunitAddressList();
  }

  Future<void> loadSavedStore() async {
    List<StoreModel> storeList = await StorePrefs.loadStore();
    setState(() {
      this.storeList = storeList;
    });
  }

  Future<void> loadAddressList() async {
    final addressList = await AddressPreferences.loadAddressList();
    setState(() {
      this.addressList = addressList;
    });
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

  Future<void> savedCunitAddressList() async {
     CunitAddressList = await loadCunitAddressList();
  }


  Future<void> saveStoreToPrefs() async {
    await StorePrefs.saveStore(storeList);
  }

  void _showDialog({int? editIndex}) {
    final isEditing = editIndex != null;
    final editPrior = isEditing ? storeList[editIndex] : null;

    sNoController.text = isEditing ? editPrior!.sno : '';
    locationController.text = isEditing ? editPrior!.location : '';
    descriptionController.text = isEditing ? editPrior!.description : '';
    BISSpecificationController.text =
        isEditing ? editPrior!.bisSpecification : '';
    modelController.text = isEditing ? editPrior!.model : '';
    limitingSizeCapacityController.text =
        isEditing ? editPrior!.limitingSizeCapacity : '';
    monthlyProductionController.text =
        isEditing ? editPrior!.monthlyProductionCapacity : '';
    noOfShiftsController.text = isEditing ? editPrior!.numberOfShifts : '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
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

                    Text("If you want to leave any field empty, Write N.A. or 0 in it", style: TextStyle(color: Colors.red),),

                    SizedBox(height: 16),

                    FieldLongWidget(
                      controller: sNoController,
                      title: 'S.no',
                      validationRegex: RegExp(r'^\d+$'),
                      validationErrorText: "Please Enter valid S.no",
                      onlyNumber: true,
                    ),
                    DropdownButtonFormField<AddressDetails>(
                      value: editPrior?.location != null
                          ? addressList.firstWhere(
                              (address) =>
                                  address.address == editPrior!.location,
                        orElse: () => addressList.first,
                            )
                          : null,
                      items: addressList.map((address) {
                        return DropdownMenuItem<AddressDetails>(
                          value: address,
                          child: Text(address.address),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          locationController.text = value!.address;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Location',
                        labelStyle: TextStyle(color: Colors.black),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a location';
                        }
                        return null;
                      },
                    ),
                    FieldLongWidget(
                      mandatory: false,
                      controller: descriptionController,
                      title: 'Description/ Stores/ Products/Services',
                      validationRegex: RegExp(r'\w'),
                    ),
                    FieldLongWidget(
                      mandatory: false,
                      controller: BISSpecificationController,
                      title: 'Ref. of BIS Specification or other Specification',
                      validationRegex: RegExp(r'\w'),
                    ),
                    FieldLongWidget(
                      mandatory: false,
                      controller: modelController,
                      title: 'Model/ Brand',
                      validationRegex: RegExp(r'\w'),
                    ),
                    FieldLongWidget(
                      mandatory: false,
                      controller: limitingSizeCapacityController,
                      title: 'Limiting Size Capacity/ Rating',
                      validationRegex: RegExp(r'\w'),
                    ),
                    FieldLongWidget(
                      mandatory: false,
                      controller: monthlyProductionController,
                      title: 'Monthly Production Capacity per shift',
                      validationRegex: RegExp(r'\w'),
                    ),
                    FieldLongWidget(
                      mandatory: false,
                      controller: noOfShiftsController,
                      title: 'Number of shifts factory normally works',
                      validationRegex: RegExp(r'^\d+$'),
                      onlyNumber: true,
                      validationErrorText: "Please enter valid Number of shifts",
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
                              StoreModel object = StoreModel(
                                sno: sNoController.text,
                                location: locationController.text,
                                description: descriptionController.text,
                                bisSpecification:
                                    BISSpecificationController.text,
                                model: modelController.text,
                                limitingSizeCapacity:
                                    limitingSizeCapacityController.text,
                                monthlyProductionCapacity:
                                    monthlyProductionController.text,
                                numberOfShifts: noOfShiftsController.text,
                              );

                              setState(() {
                                if (isEditing) {
                                  storeList[editIndex] = object;
                                } else {
                                  storeList.add(object);
                                }
                              });

                              saveStoreToPrefs();
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
    bool empty = storeList.isEmpty;
    loadAddressList();
    return Column(
      children: [
        empty
            ? SizedBox()
            : Column(
                children: [
                  StorePreview(
                      storeList: storeList,
                      onEdit: (index) {
                        setState(() {
                          editPriorIndex = index;
                        });
                        _showDialog(editIndex: index);
                      },
                      onDelete: (index) {
                        setState(() {
                          storeList.removeAt(index);
                          saveStoreToPrefs();
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
              Icons.store,
              color: Colors.black,
            ),
            title: Text('Add Factory Store'),
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
    [RegExp? regExp]) {
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
