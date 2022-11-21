import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/archives_provider.dart';

class SortBarArchivesWidget extends StatefulWidget {
  const SortBarArchivesWidget({super.key});

  @override
  State<SortBarArchivesWidget> createState() => _SortBarArchivesWidgetState();
}

class _SortBarArchivesWidgetState extends State<SortBarArchivesWidget> {
  List<bool> reversed = [
    false,
    false,
    true,
  ];
  List<int> clicked = [
    0,
    0,
    2,
  ];

  int lastClickedButton = 2;

  void makeReversed(int i) {
    if (lastClickedButton != i) {
      lastClickedButton = i;
      reversed = [
        false,
        false,
        false,
      ];
      clicked = [
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
    final archivesData = Provider.of<ArchivesProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {
                makeReversed(0);
                archivesData.sortItems(0, reversed[0]);
              },
              child: reversed[0]
                  ? Icon(Icons.arrow_upward)
                  : Text(
                      'Nazwa odczynnika',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: clicked[0] == 0 ? Colors.black : Colors.blue),
                    ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {
                makeReversed(1);
                archivesData.sortItems(1, reversed[1]);
              },
              child: reversed[1]
                  ? Icon(Icons.arrow_upward)
                  : Text(
                      'Wykonana Akcja',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: clicked[1] == 0 ? Colors.black : Colors.blue),
                    ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {
                makeReversed(2);
                archivesData.sortItems(2, reversed[2]);
              },
              child: reversed[2]
                  ? Icon(Icons.arrow_upward)
                  : Text(
                      'Data',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: clicked[2] == 0 ? Colors.black : Colors.blue),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
