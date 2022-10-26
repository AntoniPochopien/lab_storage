import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

import '../models/reagent_model.dart';
import '../models/measurement_model.dart';

class ReagentProvider extends ChangeNotifier {
  List<ReagentModel> reagents = [];

  List<Measurement> measurement = [
    Measurement(0, 'Mg'),
    Measurement(1, 'g'),
    Measurement(2, 'kg'),
    Measurement(3, 'ml'),
    Measurement(4, 'l'),
  ];

//dodaje reagent do listy
  void addNewReagent(ReagentModel data) {
    reagents.add(
      ReagentModel(
        id: reagents.length,
        reagentName: data.reagentName,
        mass: data.mass,
        measurement: data.measurement,
        date: data.date,
        financing: data.financing,
        price: data.price,
        name: data.name,
      ),
    );
    encodeToReagentJSON();
    notifyListeners();
  }

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
    try {
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
            date: DateTime.parse(element['date']),
            financing: element['financing'],
            price: element['price'],
            name: element['name'],
          ),
        );
      });
      notifyListeners();
    } catch (e) {
      return;
    }
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
        'financing': element.financing,
        'price': element.price,
        'name': element.name,
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

  //w przypadku usuwania odczynnika, poprawia id tak aby były w koleiności inkrementującej o 1
  void fixId() {
    int _index = 0;
    reagents.forEach((element) {
      element.id = _index;
      _index += 1;
    });
  }

  //usuwa odczynnik z listy, wywołuje też nadpis pliku na dysku (stale usuniecie odczynnika)
  void deleteReagent(int itemId) {
    var result = reagents.indexWhere((element) {
      return element.id == itemId;
    });
    reagents.removeAt(result);
    fixId();
    encodeToReagentJSON();
    notifyListeners();
  }

  void sortItems(int i) {
    switch (i) {
      case 0:
        {
          reagents.sort((a, b) => a.id.compareTo(b.id));
        }
        break;
      case 1:
        {
          reagents.sort((a, b) => a.reagentName.compareTo(b.reagentName));
        }
        break;
      case 2:
        {
          reagents.sort((a, b) => a.mass.compareTo(b.mass));
        }
        break;
      case 3:
        {
          reagents.sort((a, b) => a.date.compareTo(b.date));
        }
        break;
      case 4:
        {
          reagents.sort((a, b) => a.financing.compareTo(b.financing));
        }
        break;
      case 5:
        {
          reagents.sort((a, b) => a.price.compareTo(b.price));
        }
        break;
      case 6:
        {
          reagents.sort((a, b) => a.name.compareTo(b.name));
        }
        break;
    }
    notifyListeners();
  }
}
