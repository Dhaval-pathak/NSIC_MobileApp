import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FieldLongWidget extends StatefulWidget {
  final bool mandatory;
  final String title;
  final String validationErrorText;
  final TextEditingController controller;
  final int maxLines;
  final RegExp validationRegex;
  final bool onlyNumber;

  const FieldLongWidget(
      {Key? key,
      this.mandatory = true,
      required this.title,
      required this.controller,
      this.maxLines = 1,
      this.validationErrorText = "",
      required this.validationRegex,
      this.onlyNumber = false})
      : super(key: key);

  @override
  State<FieldLongWidget> createState() => _FieldLongWidgetState();
}

class _FieldLongWidgetState extends State<FieldLongWidget> {
  @override
  Widget build(BuildContext context) {
    bool isValid(String value) {
        return widget.validationRegex.hasMatch(value);
    }

    String? validateField(String? value) {
      if (value!.isEmpty) {
        return 'Please enter ${widget.title}';
      }
      if (!isValid(value)) {
        return widget.validationErrorText ?? 'Please enter a valid ${widget.title}';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                textScaleFactor: MediaQuery.of(context).textScaleFactor,
                text: TextSpan(
                    style: TextStyle(
                      color: Color(0x88000000),
                    ),
                    children: [
                      widget.mandatory
                          ? TextSpan(
                              text: "*", style: TextStyle(color: Colors.red))
                          : TextSpan(),
                      TextSpan(
                          text: widget.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ))
                    ]),
              ),
              TextFormField(
                maxLines: widget.maxLines,
                controller: widget.controller,
                keyboardType: widget.onlyNumber ? TextInputType.number: null,
                inputFormatters: widget.onlyNumber? <TextInputFormatter>[FilteringTextInputFormatter.singleLineFormatter]: null,
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
}
