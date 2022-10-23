import 'package:flutter/material.dart';
import 'package:lab_storage/providers/reagent_provider.dart';
import 'package:lab_storage/providers/users_provider.dart';
import 'package:provider/provider.dart';

import './screens/tabs_screen.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ReagentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UsersProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TabsScreen(),
      ),
    );
  }
}
