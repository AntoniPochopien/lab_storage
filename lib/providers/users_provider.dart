import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

import '../models/user_model.dart';

class UsersProvider extends ChangeNotifier {
  List<User> users = [];

  Future<File> writeUserData(String data) async {
    Directory docDir = await getApplicationDocumentsDirectory();
    final file = File('${docDir.path}/lab/user_data.txt');
    return file.writeAsString(data);
  }

  Future<String> getUserData() async {
    try {
      Directory docDir = await getApplicationDocumentsDirectory();
      final file = File('${docDir.path}/lab/user_data.txt');
      final contents = file.readAsString();
      return contents;
    } catch (e) {
      return 'Error check if user_data.txt file is inside docs /lab directory';
    }
  }

  Future<void> decodeFromUserJSON() async {
    String output = await getUserData();
    Map<String, dynamic> decodeUsers = jsonDecode(output);
    List helper = decodeUsers['list'];
    helper.forEach((element) {
      users.add(User(element['id'], element['name']));
    });
  }

  void encodeToUserJSON() {
    var jsonBody = {};
    List<Map> listOfMaps = [];
    users.forEach((element) {
      listOfMaps.add({'id': element.id, 'name': element.name});
    });
    jsonBody['list'] = listOfMaps;
    String str = json.encode(jsonBody);
    writeUserData(str);
  }

  int findUserIdByName(String name) {
    final findedId = users.indexWhere((element) {
      if (element.name == name) {
        return true;
      } else {
        return false;
      }
    });
    return findedId;
  }
}
