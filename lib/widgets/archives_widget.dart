import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/archives_model.dart';

class ArchivesWidget extends StatelessWidget {
  ArchivesModel item;

  ArchivesWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
              child: Text(
            item.name,
            textAlign: TextAlign.center,
          )),
          Expanded(child: Text(item.action, textAlign: TextAlign.center)),
          Expanded(
              child: Text(DateFormat("dd.MM.yyyy").format(item.date),
                  textAlign: TextAlign.center)),
        ]),
      ),
    );
  }
}
