import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/entity/entity.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/common/ProgressButton.dart';
import 'package:mobile_wash_control/mobile/widgets/common/ProgressTextButton.dart';
import 'package:mobile_wash_control/repository/repository.dart';

enum UserRole { operator, engineer, admin }

class UserEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _changePinKey = GlobalKey<FormState>();
  ValueNotifier<User?> _currentUser = ValueNotifier(null);

  late UserRole? _selectedRole;
  User? _user;
  Map<String, TextEditingController> _controllers = Map();

  @override
  void initState() {
    _controllers["login"] = TextEditingController();
    _controllers["firstname"] = TextEditingController();
    _controllers["lastname"] = TextEditingController();
    _controllers["middlename"] = TextEditingController();
    _controllers["oldpin"] = TextEditingController();
    _controllers["pin"] = TextEditingController();
    _controllers["pinRepeat"] = TextEditingController();
    super.initState();
  }

  void initControllersValues() {
    _controllers["login"]!.text = _currentUser.value?.login ?? "";
    _controllers["firstname"]!.text = _currentUser.value?.firstName ?? "";
    _controllers["lastname"]!.text = _currentUser.value?.lastName ?? "";
    _controllers["middlename"]!.text = _currentUser.value?.middleName ?? "";
    _controllers["oldpin"]!.text = "";
    _controllers["pin"]!.text = "";
    _controllers["pinRepeat"]!.text = "";
  }

  @override
  void dispose() {
    _controllers.values.forEach((element) {
      element.dispose();
    });
    _currentUser.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final Repository repository = args[PageArgCode.repository];
    User? argUser = args[PageArgCode.user];

    if (_currentUser.value == null) {
      var user = argUser ?? User(login: '');
      _currentUser.value = user;
      _user = user;
      initControllersValues();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(argUser != null ? "Редактирование пользователя" : "Создание пользователя"),
        actions: [
          FutureBuilder(
            future: repository.getCurrentUser(context: context),
            builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
              if (argUser == null || snapshot.connectionState != ConnectionState.done) {
                return Container();
              }

              if (argUser.login != snapshot.data?.login) {
                return IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Удалить пользователя - ${argUser.login} ?"),
                            actions: [
                              ProgressTextButton(
                                onPressed: () async {
                                  await repository.deleteUser(argUser.login, context: context);
                                  Navigator.pop(context);
                                  Navigator.of(context).pop();
                                },
                                child: Text("Да"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Нет"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.delete_forever_outlined));
              }
              return Container();
            },
          )
        ],
      ),
      body: ListView(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Text(
                            "Логин:",
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: TextFormField(
                            enabled: argUser == null,
                            controller: _controllers["login"]!,
                            validator: (value) {
                              var trimmedValue = value!.trim();
                              return trimmedValue.length < 4 ? "Логин должен быть не менее 4х символов" : null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z0-9_]"),
                              )
                            ],
                            decoration: InputDecoration(label: Text("Допускается латиница, цифры, _")),
                            onChanged: (value) {
                              _currentUser.value = _currentUser.value!.copyWith(login: value);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    argUser != null ? Container():
                    Row(
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Text(
                                  "Пин:",
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: TextFormField(
                                  controller: _controllers["pin"]!,
                                  obscureText: true,
                                  maxLength: 16,
                                  validator: (String? value) {
                                    return value!.length < 4 ? "Требуется не менее 4х символов" : null;
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    FilteringTextInputFormatter.singleLineFormatter,
                                  ],
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                    argUser != null ? Container():
                    Row(
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Text(
                                  "Повторите пин:",
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: TextFormField(
                                  controller: _controllers["pinRepeat"]!,
                                  obscureText: true,
                                  maxLength: 16,
                                  validator: (String? value) {
                                    if (value != _controllers["pin"]!.text) {
                                      return "Пины не совпадают";
                                    }

                                    return value!.length < 4 ? "Требуется не менее 4х символов" : null;
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    FilteringTextInputFormatter.singleLineFormatter,
                                  ],
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Text(
                            "Фамилия:",
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: TextFormField(
                            controller: _controllers["lastname"]!,
                            onChanged: (value) {
                              _currentUser.value = _currentUser.value!.copyWith(lastName: value);
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Text(
                            "Имя:",
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: TextFormField(
                            controller: _controllers["firstname"]!,
                            onChanged: (value) {
                              _currentUser.value = _currentUser.value!.copyWith(firstName: value);
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Text(
                            "Отчество:",
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: TextFormField(
                            controller: _controllers["middlename"]!,
                            onChanged: (value) {
                              _currentUser.value = _currentUser.value!.copyWith(middleName: value);
                            },
                          ),
                        ),
                      ],
                    ),
                    argUser == null ? Container():
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: ElevatedButton(
                        child: Text("Сменить пин"),
                        onPressed: () {
                          _controllers["oldpin"]!.text = "";
                          _controllers["pin"]!.text = "";
                          _controllers["pinRepeat"]!.text = "";
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Сменить пин"),
                              content: SingleChildScrollView(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(maxHeight: 230), // Укажите максимальную высоту, которую вы хотите
                                  child: Form(
                                    key: _changePinKey,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: Text(
                                                "Старый пин:",
                                                style: theme.textTheme.bodyLarge,
                                              ),
                                            ),
                                            Flexible(
                                              flex: 2,
                                              fit: FlexFit.tight,
                                              child: TextFormField(
                                                controller: _controllers["oldpin"]!,
                                                maxLength: 16,
                                                obscureText: true,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.digitsOnly,
                                                  FilteringTextInputFormatter.singleLineFormatter,
                                                ],
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: Text(
                                                "Новый пин:",
                                                style: theme.textTheme.bodyLarge,
                                              ),
                                            ),
                                            Flexible(
                                              flex: 2,
                                              fit: FlexFit.tight,
                                              child: TextFormField(
                                                controller: _controllers["pin"]!,
                                                obscureText: true,
                                                maxLength: 16,
                                                validator: (String? value) {
                                                  return value!.length < 4 ? "Требуется не менее 4х символов" : null;
                                                },
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.digitsOnly,
                                                  FilteringTextInputFormatter.singleLineFormatter,
                                                ],
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: Text(
                                                "Повторите новый пин:",
                                                style: theme.textTheme.bodyLarge,
                                              ),
                                            ),
                                            Flexible(
                                              flex: 2,
                                              fit: FlexFit.tight,
                                              child: TextFormField(
                                                controller: _controllers["pinRepeat"]!,
                                                obscureText: true,
                                                maxLength: 16,
                                                validator: (String? value) {
                                                  if (value != _controllers["pin"]!.text) {
                                                    return "Введенные пины не совпадают";
                                                  }
                                                  return value!.length < 4 ? "Требуется не менее 4х символов" : null;
                                                },
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.digitsOnly,
                                                  FilteringTextInputFormatter.singleLineFormatter,
                                                ],
                                                keyboardType: TextInputType.number,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              actionsPadding: EdgeInsets.all(8),
                              actions: [
                                ProgressButton(
                                  onPressed: () async {
                                    if (_changePinKey.currentState!.validate()) {
                                      await repository.updateUserPassword(_currentUser.value!, repository.currentUser()!, _controllers["oldpin"]!.text, _controllers["pin"]!.text, context: context);
                                      Navigator.pop(context);
                                      //setState(() {});
                                    }
                                  },
                                  child: Text("Подтвердить"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Отмена"),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: _currentUser,
                      builder: (BuildContext context, User? u, Widget? child) {
                        return repository.currentUser()?.login == u?.login ? Container():
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Оператор: ",
                                  style: theme.textTheme.bodyLarge,
                                ),
                                Checkbox(
                                  value: ((u?.isOperator ?? false) && ((u?.isEngineer ?? false) == false) && ((u?.isAdmin ?? false) == false)) ? true : false,
                                  onChanged: (bool? value) {
                                    _currentUser.value = _currentUser.value!.copyWith(isOperator: true);
                                    _currentUser.value = _currentUser.value!.copyWith(isEngineer: false);
                                    _currentUser.value = _currentUser.value!.copyWith(isAdmin: false);
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Инженер: ",
                                  style: theme.textTheme.bodyLarge,
                                ),
                                Checkbox(
                                  value: (((u?.isOperator ?? false) == false) && (u?.isEngineer ?? false) && ((u?.isAdmin ?? false) == false)) ? true : false,
                                  onChanged: (bool? value) {
                                    _currentUser.value = _currentUser.value!.copyWith(isEngineer: true);
                                    _currentUser.value = _currentUser.value!.copyWith(isOperator: false);
                                    _currentUser.value = _currentUser.value!.copyWith(isAdmin: false);
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Админ: ",
                                  style: theme.textTheme.bodyLarge,
                                ),
                                Checkbox(
                                  value: (((u?.isOperator ?? false) == false) && ((u?.isEngineer ?? false) == false) && (u?.isAdmin ?? false)) ? true : false,
                                  onChanged: (bool? value) {
                                    _currentUser.value = _currentUser.value!.copyWith(isAdmin: true);
                                    _currentUser.value = _currentUser.value!.copyWith(isEngineer: false);
                                    _currentUser.value = _currentUser.value!.copyWith(isOperator: false);
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ProgressButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (argUser != null) {
                      await repository.updateUser(_currentUser.value!, context: context);
                      _user = _currentUser.value!.copyWith(login: _currentUser.value!.login);

                      Navigator.pop(context);
                    } else {
                      await repository.createUser(_currentUser.value!, _controllers["pin"]!.text, context: context);
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text("Сохранить"),
              ),
              ElevatedButton(
                onPressed: () {
                  _currentUser.value = _user!.copyWith(login: _user!.login);
                  initControllersValues();
                  repository.updateUsers(context: context);
                },
                child: Text("Отменить"),
              ),
            ],
          )
        ],
      ),
    );
  }
}