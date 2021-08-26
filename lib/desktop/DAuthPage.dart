import 'package:flutter/material.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/client/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DAuthPage extends StatefulWidget {
  @override
  _DAuthPageState createState() => _DAuthPageState();
}

class DAuthArgs {
  final String Host;

  DAuthArgs(this.Host);
}

class _DAuthPageState extends State<DAuthPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isSnackBarActive = ValueWrapper(false);

  TextEditingController pinController;

  void initState() {
    super.initState();
    pinController = new TextEditingController();
  }

  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  _DAuthPageState() : super();
  final int _maxPinLength = 4;
  String _host;
  var _sessionData;

  void _loadPage() async {
    final prefs = await SharedPreferences.getInstance();
    final int addServiceValue = prefs.getInt("AddServiceValue") ?? 0;
    GlobalData.AddServiceValue = addServiceValue;
    Navigator.pushReplacementNamed(context, "/desktop/home", arguments: _sessionData);
  }

  void _authCheck() async {
    try {
      _sessionData = new SessionData(
        DefaultApi(ApiClient(basePath: _host)),
      );
      _sessionData.client.apiClient.addDefaultHeader("Pin", pinController.text);
      var res = await _sessionData.client.getUser();
      _loadPage();
    } on ApiException catch (e) {
      if (e.code == 401) {
        showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Неверные данные", Colors.red);
      }
    } catch (e) {
      if (!(e is ApiException)) {
        showInfoSnackBar(_scaffoldKey, _isSnackBarActive, "Невозможно авторизоваться", Colors.red);
      }
      print("Exception when calling DefaultApi->/user: $e\n");
    }
  }

  @override
  Widget build(BuildContext context) {
    final DAuthArgs authArgs = ModalRoute.of(context).settings.arguments;
    _host = authArgs.Host;
    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return Center(
              child: SizedBox(
                height: 400,
                width: 400,
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 400,
                      child: Center(
                        child: Text(
                          "Authorization",
                          style: TextStyle(
                            fontSize: 32,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 400,
                      child: TextField(
                        controller: pinController,
                        obscureText: true,
                        maxLength: 16,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 400,
                      child: RaisedButton(
                        color: Colors.lightGreen,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        splashColor: Colors.lightGreenAccent,
                        onPressed: _authCheck,
                        child: Text(
                          "ENTER",
                          style: TextStyle(
                            fontSize: 32,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
