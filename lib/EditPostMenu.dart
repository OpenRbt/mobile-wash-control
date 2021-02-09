import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';

class PostMenuArgs {
  final int postID;
  final SessionData client;
  PostMenuArgs(this.postID, this.client);
}

class EditPostMenu extends StatefulWidget {
  EditPostMenu({Key key}) : super(key: key);

  @override
  _EditPostMenuState createState() => _EditPostMenuState();
}

class _EditPostMenuState extends State<EditPostMenu> {
  int _total = 0;


  List<bool> _checkboxList = [false, false, false, false, false, false];
  final List<String> _buttonNames = [
    "пена",
    "вода + шампунь",
    "ополаскивание",
    "воск",
    "сушка и блеск",
    "пауза"
  ];

  @override
  Widget build(BuildContext context) {
    final PostMenuArgs postMenuArgs = ModalRoute.of(context).settings.arguments;


    final AppBar appBar = AppBar(
      title: Text("Пост: ${postMenuArgs.postID}"),
    );

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    if (screenW > screenH) {
      SystemChrome.setEnabledSystemUIOverlays([]);
    } else {
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    }

    return Scaffold(
      appBar: appBar,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return new SizedBox(
              height: screenH - appBar.preferredSize.height,
              width: screenW,
              child: _getMenu(screenH > screenW, screenW));
        },
      ),
    );
  }

  Widget _getMenu(bool isPortrait, double screenW) {
    if (isPortrait) {
      return new ListView(
        children: [
          _getMainColumn(isPortrait, screenW),
          Divider(
            height: 5,
            thickness: 5,
            color: Colors.lightGreen,
          ),
          Row(
            children: [
              _getButtonsColumn(isPortrait, screenW),
              _getCheckBoxColumn(isPortrait, screenW)
            ],
          )
        ],
      );
    } else {
      return new FittedBox(
          fit: BoxFit.fill,
          child: Row(children: [
            _getMainColumn(isPortrait, screenW),
            _getButtonsColumn(isPortrait, screenW),
            _getCheckBoxColumn(isPortrait, screenW)
          ]));
    }
  }

  Widget _getMainColumn(bool isPortrait, double screenW) {
    return new Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            height: 50,
            width: isPortrait ? screenW / 2 - 20 : screenW / 3 - 20,
            child: DecoratedBox(
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Text("${'0'*(4 - _total.toString().length)+ _total.toString()}"),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(color: Colors.lightGreen),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: isPortrait ? 50 : (screenW / 3 - 20) / 6,
                child: Align(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: IconButton(
                        iconSize: 75,
                        icon: Icon(Icons.remove_circle_outline),
                        color: Colors.lightGreen,
                        splashColor: Colors.lightGreenAccent,
                        onPressed: () {
                          setState(() {
                            _total -= 10;
                            _total = _total < 0 ? 0 : _total;
                          });
                        },
                      ),
                    )),
              ),
              SizedBox(
                height: 50,
                width: isPortrait ? 150 : (screenW / 3 - 20) / 6 * 4,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "10 руб",
                    style: TextStyle(fontSize: 36),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: isPortrait ? 50 : (screenW / 3 - 20) / 6,
                child: Align(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: IconButton(
                        iconSize: 75,
                        icon: Icon(Icons.add_circle_outline),
                        color: Colors.lightGreen,
                        splashColor: Colors.lightGreenAccent,
                        onPressed: () {
                          setState(() {
                            _total += 10;
                            _total = _total > 9999 ? 9990 : _total;
                          });
                        },
                      ),
                    )),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            height: 50,
            width: isPortrait ? screenW / 2 - 20 : screenW / 3 - 20,
            child: RaisedButton(
              color: Colors.lightGreen,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.lightGreenAccent,
              child: Text(
                "Инкассировать",
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () {},
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            height: 50,
            width: isPortrait ? screenW / 2 - 20 : screenW / 3 - 20,
            child: RaisedButton(
              color: Colors.lightGreen,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.lightGreenAccent,
              child: Text(
                "Открыть дверь",
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  Widget _getButtonsColumn(bool isPortrait, double screenW) {
    return new Column(
      children: List.generate(6, (index) {
        return Padding(
            padding: EdgeInsets.all(10),
            child: SizedBox(
              height: 50,
              width: isPortrait ? screenW / 2 - 20 : screenW / 3 - 20,
              child: _getListButton(index),
            ));
      }),
    );
  }

  Widget _getCheckBoxColumn(bool isPortrait, double screenW) {
    return new Column(
      children: List.generate(6, (index) {
        return Padding(
            padding: EdgeInsets.all(10),
            child: SizedBox(
              height: 50,
              width: isPortrait ? screenW / 2 - 20 : screenW / 3 - 20,
              child: _getCheckBox(index),
            ));
      }),
    );
  }

  Widget _getCheckBox(int index) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.trailing,
      title: Text(
        'Активный',
        style: TextStyle(fontSize: 15),
      ),
      value: _checkboxList[index],
      onChanged: (newValue) {
        setState(() {
          _checkboxList[index] = !_checkboxList[index];
        });
      },
    );
  }

  Widget _getListButton(int index) {
    return new RaisedButton(
      color: Colors.lightGreen,
      textColor: Colors.white,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      splashColor: Colors.lightGreenAccent,
      onPressed: () {},
      child: Text(
        _buttonNames[index],
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}