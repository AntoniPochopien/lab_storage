import 'package:flutter/material.dart';
import 'package:lab_storage/models/user_model.dart';

import '../local_storage/users_files_logic.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController userInput = TextEditingController();

  @override
  void initState() {
    super.initState();
    decodeFromUserJSON().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: userInput,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    users.add(User(users.length, userInput.text));
                    userInput.text = '';
                  });
                  encodeToUserJSON();
                },
                child: Text('Dodaj Użytkownika'),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) => Text(users[index].name),
            ),
          ),
        ],
      ),
    );
  }
}
