import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../models/archives_model.dart';

class ArchivesProvider extends ChangeNotifier {
  List<ArchivesModel> archives = [];

  void addToArchive(ArchivesModel item) {
    archives.add(item);
    notifyListeners();
    encodeToArchivesJSON();
  }

  //kodowanie w jsona
  void encodeToArchivesJSON() {
    var jsonBody = {};
    List<Map> listOfMaps = [];
    archives.forEach((element) {
      listOfMaps.add({
        'name': element.name,
        'action': element.action,
        'date': element.date.toString(),
      });
    });
    jsonBody['list'] = listOfMaps;
    String str = json.encode(jsonBody);
    writeArchivesData(str);
  }

  //zapisuje podanego jsona do pliku w konkretnej ścieżce uzytkownika
  Future<File> writeArchivesData(String data) async {
    Directory docDir = await getApplicationDocumentsDirectory();
    final file = File('${docDir.path}/lab/archives_data.txt');
    return file.writeAsString(data);
  }

  //pobiera dane z dysku
  Future<String> getArchivesData() async {
    try {
      Directory docDir = await getApplicationDocumentsDirectory();
      final file = File('${docDir.path}/lab/archives_data.txt');
      final contents = file.readAsString();
      return contents;
    } catch (e) {
      return 'Error check if lab_data.txt file is inside docs directory';
    }
  }

  //dekodowanie z jsona i fetchowanie w obiekty
  Future<void> decodeFromArchivesJSON() async {
    try {
      String output = await getArchivesData();
      Map<String, dynamic> decodeArchives = jsonDecode(output);
      List helper = decodeArchives['list'];
      helper.forEach((element) {
        archives.add(ArchivesModel(
          element['name'],
          element['action'],
          DateTime.parse(element['date']),
        ));
      });
      notifyListeners();
    } catch (e) {
      print('blad');
      return;
    }
  }
}
