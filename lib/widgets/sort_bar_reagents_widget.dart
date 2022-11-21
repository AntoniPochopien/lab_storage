import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/reagent_provider.dart';

class SortBarWidget extends StatefulWidget {
  const SortBarWidget({super.key});

  @override
  State<SortBarWidget> createState() => _SortBarWidgetState();
}

class _SortBarWidgetState extends State<SortBarWidget> {
  List<bool> reversed = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  List<int> clicked = [
    1,
    0,
    0,
    0,
    0,
    0,
    0,
  ];

  int lastClickedButton = 0;

  void makeReversed(int i) {
    if (lastClickedButton != i) {
      lastClickedButton = i;
      reversed = [
        false,
        false,
        false,
        false,
        false,
        false,
        false,
      ];
      clicked = [
        0,
        0,
        0,
        0,
        0,
        0,
        0,
      ];
    }
    clicked[i] += 1;

    if (clicked[i] == 2) {
      setState(() {
        reversed[i] = true;
      });
    }
    if (clicked[i] > 2) {
      setState(() {
        reversed[i] = false;
        clicked[i] = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final reagentData = Provider.of<ReagentProvider>(context);
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextButton(
            onPressed: () {
              makeReversed(0);
              reagentData.sortItems(0, reversed[0]);
            },
            child: reversed[0]
                ? Icon(Icons.arrow_upward)
                : Text(
                    'Lp',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: clicked[0] == 0 ? Colors.black : Colors.blue),
                  ),
          ),
        ),
        Expanded(
          flex: 2,
          child: TextButton(
            onPressed: () {
              makeReversed(1);
              reagentData.sortItems(1, reversed[1]);
            },
            child: reversed[1]
                ? Icon(Icons.arrow_upward)
                : Text(
                    'Nazwa',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: clicked[1] == 0 ? Colors.black : Colors.blue),
                  ),
          ),
        ),
        Expanded(
          flex: 2,
          child: TextButton(
            onPressed: () {
              makeReversed(2);
              reagentData.sortItems(2, reversed[2]);
            },
            child: reversed[2]
                ? Icon(Icons.arrow_upward)
                : Text(
                    'Gramatura',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: clicked[2] == 0 ? Colors.black : Colors.blue),
                  ),
          ),
        ),
        Expanded(
          flex: 2,
          child: TextButton(
            onPressed: () {
              makeReversed(3);
              reagentData.sortItems(3, reversed[3]);
            },
            child: reversed[3]
                ? Icon(Icons.arrow_upward)
                : Text(
                    'Data',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: clicked[3] == 0 ? Colors.black : Colors.blue),
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
            onPressed: () {
              makeReversed(4);
              reagentData.sortItems(4, reversed[4]);
            },
            child: reversed[4]
                ? Icon(Icons.arrow_upward)
                : Text(
                    'Finansowanie',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: clicked[4] == 0 ? Colors.black : Colors.blue),
                  ),
          ),
        ),
        Expanded(
          flex: 2,
          child: TextButton(
            onPressed: () {
              makeReversed(5);
              reagentData.sortItems(5, reversed[5]);
            },
            child: reversed[5]
                ? Icon(Icons.arrow_upward)
                : Text(
                    'Cena',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: clicked[5] == 0 ? Colors.black : Colors.blue),
                  ),
          ),
        ),
        Expanded(
          flex: 2,
          child: TextButton(
            onPressed: () {
              makeReversed(6);
              reagentData.sortItems(6, reversed[6]);
            },
            child: reversed[6]
                ? Icon(Icons.arrow_upward)
                : Text(
                    'Imie i Nazwisko',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: clicked[6] == 0 ? Colors.black : Colors.blue),
                  ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              'Dodaj',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
