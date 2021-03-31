import 'package:flutter/material.dart';

class ServersPage extends StatelessWidget {
  final List<String> servers;
  List<bool> serversValid;

  ServersPage({Key key, @required this.servers, @required this.serversValid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Список доступных серверов"),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: List.generate(servers.length ?? 0, (serverID) {
          return SizedBox(
            height: 50,
            width: 50,
            child: RaisedButton(
              color: serversValid[serverID] ? Colors.lightGreen : Colors.red,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.lightGreenAccent,
              onPressed: () {
                print("Touched  host ${servers[serverID]}");
              },
              child: Text(
                "Server: ${servers[serverID]}",
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        }),
      ),
    );
  }
}