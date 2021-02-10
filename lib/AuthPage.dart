import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:flutter/services.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  _AuthPageState() : super();

  var _currentDisplayPos = 0;
  List<String> _displayedSymbols = <String>['x', 'x', 'x', 'x'];

  void _authCheck(SessionData sessionData) {
    if (_displayedSymbols.toString() == "[0, 0, 0, 0]") {
      SystemChrome.setPreferredOrientations([]);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final SessionData sessionData = ModalRoute.of(context).settings.arguments;
    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return WillPopScope(onWillPop: () async {
      SystemNavigator.pop();
      return false;
    }, child: Scaffold(body: SafeArea(child: OrientationBuilder(
      builder: (context, orientation) {
        return new Container(
            width: screenW,
            height: screenH,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(children: [
                  Container(
                    height: 62,
                    width: screenW / 4 * 3,
                    child: DecoratedBox(
                      child: Center(
                          child: Text(_toDisplay(_displayedSymbols),
                              style: TextStyle(fontSize: 40))),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _keyPadKey('1', screenW, screenH),
                      _keyPadKey('2', screenW, screenH),
                      _keyPadKey('3', screenW, screenH)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _keyPadKey('4', screenW, screenH),
                      _keyPadKey('5', screenW, screenH),
                      _keyPadKey('6', screenW, screenH)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _keyPadKey('7', screenW, screenH),
                      _keyPadKey('8', screenW, screenH),
                      _keyPadKey('9', screenW, screenH)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _keyPadKey('с', screenW, screenH), // russian
                      _keyPadKey('0', screenW, screenH),
                      _keyPadKey('Ок', screenW, screenH,
                          sessionData: sessionData) // russian
                    ],
                  )
                ])));
      },
    ))));
  }

  Widget _keyPadKey(String text, double screenW, double screenH,
      {SessionData sessionData}) {
    return Container(
        width: screenW / 4,
        height: 80,
        padding: EdgeInsets.all(2),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: Colors.black, width: 2.0, style: BorderStyle.solid)),
          color: Colors.white,
          elevation: 4,
          child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(text,
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold))),
          onPressed: () {
            switch (text) {
              case 'Ок':
                _authCheck(sessionData);
                break;
              case 'с':
                setState(() {
                  _deleteSymbol();
                });
                break;
              default:
                setState(() {
                  _addSymbol(text);
                });
                break;
            }
          },
        ));
  }

  void _deleteSymbol() {
    if (_currentDisplayPos == 4)
      _displayedSymbols[3] = 'x';
    else
      _displayedSymbols[_currentDisplayPos] = 'x';
    _currentDisplayPos--;
    if (_currentDisplayPos < 0) _currentDisplayPos = 0;
  }

  void _addSymbol(String text) {
    if (_currentDisplayPos == 4)
      _displayedSymbols[3] = text;
    else
      _displayedSymbols[_currentDisplayPos] = text;
    _currentDisplayPos++;
    if (_currentDisplayPos > 4) _currentDisplayPos = 4;
  }

  String _toDisplay(List<String> values) {
    int lastNumberIndex = _currentDisplayPos - 1;
    var res = '';
    for (int i = 0; i <= lastNumberIndex; i++)
      res += i == lastNumberIndex ? values[lastNumberIndex].toString() : '*';
    for (int i = lastNumberIndex + 1; i < 4; i++) res += ' ';
    return res;
  }
}
