import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/users_provider.dart';

class addReagentDialog extends StatefulWidget {
  const addReagentDialog({super.key});

  @override
  State<addReagentDialog> createState() => _addReagentDialogState();
}

class _addReagentDialogState extends State<addReagentDialog> {
  int? nameDropdownController = null;
  TextEditingController reagentNameController = TextEditingController();
  TextEditingController financingController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController fvController = TextEditingController();
  TextEditingController massController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void validateFun() {
    if (_formKey.currentState!.validate()) {
      print('good');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UsersProvider>(context);
    final screenSize = MediaQuery.of(context).size;
    return Dialog(
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: Center(
                  child: Text(
                'Przyjęcie Magazynowe',
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
                          SizedBox(
                            width: screenSize.width * 0.15,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text('Data')),
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
                            onPressed: () {
                              validateFun();
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
