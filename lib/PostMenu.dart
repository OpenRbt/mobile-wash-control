import 'package:flutter/material.dart';

class PostMenuArgs {
  final int postID;

  PostMenuArgs(this.postID);
}

class PostMenu extends StatelessWidget {
  int postID;

  PostMenu({Key key, @required this.postID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostMenuArgs args = ModalRoute.of(context).settings.arguments;
    this.postID = args.postID;
    final AppBar appBar = AppBar(
      title: Text("Пост: $postID"),
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
                      RaisedButton(
                        color: Colors.lightGreen,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.lightGreenAccent,
                        onPressed: () {},
                        child: Text(
                          "Активный",
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
                          "Активный",
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
                          "Активный",
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
                          "Активный",
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
                          "Активный",
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
                          "Активный",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: _getFloatingButton(true),
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
