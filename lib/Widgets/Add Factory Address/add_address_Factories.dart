import 'package:flutter/material.dart';
import 'package:nsic/Widgets/commonDropDownMenu.dart';
import 'package:nsic/Widgets/stateCityDropDownMenu.dart';
import '../../Utilities/validators_for_component1.dart';
import '../../api_call.dart';
import 'address_detail_model.dart';
import 'address_prefs.dart';
import 'address_preview.dart';

class AddAddressFactory extends StatefulWidget {
  const AddAddressFactory({Key? key}) : super(key: key);

  @override
  _AddAddressFactoryState createState() => _AddAddressFactoryState();
}

class _AddAddressFactoryState extends State<AddAddressFactory> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController addressController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController natureController = TextEditingController();
  List<AddressDetails> addressList = [];
  int editAddressIndex = -1;
  ApiCall api = ApiCall();

  @override
  void initState() {
    super.initState();

    loadAddressList();
    // if we are editing
    if (editAddressIndex != -1) {
      addressController.text = addressList[editAddressIndex].address;
      pinController.text = addressList[editAddressIndex].pin;
      stateController.text = addressList[editAddressIndex].state;
      cityController.text = addressList[editAddressIndex].district;
      telController.text = addressList[editAddressIndex].tel;
      emailController.text = addressList[editAddressIndex].email;
      natureController.text = addressList[editAddressIndex].nature;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    addressController.dispose();
    pinController.dispose();
    stateController.dispose();
    cityController.dispose();
    telController.dispose();
    emailController.dispose();
    natureController.dispose();
  }

  Future<void> loadAddressList() async {
    final addressList = await AddressPreferences.loadAddressList();
    setState(() {
      this.addressList = addressList;
    });
  }

  Future<void> saveAddressList() async {
    await AddressPreferences.saveAddressList(addressList);
  }

  void _showDialog({int? editIndex}) {
    final isEditing = editIndex != null;
    final AddressDetails? editAddress =
        isEditing ? addressList[editIndex] : null;

    addressController.text = isEditing ? editAddress!.address : '';
    pinController.text = isEditing ? editAddress!.pin : '';
    stateController.text = isEditing ? editAddress!.state : '';
    cityController.text = isEditing ? editAddress!.district : '';
    telController.text = isEditing ? editAddress!.tel : '';
    emailController.text = isEditing ? editAddress!.email : '';
    natureController.text = isEditing ? editAddress!.nature : '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xfff1f0ec),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Row(
            children: const [
              Icon(Icons.factory_outlined),
              Spacer(),
              Text(
                'Add Address',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                        label: Row(
                          children: const [
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            ),
                            Text(
                              "Address",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the address';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: pinController,
                      decoration: InputDecoration(
                        label: Row(
                          children: const [
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            ),
                            Text(
                              "Pin",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the PIN code';
                        }
                        else if (value.length != 6 ||
                            int.tryParse(value) == null) {
                          return 'PIN code should be a 6-digit number';
                        }
                        return null;
                      },
                    ),

                    TextFormField(
                      controller: telController,
                      decoration: InputDecoration(
                        label: Row(
                          children: const [
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            ),
                            Text(
                              "Tel",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Telephone Number'; // Telephone number is optional, so no validation needed
                        }
                        else if (value.length != 10 || int.tryParse(value) == null) {
                          return 'Telephone number should be a 10-digit number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return null; // Email is optional, so no validation needed
                        }
                        else if (!_isValidEmail(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SingleChildScrollView(
                      child: StateCityDropDownMenu(
                        title: '*State',
                        dropController: stateController,
                        dropController2: cityController,
                        options: api.showState(),
                        mandatory: true,
                      ),
                    ),
                    CommonDropDownMenu(
                        title: "Nature of Operation",
                        dropController: natureController,
                        options: api.showNature()
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                final validator=ValidatorForComponent1();
                bool checkForsStateController=validator.validationForValue_0(context,
                    (stateController.text), "State", "");

                if(checkForsStateController==false){

                  return ;
                }

                bool checkForDistrictController=validator.validationForValue_0(context,
                    (cityController.text), "City", "");

                if(checkForDistrictController==false){

                  return ;
                }
                if (_formKey.currentState!.validate()) {
                  AddressDetails newAddress = AddressDetails(
                    address: addressController.text,
                    pin: pinController.text,
                    state: stateController.text,
                    district: cityController.text,
                    tel: telController.text,
                    email: emailController.text,
                    nature: natureController.text,
                  );

                  setState(() {
                    if (isEditing) {
                      addressList[editIndex] = newAddress;
                    } else {
                      addressList.add(newAddress);
                    }
                  });
                  saveAddressList();

                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool empty = addressList.isEmpty;
    bool limitForAddress=addressList.length >= 5;
    return Column(
      children: [
        empty
            ? SizedBox()
            : Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  AddressPreview(
                    addressList: addressList,
                    onEdit: (index) {
                      setState(() {
                        editAddressIndex = index;
                      });
                      _showDialog(editIndex: index);
                    },
                    onDelete: (index) {
                      setState(() {
                        addressList.removeAt(index);
                        saveAddressList();
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
        Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xfff5ecc0),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.factory_outlined,
                ),
                title: Text('Add Address'),
                trailing: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffe8d3a5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    icon: Icon(
                        limitForAddress?
                        Icons.lock:
                        Icons.add,
                        color: Colors.black),
                    onPressed: () {
                      setState(() {
                        editAddressIndex = -1;
                      });

                      if (limitForAddress) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Address Limit Reached'),
                              content: Text(
                                  'You can only add a maximum of 5 addresses.'),
                              actions: [
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        _showDialog();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

bool _isValidEmail(String email) {
  // Regular expression pattern to validate email format
  const pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
  final regExp = RegExp(pattern);
  return regExp.hasMatch(email);
}

