import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/reagent_provider.dart';
import '../providers/archives_provider.dart';
import '../models/archives_model.dart';
import '../widgets/issue_reagent_dialog_widget.dart';

class ReagentWidget extends StatefulWidget {
  bool isSelected;
  int id;
  String reagentName; //nazwa odczynnika
  double mass; //gramatura
  String
      measurement; //oznaczenie miary do gramatury ^ Litry gramy kilogramy itp
  DateTime date;

  String financing;
  double price;
  String name; //imie kogos?

  ReagentWidget({
    required this.isSelected,
    required this.id,
    required this.reagentName,
    required this.mass,
    required this.measurement,
    required this.date,
    required this.financing,
    required this.price,
    required this.name,
  });

  @override
  State<ReagentWidget> createState() => _ReagentWidgetState();
}

class _ReagentWidgetState extends State<ReagentWidget> {
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

  @override
  Widget build(BuildContext context) {
    final reagentData = Provider.of<ReagentProvider>(context);
    final archivesData = Provider.of<ArchivesProvider>(context);
    return Container(
      child: Card(
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 2,
                  color: widget.isSelected ? Colors.green : Colors.white)),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Center(child: SelectableText(widget.id.toString()))),
              Expanded(
                  flex: 2,
                  child: Center(child: SelectableText(widget.reagentName))),
              Expanded(
                  flex: 2,
                  child: Center(
                      child: SelectableText(
                    '${convertMassToValid(widget.mass, widget.measurement).toString()} ${widget.measurement}', //${widget.mass.toString()} ${widget.measurement}
                  ))),
              Expanded(
                flex: 2,
                child: Center(
                  child: SelectableText(
                    DateFormat("dd.MM.yyyy").format(widget.date),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RawMaterialButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) => IssueReagentDialogWidget(
                                  reagentData.findReagentById(widget.id)));
                        },
                        child: Text('-',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        fillColor: Colors.grey,
                        //shape: CircleBorder(),
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RawMaterialButton(
                        onPressed: () {
                          archivesData.addToArchive(
                            ArchivesModel(
                              widget.reagentName,
                              'Usunięto odczynnik',
                              DateTime.now(),
                            ),
                          );
                          reagentData.deleteReagent(widget.id);
                        },
                        child: Text('X',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        fillColor: Colors.grey,
                      ),
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Center(
                      child: SelectableText(widget.financing.toString()))),
              Expanded(
                  flex: 2,
                  child:
                      Center(child: SelectableText(widget.price.toString()))),
              Expanded(
                  flex: 2,
                  child: Center(child: SelectableText(widget.name.toString()))),
              Expanded(
                flex: 1,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RawMaterialButton(
                      onPressed: () {},
                      child: Text(
                        '+',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      fillColor: Colors.grey,
                      //shape: CircleBorder(),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
