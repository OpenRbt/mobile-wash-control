import 'package:flutter/material.dart';
import '../../../styles/text_styles.dart';

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
        Text('Задача #$id', style: TextStyles.cardHeader(),),
        Text('Станция #$stationId', style: TextStyles.cardHeader(),),
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
        Expanded(child: _cardKeyValueRow('Тип:', _getTypeName(taskType))),
        Expanded(child: _cardKeyValueRow('Статус:', _getStatusName(taskStatus))),
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

  String _getTypeName(String type) {
    switch (type) {
      case 'build':
        return 'сборка';
      case 'update':
        return 'обновление';
      case 'reboot':
        return 'перезагрузка';
      case 'getVersions':
        return 'получение версий';
      case 'pullFirmware':
        return 'выгрузка на сервер';
      case 'setVersion':
        return 'смена версии';
      default:
        return '';
    }
  }

  String _getStatusName(String status) {
    switch (status) {
      case 'queue':
        return 'в очереди';
      case 'started':
        return 'начата';
      case 'completed':
        return 'завершена';
      case 'error':
        return 'ошибка';
      case 'canceled':
        return 'отменена';
      default:
        return '';
    }
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
          child: Text('Время', style: TextStyles.cardSubHeader()),
        ),
        Table(
          columnWidths: const {
            0: IntrinsicColumnWidth(),
            1: FlexColumnWidth(),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            _buildTableRow('Создана: ', createdAt),
            _buildTableRow('Начата: ', startedAt),
            _buildTableRow(error.isNotEmpty ? 'Прекращена: ' : 'Заверешена: ', stoppedAt),
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
        Text('Ошибка', style: TextStyles.cardSubHeader()),
        Text(error, style: TextStyles.cardText()),
      ],
    );
  }
}
