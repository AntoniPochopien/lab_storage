import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/reagent_provider.dart';

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
  @override
  Widget build(BuildContext context) {
    final reagentData = Provider.of<ReagentProvider>(context);
    return Container(
      child: Card(
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 2,
                  color: widget.isSelected ? Colors.green : Colors.white)),
          child: Row(
            children: [
              Expanded(
                  flex: 2, child: Center(child: Text(widget.id.toString()))),
              Expanded(flex: 2, child: Center(child: Text(widget.reagentName))),
              Expanded(
                  flex: 2,
                  child: Center(
                      child: Text(
                    '${widget.mass.toString()} ${widget.measurement}',
                  ))),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
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
                        onPressed: () {},
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
                  child: Center(child: Text(widget.financing.toString()))),
              Expanded(
                  flex: 2, child: Center(child: Text(widget.price.toString()))),
              Expanded(
                  flex: 2, child: Center(child: Text(widget.name.toString()))),
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
