import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Basic Text field
Widget fields(
  String text,
  TextEditingController controller, [
  bool readonly = false,
  int maxLines = 1,
  bool mandatory = true,
  RegExp? validationRegex, // Add validationRegex parameter
  String? validationErrorText, // Add validationErrorText parameter
]) {
  bool isValid(String value) {
    if (validationRegex != null) {
      return validationRegex.hasMatch(value);
    }
    return true;
  }

  String? validateField(String? value) {
    if (value!.isEmpty) {
      return 'Please enter $text';
    }
    if (!isValid(value)) {
      return validationErrorText ?? 'Please enter a valid $text';
    }
    return null;
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 4),
        TextFormField(
          maxLines: maxLines,
          controller: controller,
          onChanged: (text) {},
          readOnly: readonly,
          validator: validateField,
          // Use validateField for validation
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: RichText(
              text: TextSpan(
                  style: TextStyle(
                    color: Color(0x88000000),
                  ),
                  children: [
                    mandatory
                        ? TextSpan(
                            text: "*", style: TextStyle(color: Colors.red))
                        : TextSpan(),
                    TextSpan(
                        text: text,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ))
                  ]),
            ),
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

//Date text field
class DateField extends StatefulWidget {
  final String text;
  final TextEditingController controller;
  final bool enable;
  final RegExp? validationRegex;
  final String? validationErrorText;

  const DateField({
    Key? key,
    required this.text,
    required this.controller,
    this.enable = true,
    this.validationRegex,
    this.validationErrorText,
  }) : super(key: key);

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  @override
  Widget build(BuildContext context) {
    bool isValid(String value) {
      if (widget.validationRegex != null) {
        return widget.validationRegex!.hasMatch(value);
      }
      return true;
    }

    String? validateField(String? value) {
      if (value!.isEmpty) {
        return 'Please enter ${widget.text}';
      }
      if (!isValid(value)) {
        return widget.validationErrorText ??
            'Please enter a valid ${widget.text}';
      }
      return null;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.controller,
            enabled: widget.enable,
            validator: validateField,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('dd-MM-yyyy').format(pickedDate);
                setState(() {
                  widget.controller.text =
                      formattedDate; //set output date to TextField value.
                });
              }
              // else {
              //
              // }
            },
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              label: Row(
                children: [
                  Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                  Text(
                    widget.text,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class radioGroup extends StatefulWidget {
  final String title;
  final TextEditingController option;
  final List<String> optionList;
  final List<dynamic> optionValueList;
  final mandatory;

  const radioGroup(
      {Key? key,
      required this.title,
      required this.option,
      required this.mandatory,
      required this.optionList,
      required this.optionValueList})
      : super(key: key);

  @override
  State<radioGroup> createState() => _radioGroupState();
}

class _radioGroupState extends State<radioGroup> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                widget.mandatory
                    ? TextSpan(
                        text: "*",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                        ),
                      )
                    : TextSpan(),
                TextSpan(
                  text: widget.title,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: RadioListTile(
                  title: Text(widget.optionList[0]),
                  value: widget.optionValueList[0],
                  groupValue: widget.option.text,
                  onChanged: (value) {
                    setState(() {
                      widget.option.text = value.toString();
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: Text(widget.optionList[1]),
                  value: widget.optionValueList[1],
                  groupValue: widget.option.text,
                  onChanged: (value) {
                    setState(() {
                      widget.option.text = value.toString();
                    });
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

Widget fieldsForMultipleLineLabel(
    String text, TextEditingController controller, bool mandatory, RegExp? validationRegex, // Add validationRegex parameter
    String? validationErrorText,) {
  bool isValid(String value) {
    if (validationRegex != null) {
      return validationRegex.hasMatch(value);
    }
    return true;
  }

  String? validateField(String? value) {
    if (value!.isEmpty) {
      return 'Please enter $text';
    }
    if (!isValid(value)) {
      return validationErrorText ?? 'Please enter a valid $text';
    }
    return null;
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 4),
        Column(
          children: [
            RichText(
              text: TextSpan(
                  style: TextStyle(
                    color: Color(0x88000000),
                  ),
                  children: [
                    mandatory
                        ? TextSpan(
                            text: "*", style: TextStyle(color: Colors.red))
                        : TextSpan(),
                    TextSpan(
                        text: text,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ))
                  ]),
            ),
            TextFormField(
// maxLines: maxLines,
              controller: controller,
              onChanged: (text) {},
// readOnly: readonly,
              validator: validateField,

              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
