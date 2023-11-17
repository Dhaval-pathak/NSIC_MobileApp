import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nsic/Models/existingDataExceptGridModel.dart';
import 'package:nsic/Models/existingDataModel.dart';
import 'package:nsic/Models/step1Model.dart';
import 'package:nsic/Providers/progress_indicator.dart';
import 'package:nsic/Screens/Components/components_4.dart';
import 'package:nsic/Screens/Components/components_5.dart';
import 'package:nsic/Utilities/customAppbar.dart';
import 'package:nsic/Widgets/Add%20Factory%20Address/address_detail_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Models/Step2_Data_Fetched_ForProprietor.dart';
import 'Models/Step2_Data_Fetched_ForStatusOfApplicantMSE.dart';
import 'Screens/Components/components_1.dart';
import 'Screens/Components/components_2.dart';
import 'Screens/Components/components_3.dart';
import 'Utilities/decode.dart';
import 'Widgets/Add Factory Address/address_prefs.dart';
import 'Widgets/Proprietor having stake in the MSE unit/proprietor_model.dart';
import 'Widgets/Proprietor having stake in the MSE unit/proprietor_prefs.dart';
import 'api_call.dart';

class Step1 extends StatefulWidget {
  final Step1Model xmlData;
  final List<ExistingDataModel> existingData;
  final List<ExistingDataExceptGridModel> existingDataMain;
  final int status;
  final int branchId;
  final int constitutionId;

  const Step1(
      {Key? key,
      required this.xmlData,
      required this.existingData,
      required this.status,
      required this.existingDataMain,
      this.branchId = 0,
      this.constitutionId = 0})
      : super(key: key);

  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  @override
  void initState() {
    print("App branchId ${widget.branchId}");
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(),
        body: Container(
            color: Color(0x69fffadd),
            child: Component1(
              xmlData: widget.xmlData,
              existingData: widget.existingData,
              existingDataMain: widget.existingDataMain,
              constitutionId: widget.constitutionId,
              branchId: widget.branchId,
              status: widget.status,
            )));
  }
}
