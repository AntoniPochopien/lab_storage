import 'package:flutter/material.dart';
import 'package:lab_storage/local_storage/users_files_logic.dart';

class addReagentDialog extends StatefulWidget {
  const addReagentDialog({super.key});

  @override
  State<addReagentDialog> createState() => _addReagentDialogState();
}

class _addReagentDialogState extends State<addReagentDialog> {
  int? nameDropdownController = null;
  @override
  Widget build(BuildContext context) {
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
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 128, vertical: 64),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: screenSize.width * 0.15,
                              child: DropdownButton(
                                value: nameDropdownController,
                                onChanged: (value) => setState(
                                    () => nameDropdownController = value!),
                                items: users.map((e) {
                                  return DropdownMenuItem(
                                      value: e.id, child: Text(e.name));
                                }).toList(),
                              )),
                          Container(
                            width: screenSize.width * 0.15,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text('Nazwa Odczynnika')),
                            ),
                          ),
                          Container(
                            width: screenSize.width * 0.15,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text('Finansowanie')),
                            ),
                          ),
                          Container(
                            width: screenSize.width * 0.15,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text('Cena')),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: screenSize.width * 0.15,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text('Gramatura')),
                            ),
                          ),
                          Container(
                            width: screenSize.width * 0.15,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text('Data')),
                            ),
                          ),
                          Container(
                            width: screenSize.width * 0.15,
                            child: TextFormField(
                              decoration: InputDecoration(
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
                              setState(() {});
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
