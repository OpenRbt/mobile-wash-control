import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:mobile_wash_control/utils/utils.dart';

import '../../../mobile/widgets/common/snackBars.dart';
import '../../../styles/text_styles.dart';

class PostVersionCard extends StatelessWidget {
  final int id;
  final String builtAt;
  final String commitedAt;
  final String hashLua;
  final String hashEnv;
  final String hashBinar;
  final bool isCurrent;
  final Future<void> Function(int id) onDownloadPressed;
  final Future<void> Function(int id) onUploadPressed;

  const PostVersionCard({
    super.key,
    required this.builtAt,
    required this.isCurrent,
    required this.id,
    required this.commitedAt,
    required this.onDownloadPressed,
    required this.onUploadPressed,
    required this.hashLua,
    required this.hashEnv,
    required this.hashBinar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Text('ID', style: TextStyles.cardTextBlackBold()),
                  SizedBox(width: 8),
                  Expanded(child: Text(id.toString())),
                  isCurrent ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(context.tr('current_version'), style: TextStyle(color: Colors.green)),
                  ) : Container(),
                ],
              ),
            ),
            Divider(color: Colors.grey),
            _buildKeyValueRow('${context.tr('build_at')}:', id != 0 ? formatDateWithoutTime(builtAt) : '${context.tr('initial_version')}'),
            _buildKeyValueRow('${context.tr('update_from')}:', id != 0 ? formatDateWithoutTime(commitedAt) : '${context.tr('initial_version')}'),
            Divider(color: Colors.grey),
            _buildKeyValueRow('Hash LUA:', hashLua.isNotEmpty ? hashLua.substring(1, 4) + '...' + hashLua.substring(hashLua.length - 4, hashLua.length - 1) : ''),
            _buildKeyValueRow('Hash ENV:', hashEnv.isNotEmpty ? hashEnv.substring(1, 4) + '...' + hashEnv.substring(hashEnv.length - 4, hashEnv.length - 1) : ''),
            _buildKeyValueRow('Hash BIN:', hashBinar.isNotEmpty ? hashBinar.substring(1, 4) + '...' + hashBinar.substring(hashBinar.length - 4, hashBinar.length - 1) : ''),
            Row(
              children: [
                Expanded(
                    child: OutlinedButton.icon(
                      onPressed: isCurrent ? null : () async {
                        try {
                          await onDownloadPressed(id);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: context.tr('download_versions_task_has_been_created')));
                        } on FormatException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error_has_occurred')} $e"));
                          rethrow;
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')} $e"));
                          rethrow;
                        }
                      },
                      icon: const Icon(Icons.download_outlined),
                      label: Text(context.tr('make_current')),
                    ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      try {
                        await onUploadPressed(id);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getSuccessSnackBar(message: context.tr('upload_versions_task_has_been_created')));
                      } on FormatException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('error_has_occurred')} $e"));
                        rethrow;
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBars.getErrorSnackBar(message: "${context.tr('an_unknown_error_has_occurred')} $e"));
                        rethrow;
                      }
                    },
                    icon: const Icon(Icons.upload_outlined),
                    label: Text(context.tr('copy_to_server')),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}

class BufferedVersionView extends StatelessWidget {

  final String builtAt;
  final String commitedAt;
  final String hashLua;
  final String hashEnv;
  final String hashBinar;

  const BufferedVersionView({super.key, required this.builtAt, required this.commitedAt, required this.hashLua, required this.hashEnv, required this.hashBinar});

  @override
  Widget build(BuildContext context) {

    final builtAtCheck = formatDateWithoutTime(builtAt);
    final commitedAtCheck = formatDateWithoutTime(commitedAt);

    return Column(
      children: [
        _buildKeyValueRow('${context.tr('build_at')}:', builtAtCheck != '1 ${context.tr('january')} 0001' ? builtAtCheck : '${context.tr('initial_version')}'),
        _buildKeyValueRow('${context.tr('update_from')}:', commitedAtCheck != '1 ${context.tr('january')} 0001' ? commitedAtCheck : '${context.tr('initial_version')}'),
        Divider(color: Colors.grey),
        _buildKeyValueRow('Hash LUA:', hashLua.isNotEmpty ? hashLua.substring(1, 4) + '...' + hashLua.substring(hashLua.length - 4, hashLua.length - 1) : ''),
        _buildKeyValueRow('Hash ENV:', hashEnv.isNotEmpty ? hashEnv.substring(1, 4) + '...' + hashEnv.substring(hashEnv.length - 4, hashEnv.length - 1) : ''),
        _buildKeyValueRow('Hash BIN:', hashBinar.isNotEmpty ? hashBinar.substring(1, 4) + '...' + hashBinar.substring(hashBinar.length - 4, hashBinar.length - 1) : ''),
      ],
    );
  }
}


Widget _buildKeyValueRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Text(key, style: TextStyles.cardTextBlackBold()),
        SizedBox(width: 8),
        Expanded(child: Text(value)),
      ],
    ),
  );
}