import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/auth/authButton.dart';
import 'package:mobile_wash_control/openapi/lea-central-wash/api.dart' as lcw;
import 'package:mobile_wash_control/repository/lea_central_wash_repo/repository.dart';
import 'package:mobile_wash_control/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Common/bonus_common.dart';
import '../../Common/lcw_common.dart';
import '../../Common/management_common.dart';
import '../../Common/sbp_common.dart';
import '../widgets/common/snackBars.dart';

class Auth extends StatefulWidget {
  final String? host;

  const Auth({super.key, required this.host});

  @override
  State<StatefulWidget> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  List<String> labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "+", "0", "-"];

  late TextEditingController pinController;

  Repository? _repo = null;

  @override
  void initState() {
    pinController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    pinController.dispose();
    _repo?.dispose();
    super.dispose();
  }

  Future<void> _tryAuth() async {
    try {
      var client = lcw.DefaultApi(lcw.ApiClient(basePath: widget.host!));
      client.apiClient.addDefaultHeader("Pin", pinController.text);

      LcwCommon.initializeApis(widget.host!, pinController.text);

      final prefs = await SharedPreferences.getInstance();
      final int addServiceValue = prefs.getInt("AddServiceValue") ?? 0;

      var args = Map<PageArgCode, dynamic>();
      var repo = LeaCentralRepository(client);
      args[PageArgCode.repository] = repo;

      final user = await repo.getCurrentUser();
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBars.getErrorSnackBar(
            message: 'there_is_no_user_with_this_password'.tr(),
          ),
        );
        repo.dispose();
        return;
      }
      _repo?.dispose();
      _repo = repo;
      GlobalData.AddServiceValue = addServiceValue;
      SystemChrome.setPreferredOrientations([]);

      String? bonusUrl = await repo.getServerInfo(context: context);
      String basePath = "";
      if(bonusUrl?.isNotEmpty ?? false){
        basePath = (bonusUrl)! + '/api/bonus/admin';
      }
      BonusCommon.initializeApis(basePath);
      SbpCommon.initializeApis((bonusUrl)! + '/api/sbp');
      ManagementCommon.initializeApis((bonusUrl) + '/api/mngt');
      Navigator.pushNamed(
        context,
        "/mobile/home",
        arguments: args,
      );
    } catch (e) {
    }
  }

  Widget build(BuildContext context) {

    if (widget.host == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed("/");
      });
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: Navigator.of(context).canPop()
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.exit_to_app_outlined),
            )
          : null,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        context.tr('authorization'),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.host!,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: pinController,
                        readOnly: true,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          letterSpacing: 6,
                        ),
                        obscureText: true,
                        maxLength: 16,
                        decoration: const InputDecoration(counterText: ""),
                      ),
                      const SizedBox(height: 24),
                      GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        crossAxisCount: 3,
                        childAspectRatio: 1.9,
                        children: List.generate(
                          labels.length,
                          (index) {
                            return AuthButton(
                              label: labels[index],
                              onPressed: () {
                                setState(
                                  () {
                                    switch (labels[index]) {
                                      case "+":
                                        _tryAuth();
                                        break;
                                      case "-":
                                        var tmp = pinController.text;
                                        if (tmp.length > 1) {
                                          tmp = tmp.substring(0, tmp.length - 1);
                                        } else {
                                          tmp = "";
                                        }
                                        pinController.text = tmp;
                                        break;
                                      default:
                                        var tmp = pinController.text;
                                        if (tmp.length == 16) {
                                          break;
                                        }

                                        tmp += labels[index];
                                        pinController.text = tmp;
                                        break;
                                    }
                                  },
                                );
                              },
                              onLongPressed: (labels[index] == "-")
                                  ? () {
                                      pinController.text = "";
                                    }
                                  : null,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
