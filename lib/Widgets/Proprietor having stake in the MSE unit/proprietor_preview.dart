import 'package:flutter/material.dart';
import 'package:nsic/Models/MainModel.dart';
import 'package:nsic/Widgets/Proprietor%20having%20stake%20in%20the%20MSE%20unit/proprietor_model.dart';
import 'package:nsic/api_call.dart';

class ProprietorPreview extends StatefulWidget {
  final List<ProprietorModel> proprietorList;
  final Function(int) onEdit;
  final Function(int) onDelete;

  const ProprietorPreview({
    Key? key,
    required this.proprietorList,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<ProprietorPreview> createState() => _ProprietorPreviewState();
}

class _ProprietorPreviewState extends State<ProprietorPreview> {
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
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Address')),
          DataColumn(label: Text('Pin')),
          DataColumn(label: Text('State')),
          DataColumn(label: Text('City')),
          DataColumn(label: Text('Telephone')),
          DataColumn(label: Text('Email')),
          DataColumn(label: Text('Length of Experience(in years)')),
          DataColumn(label: Text('Adhar No.(optional)')),
          DataColumn(label: Text('Shareholding')),
        ],
        rows: widget.proprietorList.asMap().entries.map((entry) {
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
            DataCell(Text(address.name)),
            DataCell(Text(address.address)),
            DataCell(Text(address.pin)),
            DataCell(Text(getStateName(address.state))),
            DataCell(Text(getCityName(address.city))),
            DataCell(Text(address.telephone)),
            DataCell(Text(address.email)),
            DataCell(Text(address.lengthOfExperience)),
            DataCell(Text(address.adhar)),
            DataCell(Text(address.shareholding)),
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
                await ApiCall().insertProprietorStep2(
                    name: widget.proprietorList[index].name,
                    address: widget.proprietorList[index].address,
                    pin: widget.proprietorList[index].pin,
                    state: widget.proprietorList[index].state,
                    city: widget.proprietorList[index].city,
                    telephone: widget.proprietorList[index].telephone,
                    shareholding: widget.proprietorList[index].shareholding,
                    email: widget.proprietorList[index].email,
                    lengthOfExperience:
                        widget.proprietorList[index].lengthOfExperience,
                    adhar: widget.proprietorList[index].adhar,
                    delete: 1);
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
