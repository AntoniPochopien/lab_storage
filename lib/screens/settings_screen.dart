import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../providers/users_provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController userInput = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<UsersProvider>(context, listen: false)
        .decodeFromUserJSON()
        .then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UsersProvider>(context);
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
                    userData.users
                        .add(User(userData.users.length, userInput.text));
                    userInput.text = '';
                  });
                  userData.encodeToUserJSON();
                },
                child: Text('Dodaj Użytkownika'),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: userData.users.length,
              itemBuilder: (context, index) => Text(userData.users[index].name),
            ),
          ),
        ],
      ),
    );
  }
}
