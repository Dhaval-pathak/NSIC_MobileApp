import 'package:flutter/material.dart';
import 'package:nsic/Widgets/CompanyCapital/step_4_add_capital.dart';
import 'package:nsic/Widgets/Performance%20Statement/add_performance_statement.dart';
import 'package:nsic/Widgets/TechinalFacilities/step_4_add_facilities.dart';
import 'package:nsic/Widgets/commonDropDownMenu.dart';
import 'package:nsic/Widgets/dropmenu.dart';
import 'package:nsic/Widgets/fieldLongWidget.dart';
import 'package:nsic/Widgets/stateCityDropDownMenu.dart';
import 'package:nsic/api_call.dart';
import '../Widgets/Add Factory Address/add_address_Factories.dart';
import '../Widgets/Add Store/add_store.dart';
import '../Widgets/DetailsOfFactory/step_4_adding_factory.dart';
import '../Widgets/Proprietor having stake in the MSE unit/add_proprietor.dart';

//Class for Expansion model
class ExpansionPanelModel {
  ExpansionPanelModel(
    this.title,
    this.body,
    this.key,
  );

  String title;
  Widget body;
  GlobalKey<FormState> key;
}

//Function for the model
List<ExpansionPanelModel> getStep1Controller({
  // General Controllers
  required TextEditingController panController,
  required TextEditingController udyamController,
  required TextEditingController nameController,
  required TextEditingController dateController,
  required TextEditingController branchController,
  required TextEditingController specialController,
  required TextEditingController ayushController,
  required TextEditingController gstController,
  required TextEditingController shareController,
  required TextEditingController constController,

  //Head Office Controllers
  required TextEditingController addressController,
  required TextEditingController pinController,
  required TextEditingController stateController,
  required TextEditingController teleController,
  required TextEditingController mobileController,
  required TextEditingController emailController,
  required TextEditingController cityController,

  //Branch Controllers
  required TextEditingController branchAddController,
  required TextEditingController branchPinController,
  required TextEditingController branchStateController,
  required TextEditingController branchCityController,
  required TextEditingController branchTeleController,
  required TextEditingController branchEmailController,

  // Extra Controller
  required TextEditingController socialController,
  required TextEditingController entrepreneurController,
  required TextEditingController unitSizeController,
  required GlobalKey<FormState> formKey0,
  required GlobalKey<FormState> formKey1,
  required GlobalKey<FormState> formKey2,
  required GlobalKey<FormState> formKey3,
  required GlobalKey<FormState> formKey4,
}) {
  // final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  return [
    // General
    ExpansionPanelModel(
        'General',
        Column(
// key: formKey0,

          children: [
            CommonDropDownMenu(
              title: "Branch",
              options: ApiCall().showBranch(),
              dropController: branchController,
            ),
            CommonDropDownMenu(
                title: "Constitution of the MSE",
                dropController: constController,
                options: ApiCall().showConstitution()),
            fields("PAN Card", panController, true),
            fields("Udyam Registration Number", udyamController, true),
            radioGroup(
              title: "Is MSE engaged with Ayush medicine [AYUSH REGISTRATION]",
              option: ayushController,
              mandatory: false,
              optionList: const ["Yes", "No"],
              optionValueList: const ["Yes", "No"],
            ),
            radioGroup(
              title:
                  "Under IT Act 2000, section 43(A) do you agree to share your information like contact details, unit and product related information with buying agencies for procurement under public procurement policy of government of India ",
              option: shareController,
              mandatory: true,
              optionList: const ["Yes", "No"],
              optionValueList: const ["Yes", "No"],
            ),
            fields(
              "Name of Applicant MSE",
              nameController,
              false,
              1,
              true,
            ),
            fields(
              "GST Number",
              gstController,
              false,
              1,
              true,
              RegExp(r'^\d{2}[A-Z]{5}\d{4}[A-Z][1-9A-Z]Z[\dA-Z]$'),
              'Please enter a Valid GST number',
            ),
            DateField(
              text: "Date",
              controller: dateController,
              enable: false,
            ),
            Divider(),
          ],
        ),
        formKey0),

    // Head Office
    ExpansionPanelModel(
        'Head Office',
        Column(
          children: [
            fields("Address", addressController, false, 5),
            fields(
              "Pin Code",
              pinController,
              false,
              1,
              true,
              RegExp(r'^\d{6}$'),
              'Please enter a valid PIN code',
            ),
            StateCityDropDownMenu(
                title: "State",
                dropController: stateController,
                dropController2: cityController,
                options: ApiCall().showState(),
                mandatory: true),
            fields(
              "Telephone",
              teleController,
              false,
              1,
              true,
              RegExp(r'^\d{10}$'),
              'Please enter a valid telephone number',
              // formKey1
            ),
            fields("Mobile No", mobileController, false, 1, false),
            fields(
              'Email',
              emailController,
              false,
              1,
              true,
              RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$'),
              // Add regex pattern
              'Please enter a valid email address',
              // formKey1, // Add custom error message
            ),
          ],
        ),
        formKey1),

    //Factory
    ExpansionPanelModel('Factory Addresses', AddAddressFactory(), formKey2),

    //Branch
    ExpansionPanelModel(
        'Branch Address (optional)',
        Column(
          children: [
            fields("Address", branchAddController, false, 5, false),
            fields("Pin Code", branchPinController, false, 1, false),
            StateCityDropDownMenu(
                options: ApiCall().showState(),
                title: "State",
                dropController: branchStateController,
                dropController2: branchCityController,
                mandatory: false),
            fields("Telephone", branchTeleController, false, 1, false),
            fields("E-mail", branchEmailController, false, 1, false),
          ],
        ),
        formKey3),

    // Extras

    ExpansionPanelModel(
        'Any Special Category of Entrepreneur',
        Column(
          children: [
            CommonDropDownMenu(
                title: "Enterprise Social Category",
                dropController: socialController,
                options: ApiCall().showSocial()),
            CommonDropDownMenu(
                title: "Any Special Category of Enterpreneur",
                dropController: entrepreneurController,
                options: ApiCall().showEntrepreneur()),
            CommonDropDownMenu(
                title: "Category Unit Size",
                dropController: unitSizeController,
                options: ApiCall().showUnitSize())
          ],
        ),
        formKey4),
  ];
}

