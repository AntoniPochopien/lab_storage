import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

import '../models/reagent_model.dart';

List<ReagentModel> reagents = [
  // ReagentModel(
  //     id: 1,
  //     reagentName: 'name',
  //     mass: 8,
  //     measurement: 'KG',
  //     date: DateTime.now(),
  //     issue: () {},
  //     deleteFun: () {},
  //     financing: 'financing',
  //     price: 90,
  //     name: 'name',
  //     add: () {}),
];

//zapisuje podanego jsona do pliku w konkretnej ścieżce uzytkownika
Future<File> writeReagentData(String data) async {
  Directory docDir = await getApplicationDocumentsDirectory();
  final file = File('${docDir.path}/lab/reagent_data.txt');
  return file.writeAsString(data);
}

//pobiera dane z dysku
Future<String> getReagentData() async {
  try {
    Directory docDir = await getApplicationDocumentsDirectory();
    final file = File('${docDir.path}/lab/reagent_data.txt');
    final contents = file.readAsString();
    return contents;
  } catch (e) {
    return 'Error check if lab_data.txt file is inside docs directory';
  }
}

//dekodowanie z jsona i fetchowanie w obiekty
Future<void> decodeFromReagentJSON() async {
  String output = await getReagentData();
  Map<String, dynamic> decodeReagents = jsonDecode(output);
  List helper = decodeReagents['list'];
  helper.forEach((element) {
    reagents.add(
      ReagentModel(
        id: element['id'],
        reagentName: element['reagentName'],
        mass: element['mass'],
        measurement: element['measurement'],
        date: DateTime.now(),
        issue: () {},
        deleteFun: () {},
        financing: element['financing'],
        price: element['price'],
        name: element['name'],
        add: () {},
      ),
    );
  });
}

//kodowanie w jsona
void encodeToReagentJSON() {
  var jsonBody = {};
  List<Map> listOfMaps = [];
  reagents.forEach((element) {
    listOfMaps.add({
      'id': element.id,
      'reagentName': element.reagentName,
      'mass': element.mass,
      'measurement': element.measurement,
      'date': element.date.toString(),
      'issue': element.issue.toString(),
      'deleteFun': element.deleteFun.toString(),
      'financing': element.financing,
      'price': element.price,
      'name': element.name,
      'add': element.add.toString(),
    });
  });
  jsonBody['list'] = listOfMaps;
  String str = json.encode(jsonBody);
  writeReagentData(str);
}

void addReagent(
  bool isSelected,
  int id,
  String reagentName, //nazwa odczynnika
  double mass, //gramatura
  String
      measurement, //oznaczenie miary do gramatury ^ Litry gramy kilogramy itp
  DateTime date,
  Function issue, //wydanie
  Function deleteFun,
  String financing,
  double price,
  String name, //imie kogos?
  Function add,
) {
  print('zapisano');
}
