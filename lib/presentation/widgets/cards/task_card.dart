import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../styles/text_styles.dart';
import '../../../utils/widgets_utils.dart';

class TaskCardView extends StatelessWidget {
  final int id;
  final int stationID;
  final int? versionID;
  final String taskType;
  final String taskStatus;
  final String error;
  final String createdAt;
  final String startedAt;
  final String stoppedAt;
  final int triesCount;

  const TaskCardView({
    required this.id,
    required this.stationID,
    required this.versionID,
    required this.taskType,
    required this.taskStatus,
    required this.error,
    required this.createdAt,
    required this.startedAt,
    required this.stoppedAt,
    required this.triesCount,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'queue':
        return Colors.blue.shade400;
      case 'started':
        return Colors.orange.shade400;
      case 'completed':
        return Colors.green.shade400;
      case 'error':
        return Colors.red.shade600;
      case 'canceled':
        return Colors.grey.shade600;
      default:
        return Colors.black;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'completed':
        return Icons.check_circle;
      case 'error':
        return Icons.error;
      case 'canceled':
        return Icons.cancel;
      default:
        return Icons.hourglass_empty;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color statusColor = _getStatusColor(taskStatus);
    IconData statusIcon = _getStatusIcon(taskStatus);
    return Card(
      elevation: 5,
      color: statusColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _CardHeader(id: id, statusIcon: statusIcon, stationId: stationID),
            Divider(color: Colors.white70),
            _CardInfoSection(taskType: taskType, taskStatus: taskStatus),
            Divider(color: Colors.white70),
            _CardDatesSection(
                createdAt: createdAt,
                startedAt: startedAt,
                error: error,
                stoppedAt: stoppedAt
            ),
            if (error.isNotEmpty) ...[
              Divider(color: Colors.white70),
              _CardErrorSection(error: error,),
            ],
            if (triesCount > 0) ...[
              Divider(color: Colors.white70),
              _TriesCountSection(triesCount: triesCount,),
            ]
          ],
        ),
      ),
    );
  }

}

class _CardHeader extends StatelessWidget {

  final int id;
  final int stationId;
  final IconData statusIcon;

  const _CardHeader({super.key, required this.id, required this.statusIcon, required this.stationId});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('${context.tr('task')} #$id', style: TextStyles.cardHeader(),),
        Text('${context.tr('station')} #$stationId', style: TextStyles.cardHeader(),),
        Icon(statusIcon, color: Colors.white),
      ],
    );
  }
}

class _CardInfoSection extends StatelessWidget {

  final String taskType;
  final String taskStatus;

  const _CardInfoSection({super.key, required this.taskType, required this.taskStatus});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: _cardKeyValueRow('${context.tr('type')}:', getTypeName(taskType))),
        Expanded(child: _cardKeyValueRow('${context.tr('status')}:', getStatusName(taskStatus))),
      ],
    );
  }

  Widget _cardKeyValueRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: Row(
        children: <Widget>[
          Text(key, style: TextStyles.cardTextBold()),
          SizedBox(width: 8),
          Expanded(child: Text(value, style: TextStyles.cardText())),
        ],
      ),
    );
  }
}

class _CardDatesSection extends StatelessWidget {

  final String createdAt;
  final String startedAt;
  final String stoppedAt;
  final String error;

  const _CardDatesSection({super.key, required this.createdAt, required this.startedAt, required this.error, required this.stoppedAt});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(context.tr('time'), style: TextStyles.cardSubHeader()),
        ),
        Table(
          columnWidths: const {
            0: IntrinsicColumnWidth(),
            1: FlexColumnWidth(),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            _buildTableRow('${context.tr('created_at')}: ', createdAt),
            _buildTableRow('${context.tr('started_at')}: ', startedAt),
            _buildTableRow(error.isNotEmpty ? '${context.tr('stopped_at')}: ' : '${context.tr('completed_at')}: ', stoppedAt),
          ],
        ),
      ],
    );
  }

  TableRow _buildTableRow(String key, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(key, style: TextStyles.cardTextBold()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(value, style: TextStyles.cardText(),),
        ),
      ],
    );
  }

}

class _CardErrorSection extends StatelessWidget {

  final String error;

  const _CardErrorSection({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('${context.tr('error')}', style: TextStyles.cardSubHeader()),
        Text(error, style: TextStyles.cardText()),
      ],
    );
  }
}

class _TriesCountSection extends StatelessWidget {

  final int triesCount;

  const _TriesCountSection({super.key, required this.triesCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('${context.tr('tries_count')}: $triesCount', style: TextStyles.cardSubHeader()),
      ],
    );
  }
}