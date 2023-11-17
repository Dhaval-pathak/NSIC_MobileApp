import 'package:flutter/material.dart';
import 'package:nsic/Models/MainModel.dart';
import 'package:nsic/api_call.dart';

class StateCityDropDownMenu extends StatefulWidget {
  final String title;
  final TextEditingController dropController;
  final TextEditingController dropController2;
  final Future<List<MainModel>> options;
  final mandatory ;

  const StateCityDropDownMenu({
    Key? key,
    required this.title,
    required this.dropController,
    required this.dropController2,
    required this.options, required this.mandatory,
  }) : super(key: key);

  @override
  State<StateCityDropDownMenu> createState() => _StateCityDropDownMenuState();
}

class _StateCityDropDownMenuState extends State<StateCityDropDownMenu> {
  double _dropdownItemFontSize = 20;
  int selectedValue = 0;
  int selectedCity = 0;
  final api = ApiCall().showState();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    super.dispose();
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus) {
      // Collapse the keyboard
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    void changeController(int s) {
      widget.dropController.text = s.toString();
      widget.dropController2.text = "";
      selectedCity = 0;
      print(s);
    }

    void changeController2(int s) {
      widget.dropController2.text = s.toString();
      print(s);
    }

    double screenWidth = MediaQuery.of(context).size.width;
    _dropdownItemFontSize = screenWidth * 0.04;

    return Column(
      children: [
        FutureBuilder(
          future: api,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              if (snapshot.hasData) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: GestureDetector(
                    onTap: () {
                      // Collapse the keyboard
                      FocusScope.of(context).unfocus();
                    },
                    child: DropdownButtonFormField(
                      value: widget.dropController.text != ""
                          ? int.parse(widget.dropController.text)
                          : selectedValue,
                      items: snapshot.data.map<DropdownMenuItem<int>>(
                        (MainModel state) {
                          return DropdownMenuItem<int>(
                            value: state.id,
                            child: Text(
                              state.name,
                              style: TextStyle(fontSize: _dropdownItemFontSize),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(() {
                          changeController(val!);
                          selectedValue = val;
                        });
                      },
                      decoration: InputDecoration(
                        label: Row(
                          children: [
                            widget.mandatory
                                ? Text(
                                    "*",
                                    style: TextStyle(color: Colors.red),
                                  )
                                : Text(""),
                            Text(
                              "State",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                  ),
                );
              } else {
                return Text("NO data");
              }
            }
          },
        ),
        FutureBuilder(
          future: ApiCall().checkCity(widget.dropController.text),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              if (snapshot.hasData) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: GestureDetector(
                    onTap: () {
                      // Collapse the keyboard
                      FocusScope.of(context).unfocus();
                    },
                    child: DropdownButtonFormField(
                      value: widget.dropController2.text != ""
                          ? int.parse(widget.dropController2.text)
                          : selectedCity,
                      items: snapshot.data.map<DropdownMenuItem<int>>(
                        (MainModel statecity) {
                          return DropdownMenuItem<int>(
                            value: statecity.id,
                            child: Text(
                              statecity.name,
                              style: TextStyle(fontSize: _dropdownItemFontSize),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(() {
                          changeController2(val!);
                          selectedCity = val;
                        });
                      },
                      decoration: InputDecoration(
                        label: Row(
                          children: const [
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            ),
                            Text(
                              "City",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                  ),
                );
              } else {
                return Text("Invalid option/ Server Error");
              }
            }
          },
        ),
      ],
    );
  }
}
