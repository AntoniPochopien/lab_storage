import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/reagent_provider.dart';

class SortBarWidget extends StatefulWidget {
  const SortBarWidget({super.key});

  @override
  State<SortBarWidget> createState() => _SortBarWidgetState();
}

class _SortBarWidgetState extends State<SortBarWidget> {
  @override
  Widget build(BuildContext context) {
    final reagentData = Provider.of<ReagentProvider>(context);
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextButton(
            onPressed: () => reagentData.sortItems(0),
            child: Text(
              'Lp',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: TextButton(
            onPressed: () => reagentData.sortItems(1),
            child: Text(
              'Nazwa',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: TextButton(
            onPressed: () => reagentData.sortItems(2),
            child: Text(
              'Gramatura',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: TextButton(
            onPressed: () => reagentData.sortItems(3),
            child: Text(
              'Data',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              'Wydaj',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              'Usuń',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: TextButton(
            onPressed: () => reagentData.sortItems(4),
            child: Text(
              'Finansowanie',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: TextButton(
            onPressed: () => reagentData.sortItems(5),
            child: Text(
              'Cena',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: TextButton(
            onPressed: () => reagentData.sortItems(6),
            child: Text(
              'Imie i Nazwisko',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              'dodaj',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
