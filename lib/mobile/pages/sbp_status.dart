import 'package:flutter/material.dart';

import '../../entity/vo/page_args_codes.dart';
import '../../repository/lea_central_wash_repo/repository.dart';
import '../widgets/ServiceStatus/service_status.dart';

class SbpStatusPage extends StatefulWidget {
  const SbpStatusPage({Key? key}) : super(key: key);

  @override
  State<SbpStatusPage> createState() => _SbpStatusPageState();
}

class _SbpStatusPageState extends State<SbpStatusPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final args = ModalRoute.of(context)?.settings.arguments as Map<PageArgCode, dynamic>;
    final repository = args[PageArgCode.repository] as LeaCentralRepository;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('SBP_info')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder(
          valueListenable: repository.getSbpStatusNotifier(),
          builder: (context, sbpStatus, _) {
            return ServiceStatus(
              serviceName: context.tr('SBP_service'),
              disabledOnServer: sbpStatus?.disabledOnServer,
              isConnected: sbpStatus?.isConnected,
              lastErr: sbpStatus?.lastErr,
              dateLastErrUTC: sbpStatus?.dateLastErrUTC,
              unpaidStations: sbpStatus?.unpaidStations,
            );
          },
        )
      ),
    );
  }
}
