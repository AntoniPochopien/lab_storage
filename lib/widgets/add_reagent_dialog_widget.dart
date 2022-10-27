import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/reagent_model.dart';
import '../providers/users_provider.dart';
import '../providers/reagent_provider.dart';

class addReagentDialog extends StatefulWidget {
  bool isEditing;
  int? id;

  addReagentDialog(this.isEditing, this.id);

  @override
  State<addReagentDialog> createState() => _addReagentDialogState();
}

class _addReagentDialogState extends State<addReagentDialog> {
  int? nameDropdownController = null;
  int? measurementDropdownController = null;
  TextEditingController reagentNameController = TextEditingController();
  TextEditingController financingController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController fvController = TextEditingController();
  TextEditingController massController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  DateTime date = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  void validateFun() {
    if (_formKey.currentState!.validate()) {}
  }

  Future opneDialog() => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Uwaga!'),
          content: const Text('Czy napewno chcesz edytować ten odczynnik?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Tak')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('Anuluj')),
          ],
        );
      });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEditing) {
      final item = Provider.of<ReagentProvider>(context, listen: false)
          .reagents[widget.id!];
      reagentNameController.text = item.reagentName;
      financingController.text = item.financing;
      priceController.text = item.price.toString();
      fvController.text = item.fv;
      massController.text = item.mass.toString();
      date = item.date;
      nameDropdownController =
          Provider.of<UsersProvider>(context, listen: false)
              .findUserIdByName(item.name);
      measurementDropdownController =
          Provider.of<ReagentProvider>(context, listen: false)
              .findIdByMeasurement(item.measurement);
      commentController.text = item.comment;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UsersProvider>(context);
    final reagentData = Provider.of<ReagentProvider>(context);
    final screenSize = MediaQuery.of(context).size;
    return Dialog(
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: Center(
                  child: Text(
                widget.isEditing ? 'Edytuj' : 'Przyjęcie Magazynowe',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800]),
              ))),
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 128, vertical: 64),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: screenSize.width * 0.15,
                              child: DropdownButtonFormField(
                                value: nameDropdownController,
                                validator: (value) {
                                  if (value == null) {
                                    return '';
                                  }
                                },
                                decoration: const InputDecoration(
                                    errorStyle: TextStyle(height: 0),
                                    border: OutlineInputBorder(),
                                    label: Text('Imię')),
                                onChanged: (value) => setState(
                                    () => nameDropdownController = value!),
                                items: userData.users.map((e) {
                                  return DropdownMenuItem(
                                      value: e.id, child: Text(e.name));
                                }).toList(),
                              )),
                          SizedBox(
                            width: screenSize.width * 0.15,
                            child: TextFormField(
                              onChanged: (value) => validateFun(),
                              controller: reagentNameController,
                              decoration: const InputDecoration(
                                  errorStyle: TextStyle(height: 0),
                                  border: OutlineInputBorder(),
                                  label: Text('Nazwa Odczynnika')),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '';
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.15,
                            child: TextFormField(
                              onChanged: (value) => validateFun(),
                              controller: financingController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '';
                                }
                              },
                              decoration: const InputDecoration(
                                  errorStyle: TextStyle(height: 0),
                                  border: OutlineInputBorder(),
                                  label: Text('Finansowanie')),
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.15,
                            child: TextFormField(
                              controller: priceController,
                              onChanged: (value) => validateFun(),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.contains(RegExp(
                                        r'[a-zA-Z!@#$%^&*()\-_+=<>?/~`|\\,]'))) {
                                  return '';
                                }
                              },
                              decoration: const InputDecoration(
                                  errorStyle: TextStyle(height: 0),
                                  border: OutlineInputBorder(),
                                  label: Text('Cena')),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: screenSize.width * 0.15,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    controller: massController,
                                    onChanged: (value) => validateFun(),
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          value.contains(
                                            RegExp(
                                                r'[a-zA-Z!@#$%^&*()\-_+=<>?/~`|\\,]'),
                                          )) {
                                        return '';
                                      }
                                    },
                                    decoration: const InputDecoration(
                                        errorStyle: TextStyle(height: 0),
                                        border: OutlineInputBorder(),
                                        label: Text('Gramatura')),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: DropdownButtonFormField(
                                    value: measurementDropdownController,
                                    validator: (value) {
                                      if (value == null) {
                                        return '';
                                      }
                                    },
                                    decoration: const InputDecoration(
                                        errorStyle: TextStyle(height: 0),
                                        border: OutlineInputBorder(),
                                        label: Text('Unit')),
                                    onChanged: (value) => setState(() =>
                                        measurementDropdownController = value!),
                                    items: reagentData.measurement.map((e) {
                                      return DropdownMenuItem(
                                          value: e.id, child: Text(e.name));
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.15,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.grey),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 17),
                                child: Text(
                                  'Data ${date.day}/${date.month}/${date.year}',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                              onPressed: () async {
                                DateTime? newDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                );
                                if (newDate == null) return;

                                setState(() => date = newDate);
                              },
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.15,
                            child: TextFormField(
                              onChanged: (value) => validateFun(),
                              controller: fvController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '';
                                }
                              },
                              decoration: const InputDecoration(
                                  errorStyle: TextStyle(height: 0),
                                  border: OutlineInputBorder(),
                                  label: Text('Nr. Faktury')),
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.15,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 128),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 6,
                    child: Container(
                      height: screenSize.height * 0.3,
                      child: TextFormField(
                        controller: commentController,
                        expands: true,
                        maxLines: null,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), label: Text('Uwagi')),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RawMaterialButton(
                            elevation: 5,
                            fillColor: Colors.green,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (widget.isEditing) {
                                  await opneDialog().then((value) {
                                    if (value == true) {
                                      reagentData.updateReagents(
                                          widget.id!,
                                          ReagentModel(
                                            id: reagentData.reagents.length + 1,
                                            reagentName:
                                                reagentNameController.text,
                                            mass: double.parse(
                                                massController.text),
                                            measurement: reagentData
                                                .measurement[
                                                    measurementDropdownController!]
                                                .name,
                                            date: date,
                                            financing: financingController.text,
                                            fv: fvController.text,
                                            price: double.parse(
                                                priceController.text),
                                            name: userData
                                                .users[nameDropdownController!]
                                                .name,
                                            comment: commentController.text,
                                          ));
                                      Navigator.of(context).pop();
                                    }
                                  });
                                } else {
                                  reagentData.addNewReagent(ReagentModel(
                                    id: reagentData.reagents.length + 1,
                                    reagentName: reagentNameController.text,
                                    mass: double.parse(massController.text),
                                    measurement: reagentData
                                        .measurement[
                                            measurementDropdownController!]
                                        .name,
                                    date: date,
                                    financing: financingController.text,
                                    fv: fvController.text,
                                    price: double.parse(priceController.text),
                                    name: userData
                                        .users[nameDropdownController!].name,
                                    comment: commentController.text,
                                  ));
                                  Navigator.of(context).pop();
                                }
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Zapisz',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          RawMaterialButton(
                            elevation: 5,
                            fillColor: Colors.grey,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Anuluj',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
