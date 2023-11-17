import 'package:flutter/material.dart';
import 'package:nsic/Models/MainModel.dart';
import 'package:nsic/api_call.dart';
import 'address_detail_model.dart';

class AddressPreview extends StatefulWidget {
  late List<AddressDetails> addressList;
  final Function(int) onEdit;
  final Function(int) onDelete;

  AddressPreview(
      {Key? key,
      required this.onEdit,
      required this.onDelete,
      required this.addressList})
      : super(key: key);

  @override
  State<AddressPreview> createState() => _AddressPreviewState();
}

class _AddressPreviewState extends State<AddressPreview> {
  List<MainModel> state = [];
  List<MainModel> city = [];
  @override
  void initState() {
    super.initState();
    getStateCity();
  }

  void getStateCity() async {
    List<MainModel> state1 = await ApiCall().showState();
    List<MainModel> city1 = await ApiCall().showCity();
    for (var element in state1) {
      setState(() {
        state.add(MainModel(id: element.id, name: element.name));
      });
    }
    for (var element in city1) {
      setState(() {
        city.add(MainModel(id: element.id, name: element.name));
      });
    }
  }

  String getStateName(String stateid) {
    String stateName = "";
    for (var element in state) {
      if (element.id == int.parse(stateid)) {
        stateName = element.name;
      }
    }
    return stateName;
  }

  String getCityName(String cityId) {
    String cityName = "";
    for (var element in city) {
      if (element.id == int.parse(cityId)) {
        cityName = element.name;
      }
    }
    return cityName;
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
          DataColumn(label: Text('Address')),
          DataColumn(label: Text('Pin')),
          DataColumn(label: Text('State')),
          DataColumn(label: Text('District/City')),
          DataColumn(label: Text('Tel')),
          DataColumn(label: Text('Email')),
          DataColumn(label: Text('Nature of Operation')),
        ],
        rows: widget.addressList.asMap().entries.map((entry) {
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
            DataCell(Text(address.address)),
            DataCell(Text(address.pin)),
            DataCell(Text(getStateName(address.state))),
            DataCell(Text(getCityName(address.district))),
            DataCell(Text(address.tel)),
            DataCell(Text(address.email)),
            DataCell(
                Text(address.nature == "1" ? "Manufacturing" : "Services")),
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
