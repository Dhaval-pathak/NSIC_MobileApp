import 'package:flutter/material.dart';
import 'package:nsic/Widgets/TechinalFacilities/step_4_facilities_model.dart';

class FacilitiesOfFactoryPreview extends StatefulWidget {
  final List<Step4FacilitiesModel> facilitiesList;
  final Function(int) onEdit;

  const FacilitiesOfFactoryPreview(
      {Key? key, required this.facilitiesList, required this.onEdit})
      : super(key: key);

  @override
  State<FacilitiesOfFactoryPreview> createState() =>
      _FacilitiesOfFactoryPreviewState();
}

class _FacilitiesOfFactoryPreviewState
    extends State<FacilitiesOfFactoryPreview> {
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
            DataColumn(label: Text("Details of plant and machinery installed")),
            DataColumn(label: Text("Full information of the technical know-how of products with flow chart.")),
            DataColumn(label: Text("Quality control arrangement for routine and acceptance test ")),
            DataColumn(label: Text("Details of testing machinery & facilities")),
          ],
          rows: widget.facilitiesList.asMap().entries.map((entry) {
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
              DataCell(Text(address.facilitiesAddressController)),
              DataCell(Text(address.plantAndMachineDetailsController)),
              DataCell(Text(address.technicalFlowDetailsController)),
              DataCell(Text(address.qualityControlDetailsController)),
              DataCell(Text(address.testingDetailsController))
            ]);
          }).toList()
      ),
    );
  }
}