List<ExpansionPanelModel> getStep2({
  required TextEditingController inCopDate,
  required TextEditingController productionDate,
  required GlobalKey<FormState> formKey0,
  required GlobalKey<FormState> formKey1,
  required TextEditingController constController_Step2,
}) {
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  return [
    ExpansionPanelModel(
        "Status of applicant MSE",
        Column(
          children: [
            DateField(
              text: "Date of Incorporation",
              controller: inCopDate,
              validationRegex: RegExp(
                  r'^(0[1-9]|1\d|2\d|3[01])-(0[1-9]|1[012])-(19|20)\d\d$'),
              validationErrorText: "Enter Valid Date (DD-MM-YYYY)",
            ),
            DateField(
              text: "Date of commencement of production/business",
              controller: productionDate,
              validationRegex: RegExp(
                  r'^(0[1-9]|1\d|2\d|3[01])-(0[1-9]|1[012])-(19|20)\d\d$'),
              validationErrorText: "Enter Valid Date (DD-MM-YYYY)",
            ),
            CommonDropDownMenu(
                title: "Constitution of the MSE",
                dropController: constController_Step2,
                options: ApiCall().showConstitution()),
          ],
        ),
        formKey0),
    ExpansionPanelModel('Add Proprietor', AddProprietor(), formKey2)
  ];
}

