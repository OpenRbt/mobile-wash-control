import 'package:flutter/material.dart';
import 'package:mobile_wash_control/mobile/CommonElements.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/client/api.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class AuthArgs {
  final String Host;

  AuthArgs(this.Host);
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  _AuthPageState() : super();
  final int _maxPinLength = 4;
  String _host;
  var _sessionData;
  String _currentPin = "";

  void _loadPage() {
    SystemChrome.setPreferredOrientations([]);
    Navigator.pushReplacementNamed(context, "/mobile/home", arguments: _sessionData);
  }

  void _authCheck() async {
    try {
      _sessionData = new SessionData(
        DefaultApi(),
      );
      _sessionData.client.apiClient.basePath = _host;
      _sessionData.client.apiClient.addDefaultHeader("Pin", _currentPin);
      var res = await _sessionData.client.getUser();
      _loadPage();
    } on ApiException catch (e) {
      if (e.code == 401) {
        showInfoSnackBar(
            _scaffoldKey, _isSnackBarActive, "Неверные данные", Colors.red);
      }
    } catch (e) {
      if (!(e is ApiException)) {
        showInfoSnackBar(_scaffoldKey, _isSnackBarActive,
            "Невозможно авторизоваться", Colors.red);
      }
      print("Exception when calling DefaultApi->/user: $e\n");
    }
  }

  //TODO: Add horizontal layout
  @override
  Widget build(BuildContext context) {
    final AuthArgs authArgs = ModalRoute.of(context).settings.arguments;
    _host = authArgs.Host;
    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: OrientationBuilder(
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
                          child: Text(
                            _toDisplay(),
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
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
                        _keyPadKey(
                          'Ок',
                          screenW,
                          screenH,
                        ) // russian
                      ],
                    )
                  ]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _keyPadKey(
    String text,
    double screenW,
    double screenH,
  ) {
    return Container(
      width: screenW / 4,
      height: 80,
      padding: EdgeInsets.all(2),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.black, width: 2.0, style: BorderStyle.solid),
        ),
        color: Colors.white,
        elevation: 4,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            text,
            style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
          ),
        ),
        onPressed: () {
          switch (text) {
            case 'Ок':
              _authCheck();
              // _authCheck(sessionData);
              break;
            case 'с':
              setState(() {
                _deleteSymbol();
                // _deleteSymbol();
              });
              break;
            default:
              setState(() {
                _addSymbol(text);
                // _addSymbol(text);
              });
              break;
          }
        },
      ),
    );
  }

  void _deleteSymbol() {
    if (_currentPin.length > 1) {
      _currentPin = _currentPin.substring(0, _currentPin.length - 1);
    } else {
      _currentPin = "";
    }
  }

  void _addSymbol(String symbol) {
    if (_currentPin.length < _maxPinLength) {
      _currentPin += symbol;
    }
  }

  String _toDisplay() {
    var res = "";
    if (_currentPin.length > 0) {
      return _currentPin
          .substring(_currentPin.length - 1)
          .padLeft(_currentPin.length, "*");
    }
    return res;
  }
}
