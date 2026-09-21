import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_wash_control/CommonElements.dart';
import 'package:mobile_wash_control/entity/vo/page_args_codes.dart';
import 'package:mobile_wash_control/mobile/widgets/auth/authButton.dart';
import 'package:mobile_wash_control/openapi/lea-central-wash/api.dart' as lcw;
import 'package:mobile_wash_control/repository/lea_central_wash_repo/repository.dart';
import 'package:mobile_wash_control/repository/repository.dart';
import 'package:mobile_wash_control/utils/timeout_client.dart';
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
  bool _authInProgress = false;

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
    // The keypad can be tapped again while the request is in flight; without this
    // every tap built another repository with its own polling loop.
    if (_authInProgress) {
      return;
    }
    setState(() {
      _authInProgress = true;
    });

    // Owned by this method until it is handed over to _repo / the next route.
    LeaCentralRepository? pendingRepo;
    try {
      var client = lcw.DefaultApi(lcw.ApiClient(basePath: widget.host!));
      client.apiClient.client = TimeoutClient();
      client.apiClient.addDefaultHeader("Pin", pinController.text);

      LcwCommon.initializeApis(widget.host!, pinController.text);

      final prefs = await SharedPreferences.getInstance();
      final int addServiceValue = prefs.getInt("AddServiceValue") ?? 0;

      var args = Map<PageArgCode, dynamic>();
      pendingRepo = LeaCentralRepository(client);
      args[PageArgCode.repository] = pendingRepo;

      final user = await pendingRepo.getCurrentUser();
      if (!mounted) {
        return;
      }
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBars.getErrorSnackBar(
            message: 'there_is_no_user_with_this_password'.tr(),
          ),
        );
        return;
      }

      _repo?.dispose();
      _repo = pendingRepo;
      pendingRepo = null;
      GlobalData.AddServiceValue = addServiceValue;
      SystemChrome.setPreferredOrientations([]);

      // A server that reports no bonus URL is a valid setup: the bonus, SBP and
      // management APIs stay unconfigured instead of throwing on a null check and
      // leaving the confirm key looking dead.
      final String bonusUrl = (await _repo!.getServerInfo(context: context)) ?? '';
      BonusCommon.initializeApis(
        bonusUrl.isEmpty ? '' : '$bonusUrl/api/bonus/admin',
      );
      SbpCommon.initializeApis(bonusUrl.isEmpty ? '' : '$bonusUrl/api/sbp');
      ManagementCommon.initializeApis(
        bonusUrl.isEmpty ? '' : '$bonusUrl/api/mngt',
      );

      if (!mounted) {
        return;
      }
      Navigator.pushNamed(
        context,
        "/mobile/home",
        arguments: args,
      );
    } catch (e) {
      if (mounted) {
        // An empty catch here used to make the confirm key look dead whenever the
        // server was unreachable or answered with an error.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBars.getErrorSnackBar(
            message: "${'an_unknown_error_has_occurred'.tr()}: $e",
          ),
        );
      }
    } finally {
      pendingRepo?.dispose();
      _authInProgress = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
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
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 2,
                        child: _authInProgress
                            ? const LinearProgressIndicator(minHeight: 2)
                            : null,
                      ),
                      const SizedBox(height: 10),
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