List<ExpansionPanelModel> getStep3({
  required TextEditingController actController,
  required TextEditingController holdingController,
  required TextEditingController gemController,
  required TextEditingController suppliersController,
  required GlobalKey<FormState> formKey0,
  required GlobalKey<FormState> formKey1,
}) {
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  return [
    ExpansionPanelModel(
        "Status of applicant MSE (continue from step 2)",
        Column(
          children: [
            CommonDropDownMenu(
                title: "Whether your MSE is registered under",
                dropController: actController,
                options: ApiCall().showAct()),
            fieldsForMultipleLineLabel(
                "If the MSE is a subsidiary/Associate of an Indian/foreign/large scale company, give particulars of Parent/holding Company:",
                holdingController,
                true,
                RegExp(r'\w'),
                '')
          ],
        ),
        formKey0),
    ExpansionPanelModel(
        "Stores for which registration is required",
        Column(
          children: [
            fieldsForMultipleLineLabel(
                "Whether you are registered with GeM or any other government department? If so, give registration No",
                gemController,
                true,
                RegExp(r'\w'),
                ''),
            fieldsForMultipleLineLabel(
                "Have you supplied any stores/products or rendered any services to the Government through GeM, Direct to the Government Department or through any other Supplier?",
                suppliersController,
                true,
                RegExp(r'\w'),
                '')
          ],
        ),
        formKey1),
    ExpansionPanelModel('Add Store', AddStore(), formKey2),
  ];
}

List<ExpansionPanelModel> getStep4({
  required TextEditingController fullyTestedController,
  required TextEditingController resultOfOperationsAndFinancialPositionController,
  required TextEditingController nameAndAddressBankersController,
  required TextEditingController bisMarkedController,
  required TextEditingController isoCertificationController,
  required TextEditingController nameConfirmController,
  required TextEditingController designationConfirmController,
  required GlobalKey<FormState> formKey0,
  required GlobalKey<FormState> formKey1,
  required GlobalKey<FormState> formKey2,
  required GlobalKey<FormState> formKey3,
  required GlobalKey<FormState> formKey4,
  required GlobalKey<FormState> formKey5,
  required GlobalKey<FormState> formKey6,
}) {
  return [
    ExpansionPanelModel(
        "Details of Factory/Godown", AddDetailFactory(), formKey0),
    ExpansionPanelModel(
        "Detail of capital structure:-", AddCapitalDetails(), formKey1),
    ExpansionPanelModel(
        "Technical facilities", AddFacilitiesDetails(), formKey2),
    ExpansionPanelModel("Testing",
        Column(
          children: [
            FieldLongWidget(
                title: "State if the products have been fully tested, including type tests where required in specifications.",
                controller: fullyTestedController,
                validationRegex: RegExp(r'\w')),
            FieldLongWidget(
                title: "Statement indicating the Result of Operations and Financial Position of the MSE Unit for the last three years (year-wise) duly supported by relevant Audited Balance Sheets (Annexure-C)",
                controller: resultOfOperationsAndFinancialPositionController,
                validationRegex: RegExp(r'\w')),
            FieldLongWidget(
                title: "Name and address of the Bankers (Indicate Account No. with each bank and submit Bankers Report in Original as per proforma in Annexure-E in Upload section at Step 5)",
                controller: nameAndAddressBankersController,
                validationRegex: RegExp(r'\w')),
          ],
        ), formKey5),
    ExpansionPanelModel(
        "Additional/Optional information",
        Column(children: [
          FieldLongWidget(
            title: "State if the products are BIS Marked.",
              controller: bisMarkedController,
              validationRegex: RegExp(r'\w')),
          FieldLongWidget(
              title: "State if the firm has ISO Certification. If yes, provide certification no. and validity",
              controller: isoCertificationController,
              validationRegex: RegExp(r'\w')),
        ],),
        formKey6),
    ExpansionPanelModel(
        "Name and designation of the signatory of this application",
        Column(
          children: [
            FieldLongWidget(
                title: "Name of the signatory of this application	",
                controller: nameConfirmController,
                validationRegex: RegExp(r'\w')),
            FieldLongWidget(
                title: "Designation of the signatory of this application",
                controller: designationConfirmController,
                validationRegex: RegExp(r'\w')),
          ],
        ),
        formKey3),
    ExpansionPanelModel(
        "Performance Statement", AddPerformanceRecord(), formKey4)
  ];
}
