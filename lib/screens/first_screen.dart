import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/issue_reagent_dialog_widget.dart';
import '../widgets/reagent_widget.dart';
import '../widgets/sort_bar_reagents_widget.dart';
import '../widgets/add_reagent_dialog_widget.dart';
import '../providers/reagent_provider.dart';

class FirstScreen extends StatefulWidget {
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

int selectedIndex = -1;
bool isLoading = true;

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ReagentProvider>(context, listen: false)
        .decodeFromReagentJSON()
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final reagentData = Provider.of<ReagentProvider>(context);
    return GestureDetector(
      onTap: () => setState(() {
        selectedIndex = -1;
      }),
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Text(
              'STAN MAGAZYNU',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.grey[800]),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RawMaterialButton(
                      elevation: 5,
                      fillColor: Colors.grey,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => addReagentDialog(false, null));
                      },
                      child: const Text(
                        '+',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RawMaterialButton(
                      elevation: 5,
                      fillColor: Colors.grey,
                      onPressed: () {
                        if (selectedIndex != -1) {
                          showDialog(
                              context: context,
                              builder: (_) => IssueReagentDialogWidget(
                                  reagentData.findReagentById(
                                      reagentData.reagents[selectedIndex].id)));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text('Musisz najpierw wybrac odczynnik'),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        '-',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 14,
                  child: SizedBox(),
                ),
              ],
            ),
            SortBarWidget(),
            isLoading
                ? const Expanded(
                    child: Center(child: CircularProgressIndicator()))
                : reagentData.reagents.isEmpty
                    ? Expanded(
                        child: Center(
                            child: Text(
                        'Brak odczynnik??w',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.grey[800]),
                      )))
                    : Expanded(
                        child: Container(
                          child: ListView.builder(
                              itemCount: reagentData.reagents.length,
                              itemBuilder: (context, index) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                      showDialog(
                                          context: context,
                                          builder: (_) => addReagentDialog(true,
                                              reagentData.reagents[index].id));
                                    },
                                    child: ReagentWidget(
                                      isSelected: selectedIndex == index,
                                      id: reagentData.reagents[index].id,
                                      reagentName: reagentData
                                          .reagents[index].reagentName,
                                      mass: reagentData.reagents[index].mass,
                                      measurement: reagentData
                                          .reagents[index].measurement,
                                      date: reagentData.reagents[index].date,
                                      financing:
                                          reagentData.reagents[index].financing,
                                      price: reagentData.reagents[index].price,
                                      name: reagentData.reagents[index].name,
                                    ),
                                  )),
                        ),
                      )
          ],
        ),
      ),
    );
  }
}
