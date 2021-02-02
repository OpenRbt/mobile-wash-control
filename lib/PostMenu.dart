import 'package:flutter/material.dart';

class PostMenuArgs {
  final int postID;

  PostMenuArgs(this.postID);
}

class PostMenu extends StatefulWidget {
  int postID;
  PostMenu({Key key, @required this.postID}) : super(key: key);

  @override
  _PostMenuState createState() => _PostMenuState(postID);
}

class _PostMenuState extends State<PostMenu> {
  int _postID;
  _PostMenuState(this._postID) : super() {
    _postID = _postID == null ? -1 : _postID;
  }

  List<bool> _checkboxList = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      title: Text("Пост: ${this._postID}"),
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBar,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return new SizedBox(
            height: screenH - 1 * appBar.preferredSize.height,
            width: screenW,
            child: Row(
              children: [
                SizedBox(
                  height: screenH - appBar.preferredSize.height,
                  width: screenW / 2,
                  child: GridView.count(
                    padding: const EdgeInsets.all(10),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 1,
                    childAspectRatio: (screenW / 2) / 75,
                    children: [
                      RaisedButton(
                        color: Colors.lightGreen,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.lightGreenAccent,
                        onPressed: () {},
                        child: Text(
                          "пена",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      RaisedButton(
                        color: Colors.lightGreen,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.lightGreenAccent,
                        onPressed: () {},
                        child: Text(
                          "вода + шампунь",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      RaisedButton(
                        color: Colors.lightGreen,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.lightGreenAccent,
                        onPressed: () {},
                        child: Text(
                          "ополаскивание",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      RaisedButton(
                        color: Colors.lightGreen,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.lightGreenAccent,
                        onPressed: () {},
                        child: Text(
                          "воск",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      RaisedButton(
                        color: Colors.lightGreen,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.lightGreenAccent,
                        onPressed: () {},
                        child: Text(
                          "сушка и блеск",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      RaisedButton(
                        color: Colors.lightGreen,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.lightGreenAccent,
                        onPressed: () {},
                        child: Text(
                          "пауза",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  //height: screenH - appBar.preferredSize.height,
                  width: screenW / 2,
                  child: GridView.count(
                    padding: const EdgeInsets.all(10),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 1,
                    childAspectRatio: (screenW / 2) / 75,
                    children: [
                      _getCheckBox(0),
                      _getCheckBox(1),
                      _getCheckBox(2),
                      _getCheckBox(3),
                      _getCheckBox(4),
                      _getCheckBox(5),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      //floatingActionButton: _getFloatingButton(true),
    );
  }

  Widget _getCheckBox(int index) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.trailing,
      title: Text('Активный'),
      value: _checkboxList[index],
      onChanged: (newValue) {
        setState(() {
          _checkboxList[index] = !_checkboxList[index];
        });
      },
    );
  }

  Widget _getFloatingButton(bool portrait) {
    return portrait
        ? new FloatingActionButton(
            backgroundColor: Colors.lightGreen,
            splashColor: Colors.lightGreenAccent,
            tooltip: "Дополнительно",
            onPressed: () {},
            child: Icon(Icons.settings),
          )
        : null;
  }
}
