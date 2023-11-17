import 'package:flutter/material.dart';
import 'package:nsic/Models/MainModel.dart';

class CommonDropDownMenu extends StatefulWidget {
  final String title;
  final TextEditingController dropController;
  final Future<List<MainModel>> options;

  const CommonDropDownMenu({
    Key? key,
    required this.title,
    required this.dropController,
    required this.options,
  }) : super(key: key);

  @override
  State<CommonDropDownMenu> createState() => _CommonDropDownMenuState();
}

class _CommonDropDownMenuState extends State<CommonDropDownMenu> {
  double _dropdownItemFontSize = 20;
  int selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    void changeController(int s) {
      widget.dropController.text = s.toString();
      print(s);
    }

    double screenWidth = MediaQuery.of(context).size.width;
    _dropdownItemFontSize = screenWidth * 0.04;

    return FutureBuilder(
      future: widget.options,

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: LinearProgressIndicator(),
          );
        } else {
          if (snapshot.hasData) {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: DropdownButtonFormField(
                    value: widget.dropController.text != ""
                        ? int.parse(widget.dropController.text)
                        : selectedValue,
                    items: snapshot.data!
                        .map<DropdownMenuItem<int>>((MainModel branch) {
                      return DropdownMenuItem<int>(
                          value: branch.id,
                          child: Text(
                            branch.name,
                            style: TextStyle(fontSize: _dropdownItemFontSize),
                          ));
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        changeController(val!);
                        selectedValue = val;
                      });
                    },
                    decoration: InputDecoration(
                      label: Row(
                        children: [
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          ),
                          Text(
                            widget.title,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    )));

          } else {
            return Text("No data");
          }
        }
      },
    );
  }
}
