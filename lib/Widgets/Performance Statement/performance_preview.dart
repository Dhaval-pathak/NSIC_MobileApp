import 'package:flutter/material.dart';
import 'package:nsic/Widgets/Performance%20Statement/performance_details_model.dart';

class PerformancePreview extends StatefulWidget {
  late List<PerformanceDetails> performanceList;
  final Function(int) onEdit;
  final Function(int) onDelete;

  PerformancePreview({Key? key,
    required this.performanceList,
    required this.onEdit,
    required this.onDelete})
      : super(key: key);

  @override
  State<PerformancePreview> createState() => _PerformancePreviewState();
}

class _PerformancePreviewState extends State<PerformancePreview> {
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
            DataColumn(label: Text(
                'Order Number')),
            DataColumn(label: Text('Date of Receipt of Order')),
            DataColumn(label: Text('Description')),
            DataColumn(label: Text('Quantity')),
            DataColumn(label: Text('Value (in Rs.)')),
            DataColumn(label: Text('Name of Consignee	')),
            DataColumn(label: Text('Due date of Delivery')),
            DataColumn(label: Text('Date of Material Delivery	')),
            DataColumn(label: Text('Despatching particulars')),
            DataColumn(label: Text('Remarks')),
          ],
          rows: widget.performanceList.asMap().entries.map((entry) {
            final index = entry.key;
            final record = entry.value;
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
              DataCell(Text(record.orderId)),
              DataCell(Text(record.date)),
              DataCell(Text(record.description)),
              DataCell(Text(record.quantity)),
              DataCell(Text(record.value)),
              DataCell(Text(record.nameConsignee)),
              DataCell(Text(record.dateDelivery)),
              DataCell(Text(record.dateMaterialDelivery)),
              DataCell(Text(record.despatchingParticulars)),
              DataCell(Text(record.remarks)),
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
          title: Text('Delete Performance Record'),
          content: Text('Are you sure you want to delete this Performance Record?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
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
