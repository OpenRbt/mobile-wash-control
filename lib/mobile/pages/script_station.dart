import 'package:flutter/material.dart';

import '../../entity/vo/page_args_codes.dart';
import '../../repository/repository.dart';

class ScriptStationPage extends StatefulWidget {
  const ScriptStationPage({Key? key}) : super(key: key);

  @override
  State<ScriptStationPage> createState() => _ScriptStationPageState();
}

class _ScriptStationPageState extends State<ScriptStationPage> {

  late TextEditingController scriptController;

  Future<void> _getCurrentScript(Repository repository, int id) async {
    scriptController.text = "cd ../ \ncd ../../";
  }

  @override
  void initState() {
    scriptController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    scriptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final int id = args[PageArgCode.stationID];
    final repository = args[PageArgCode.repository] as Repository;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Пост $id",
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save_outlined, color: Colors.white),
            iconSize:  30.0,
            splashRadius: 30,
            onPressed: () {

            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: _getCurrentScript(repository, id),
        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (snapshot.hasError) {
            return Container();
          }

          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: TextFormField(
                controller: scriptController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
