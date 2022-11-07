import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/archives_provider.dart';
import '../widgets/archives_widget.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

bool isLoading = true;

class _SecondScreenState extends State<SecondScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ArchivesProvider>(context, listen: false)
        .decodeFromArchivesJSON()
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ArchivesProvider>(context);
    return Container(
      width: double.infinity,
      child: Column(children: [
        Text(
          'ARCHIWUM',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.grey[800]),
        ),
        Container(
          color: Colors.blue,
          width: double.infinity,
          child: Text('sort bar'),
        ),
        data.archives.length == 0
            ? Expanded(
                child: Center(
                child: Text(
                  'Archiwum jest puste',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.grey[800]),
                ),
              ))
            : Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: ListView.builder(
                      itemCount: data.archives.length,
                      itemBuilder: (context, index) =>
                          ArchivesWidget(data.archives[index])),
                ),
              )
      ]),
    );
  }
}
