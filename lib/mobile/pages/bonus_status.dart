import 'package:flutter/material.dart';
import '../../entity/vo/page_args_codes.dart';
import '../../repository/lea_central_wash_repo/repository.dart';
import '../widgets/ServiceStatus/service_status.dart';

class BonusStatusPage extends StatefulWidget {
  const BonusStatusPage({Key? key}) : super(key: key);

  @override
  State<BonusStatusPage> createState() => _BonusStatusPageState();
}

class _BonusStatusPageState extends State<BonusStatusPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final repository = args[PageArgCode.repository] as LeaCentralRepository;

    return Scaffold(
      appBar: AppBar(
        title: Text("Информация о СБП"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ValueListenableBuilder(
            valueListenable: repository.getBonusStatusNotifier(),
            builder: (context, bonusStatus, _) {
              return ServiceStatus(
                serviceName: 'Сервис Бонусов',
                disabledOnServer: bonusStatus?.disabledOnServer,
                isConnected: bonusStatus?.isConnected,
                lastErr: bonusStatus?.lastErr,
                dateLastErrUTC: bonusStatus?.dateLastErrUTC,
                unpaidStations: bonusStatus?.unpaidStations,
              );
            },
          )
      ),
    );
  }
}
