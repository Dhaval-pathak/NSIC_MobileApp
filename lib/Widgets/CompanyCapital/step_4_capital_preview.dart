import 'package:flutter/material.dart';
import 'package:nsic/Widgets/CompanyCapital/step_4_capital_model.dart';

class CapitalOfFactoryPreview extends StatefulWidget {
  final List<Step4CapitalModel> capitalList;
  final Function(int) onEdit;

  const CapitalOfFactoryPreview(
      {Key? key, required this.capitalList, required this.onEdit})
      : super(key: key);

  @override
  State<CapitalOfFactoryPreview> createState() =>
      _CapitalOfFactoryPreviewState();
}

class _CapitalOfFactoryPreviewState extends State<CapitalOfFactoryPreview> {
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
          columns: const[
            DataColumn(label: Text("")),
            DataColumn(label: Text("Factory Address")),
            DataColumn(label: Text("Value: Land & Building")),
            DataColumn(label: Text("Value: Machinery")),
            DataColumn(label: Text("Value: Equipments")),
            DataColumn(label: Text("Current Assets")),
            DataColumn(label: Text("Current assets for Service Sector")),
            DataColumn(label: Text("Total")),
          ],
          rows: widget.capitalList.asMap().entries.map((entry) {
            final index = entry.key;
            final address = entry.value;
            return DataRow(cells: [
              DataCell(Row(
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
              ),),
              DataCell(Text(address.step4CapitalAddressController)),
              DataCell(Text(address.step4CapitalLandController)),
              DataCell(Text(address.step4CapitalMachineController)),
              DataCell(Text(address.step4CapitalEquipmentController)),
              DataCell(Text(address.step4CapitalAssetsController)),
              DataCell(Text(address.step4CapitalServiceAssetsController)),
              DataCell(Text(address.step4CapitalTotalController)),
            ]);
          }).toList()
      ),
    );
  }
}
