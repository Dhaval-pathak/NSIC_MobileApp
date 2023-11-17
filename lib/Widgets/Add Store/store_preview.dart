import 'package:flutter/material.dart';
import 'package:nsic/Widgets/Add%20Store/store_model.dart';

import '../../Screens/Components/components_3.dart';
import '../../api_call.dart';


class StorePreview extends StatefulWidget {
  final List<StoreModel> storeList;
  final Function(int) onEdit;
  final Function(int) onDelete;

  const StorePreview({
    Key? key,
    required this.storeList,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<StorePreview> createState() => _StorePreviewState();
}

class _StorePreviewState extends State<StorePreview> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final headingRowColor = MaterialStateColor.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.grey;
      }
      return Color(0xffeacb90);
    });
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: MaterialStateProperty.all<Color>(headingRowColor),
        decoration: BoxDecoration(
          color: Color(0xfffff2d8),
        ),
        border: TableBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        columns: const [
          DataColumn(label: Text('')),
          DataColumn(label: Text('S no./\nCode')),
          DataColumn(label: Text('Location')),
          DataColumn(label: Text('Description/ Stores\n/ Products/Services')),
          DataColumn(label: Text('Ref. of BIS Specification\nor other Specification')),
          DataColumn(label: Text('Model/ Brand')),
          DataColumn(label: Text('Limiting Size Capacity')),
          DataColumn(label: Text('Monthly Production Capacity\nper shift')),
          DataColumn(label: Text('No. of shifts factory\nnormally works')),
        ],
        rows: widget.storeList.asMap().entries.map((entry) {
          final index = entry.key;
          final address = entry.value;
          return DataRow(cells: [
            DataCell(
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.095,
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        widget.onEdit(index);
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _showDeleteConfirmation(context, index);
                    },
                  ),
                ],
              ),
            ),
            DataCell(Text(address.sno)),
            DataCell(Text(address.location)),
            DataCell(Text(address.description)),
            DataCell(Text(address.bisSpecification)),
            DataCell(Text(address.model)),
            DataCell(Text(address.limitingSizeCapacity)),
            DataCell(Text(address.monthlyProductionCapacity)),
            DataCell(Text(address.numberOfShifts)),
          ]);
        }).toList(),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Address'),
          content: Text('Are you sure you want to delete this address?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                await ApiCall().insertStoreStep3(

                    Description:widget.storeList[index].description,
                    location:widget.storeList[index].location ,
                    BIS: widget.storeList[index].bisSpecification,
                    Model: widget.storeList[index].model,
                    Size: widget.storeList[index].monthlyProductionCapacity,
                    Capacity: widget.storeList[index].monthlyProductionCapacity,
                    NumberOfShifts: int.parse(widget.storeList[index].numberOfShifts),
                    SerialNo: int.parse(widget.storeList[index].sno),

                    delete: 1,);
                widget.onDelete(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
