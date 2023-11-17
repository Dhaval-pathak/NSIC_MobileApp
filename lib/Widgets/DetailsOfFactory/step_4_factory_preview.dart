import 'package:flutter/material.dart';
import '../DetailsOfFactory/step_4_factory_model.dart';

class DetailsOfFactoryPreview extends StatefulWidget {
  final List<Step4FactoryModel> storeList;
  final Function(int) onEdit;

  const DetailsOfFactoryPreview({
    Key? key,
    required this.storeList,
    required this.onEdit,
  }) : super(key: key);

  @override
  State<DetailsOfFactoryPreview> createState() =>
      _DetailsOfFactoryPreviewState();
}

class _DetailsOfFactoryPreviewState extends State<DetailsOfFactoryPreview> {
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
          DataColumn(label: Text('Factory Address')),
          DataColumn(label: Text('Address')),
          DataColumn(label: Text('Tel. No.')),
          DataColumn(label: Text('Horse Power - allotted')),
          DataColumn(label: Text('Horse Power - installed:')),
          DataColumn(
              label: Text(
                  'Brief Description of the Factory/\nGodown Covered/Uncovered Area\nDepartments and laboratories etc.:')),
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
                ],
              ),
            ),
            DataCell(Text(address.step4factoryaddressController)),
            DataCell(Text(address.step4AddressController)),
            DataCell(Text(address.step4teleController)),
            DataCell(Text(address.step4powerController)),
            DataCell(Text(address.step4power2Controller)),
            DataCell(Text(address.step4descController)),
          ]);
        }).toList(),
      ),
    );
  }
}
