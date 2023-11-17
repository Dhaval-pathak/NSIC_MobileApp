import 'package:flutter/material.dart';
import 'package:nsic/Widgets/Performance%20Statement/performance_details_model.dart';
import 'package:nsic/Widgets/Performance%20Statement/performance_prefs.dart';
import 'package:nsic/Widgets/Performance%20Statement/performance_preview.dart';
import 'package:nsic/Widgets/dropmenu.dart';
import 'package:nsic/Widgets/fieldLongWidget.dart';

class AddPerformanceRecord extends StatefulWidget {
  const AddPerformanceRecord({Key? key}) : super(key: key);

  @override
  State<AddPerformanceRecord> createState() => _AddPerformanceRecordState();
}

class _AddPerformanceRecordState extends State<AddPerformanceRecord> {
  final _formKey = GlobalKey<FormState>();
  List<PerformanceDetails> performanceList = [];
  TextEditingController orderIdController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController nameConsigneeController = TextEditingController();
  TextEditingController dateDeliveryController = TextEditingController();
  TextEditingController dateMaterialDeliveryController =
      TextEditingController();
  TextEditingController despatchingParticularsController =
      TextEditingController();
  TextEditingController remarksController = TextEditingController();
  int editPerformanceIndex = -1;

  Future<void> loadPerformanceList() async {
    final performanceList = await PerformancePreferences.loadPerformanceList();
    setState(() {
      this.performanceList = performanceList;
    });
  }

  Future<void> savePerformanceList() async {
    await PerformancePreferences.savePerformanceList(performanceList);
  }

  @override
  void initState() {
    super.initState();
    loadPerformanceList();
    if (editPerformanceIndex != -1) {
      orderIdController.text = performanceList[editPerformanceIndex].orderId;
      dateController.text = performanceList[editPerformanceIndex].date;
      descController.text = performanceList[editPerformanceIndex].description;
      quantityController.text = performanceList[editPerformanceIndex].quantity;
      valueController.text = performanceList[editPerformanceIndex].value;
      dateDeliveryController.text =
          performanceList[editPerformanceIndex].dateDelivery;
      nameConsigneeController.text =
          performanceList[editPerformanceIndex].nameConsignee;
      dateMaterialDeliveryController.text =
          performanceList[editPerformanceIndex].dateMaterialDelivery;
      despatchingParticularsController.text =
          performanceList[editPerformanceIndex].despatchingParticulars;
      remarksController.text = performanceList[editPerformanceIndex].remarks;
    }
  }

  @override
  void dispose() {
    orderIdController.dispose();
    dateController.dispose();
    descController.dispose();
    quantityController.dispose();
    valueController.dispose();
    dateDeliveryController.dispose();
    nameConsigneeController.dispose();
    dateMaterialDeliveryController.dispose();
    despatchingParticularsController.dispose();
    remarksController.dispose();

    super.dispose();
  }

  void _showDialog({int? editIndex}) {
    final isEditing = editIndex != null;
    final PerformanceDetails? editPerformance =
        isEditing ? performanceList[editIndex] : null;

    orderIdController.text = isEditing ? editPerformance!.orderId : '';
    dateController.text = isEditing ? editPerformance!.date : '';
    descController.text = isEditing ? editPerformance!.description : '';
    quantityController.text = isEditing ? editPerformance!.quantity : '';
    valueController.text = isEditing ? editPerformance!.value : '';
    dateDeliveryController.text =
        isEditing ? editPerformance!.dateDelivery : '';
    nameConsigneeController.text =
        isEditing ? editPerformance!.nameConsignee : '';
    dateMaterialDeliveryController.text =
        isEditing ? editPerformance!.dateMaterialDelivery : '';
    despatchingParticularsController.text =
        isEditing ? editPerformance!.despatchingParticulars : '';
    remarksController.text = isEditing ? editPerformance!.remarks : '';

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
                'Add Performance Record',
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
                    FieldLongWidget(
                        title: "Order Number, Date & Authority placing the contracts",
                        controller: orderIdController,
                        validationRegex: RegExp(r'\w')),
                    DateField(
                        text: "Date of Receipt of Order",
                        controller: dateController),
                    FieldLongWidget(
                        title: "Description of Stores/Product/Services",
                        controller: descController,
                        validationRegex: RegExp(r'\w')),
                    FieldLongWidget(
                        title: "Quantity",
                        controller: quantityController,
                        validationRegex: RegExp(r'\w')),
                    FieldLongWidget(
                        title: "Value (in Rs.)",
                        controller: valueController,
                        validationRegex: RegExp(r'\d+$'),
                      onlyNumber: true,
                    ),
                    FieldLongWidget(
                        title: "Name of Consignee",
                        controller: nameConsigneeController,
                        validationRegex: RegExp(r'\w')),
                    DateField(
                        text: "Due date of Delivery",
                        controller: dateDeliveryController),
                    DateField(
                        text: "Date of Material Delivery",
                        controller: dateMaterialDeliveryController),
                    FieldLongWidget(
                        title: "Despatching particulars",
                        controller: despatchingParticularsController,
                        validationRegex: RegExp(r'\w')),
                    FieldLongWidget(
                        title: "Remarks",
                        controller: remarksController,
                        validationRegex: RegExp(r'\w')),
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
                if (_formKey.currentState!.validate()) {

                  PerformanceDetails newRecord = PerformanceDetails(
                      orderId: orderIdController.text,
                      date: dateController.text,
                      description: descController.text,
                      quantity: quantityController.text,
                      value: valueController.text,
                      nameConsignee: nameConsigneeController.text,
                      dateDelivery: dateDeliveryController.text,
                      dateMaterialDelivery: dateMaterialDeliveryController.text,
                      despatchingParticulars:
                          despatchingParticularsController.text,
                      remarks: remarksController.text);

                  setState(() {
                    if (isEditing) {
                      performanceList[editIndex] = newRecord;
                    } else {
                      performanceList.add(newRecord);
                    }
                  });
                  savePerformanceList();

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
    bool empty = performanceList.isEmpty;
    bool limitForPerformanceRecords = performanceList.length >= 5;
    return Column(
      children: [
        empty
            ? SizedBox()
            : Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  PerformancePreview(
                    performanceList: performanceList,
                    onEdit: (index) {
                      setState(() {
                        editPerformanceIndex = index;
                      });
                      _showDialog(editIndex: index);
                    },
                    onDelete: (index) {
                      setState(() {
                        performanceList.removeAt(index);
                        savePerformanceList();
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  )
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
                  Icons.calendar_month,
                ),
                title: Text('Add Performance Record'),
                trailing: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffe8d3a5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    icon: Icon(
                        limitForPerformanceRecords ? Icons.lock : Icons.add,
                        color: Colors.black),
                    onPressed: () {
                      setState(() {
                        editPerformanceIndex = -1;
                      });

                      if (limitForPerformanceRecords) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Performance Record Limit Reached'),
                              content: Text(
                                  'You can only add a maximum of 5 Performance Record.'),
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
        )
      ],
    );
  }
}
