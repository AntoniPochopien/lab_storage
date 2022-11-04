import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/reagent_provider.dart';
import '../models/reagent_model.dart';

class IssueReagentDialogWidget extends StatefulWidget {
  ReagentModel item;

  IssueReagentDialogWidget(this.item);

  @override
  State<IssueReagentDialogWidget> createState() =>
      _IssueReagentDialogWidgetState();
}

class _IssueReagentDialogWidgetState extends State<IssueReagentDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  int? measurementDropdownController;
  TextEditingController massController = TextEditingController();

  double convertMassToValid(double mass, String massTag) {
    //zmienia wagę z najmniejszej na prawidłową
    switch (massTag) {
      case 'kg':
        {
          return mass / 1000000;
        }
      case 'g':
        {
          return mass / 1000;
        }
      case 'mg':
        {
          return mass;
        }
      case 'l':
        {
          return mass / 1000;
        }
      case 'ml':
        {
          return mass;
        }
      default:
        {
          return 0;
        }
    }
  }

  double convertMassToMin(double mass, String massTag) {
    //zmienia wagę z najmniejszej na prawidłową
    switch (massTag) {
      case 'kg':
        {
          return mass * 1000000;
        }
      case 'g':
        {
          return mass * 1000;
        }
      case 'mg':
        {
          return mass;
        }
      case 'l':
        {
          return mass * 1000;
        }
      case 'ml':
        {
          return mass;
        }
      default:
        {
          return 0;
        }
    }
  }

  bool massValidator(double mass, String massTag, double maxMass) {
    int meassurementType1 = -1; //sprawdzamy czy ciecz czy ciało stałe
    int meassurementType2 = -1;
    if (widget.item.measurement == 'ml' || widget.item.measurement == 'l') {
      meassurementType1 = 0;
    } else {
      meassurementType1 = 1;
    }
    if (massTag == 'ml' || massTag == 'l') {
      meassurementType2 = 0;
    } else {
      meassurementType2 = 1;
    }

    if (meassurementType1 == meassurementType2) {
      if (mass > maxMass) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final reagentData = Provider.of<ReagentProvider>(context);
    final screenSize = MediaQuery.of(context).size;
    return Dialog(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'Wydanie Magazynowe',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800]),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 128, vertical: 64),
              child: Form(
                key: _formKey,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: screenSize.width * 0.15,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          widget.item.reagentName,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width * 0.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(flex: 1, child: SizedBox()),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      controller: massController,
                                      decoration: const InputDecoration(
                                          errorStyle: TextStyle(height: 0),
                                          border: OutlineInputBorder(),
                                          label: Text('Gramatura')),
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
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
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
                                          measurementDropdownController =
                                              value!),
                                      items: reagentData.measurement.map((e) {
                                        return DropdownMenuItem(
                                            value: e.id, child: Text(e.name));
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                  'Max: ${convertMassToValid(widget.item.mass, widget.item.measurement)} ${widget.item.measurement}'),
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
                            padding: const EdgeInsets.symmetric(vertical: 17),
                            child: Text(
                              'Data: ${date.day}/${date.month}/${date.year}',
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
                    ]),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 128),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Expanded(
                    flex: 6,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 7,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RawMaterialButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (massValidator(
                                    convertMassToMin(
                                        double.parse(massController.text),
                                        reagentData
                                            .measurement[
                                                measurementDropdownController!]
                                            .name),
                                    reagentData
                                        .measurement[
                                            measurementDropdownController!]
                                        .name,
                                    widget.item.mass)) {
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Błąd!'),
                                      content: const Text(
                                          'Podałeś zbyt dużą masę lub nieodpowiednie oznaczenie masy'),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('OK'))
                                      ],
                                    ),
                                  );
                                }
                              }
                            },
                            elevation: 5,
                            fillColor: Colors.green,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Zatwierdź',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          RawMaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            elevation: 5,
                            fillColor: Colors.grey,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Anuluj',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
