import 'package:flutter/material.dart';

import '../local_storage/reagent_files_logic.dart';
import '../widgets/reagent_widget.dart';
import '../widgets/sort_bar_widget.dart';
import '../widgets/add_reagent_dialog_widget.dart';
import '../local_storage/users_files_logic.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

int selectedIndex = -1;
bool isLoading = true;

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();

    decodeFromReagentJSON().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                            builder: (_) => addReagentDialog());
                      },
                      child: Text(
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
                        setState(() {});
                      },
                      child: Text(
                        '-',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 14,
                  child: SizedBox(),
                ),
              ],
            ),
            SortBarWidget(),
            isLoading
                ? Expanded(child: Center(child: CircularProgressIndicator()))
                : Expanded(
                    child: Container(
                      child: ListView.builder(
                          itemCount: reagents.length,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: ReagentWidget(
                                    isSelected: selectedIndex == index,
                                    id: reagents[index].id,
                                    reagentName: reagents[index].reagentName,
                                    mass: reagents[index].mass,
                                    measurement: reagents[index].measurement,
                                    date: reagents[index].date,
                                    issue: reagents[index].issue,
                                    deleteFun: reagents[index].deleteFun,
                                    financing: reagents[index].financing,
                                    price: reagents[index].price,
                                    name: reagents[index].name,
                                    add: reagents[index].add),
                              )),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
