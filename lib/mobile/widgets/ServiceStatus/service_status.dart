import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ServiceStatus extends StatelessWidget {
  final String serviceName;
  final bool? disabledOnServer;
  final bool? isConnected;
  final String? lastErr;
  final int? dateLastErrUTC;
  final List<int>? unpaidStations;

  const ServiceStatus({
    Key? key,
    required this.serviceName,
    required this.disabledOnServer,
    required this.isConnected,
    this.lastErr,
    this.dateLastErrUTC,
    this.unpaidStations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: ListView(
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Icon(Icons.cloud, size: 60, color: Colors.blueGrey[200]),
                  SizedBox(height: 20),
                  Text(
                    serviceName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    leading: Icon((disabledOnServer ?? false) ? Icons.cloud_off : Icons.cloud_done,
                        color: (disabledOnServer ?? false) ? Colors.red : Colors.green),
                    title: Text((disabledOnServer ?? false) ? "Выключен на сервере" : "Включен на сервере"),
                  ),
                  ListTile(
                    leading: Icon((isConnected ?? false) ? Icons.link : Icons.link_off,
                        color: (isConnected ?? false) ? Colors.green : Colors.red),
                    title: Text((isConnected ?? false) ? "Подключен" : "Не подключен"),
                  ),
                ],
              ),
            ),
          ),
          if (unpaidStations != null && unpaidStations!.isNotEmpty)
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Неоплаченные станции:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 16),
                    ...unpaidStations!.map((station) => Row(
                      children: [
                        Icon(Icons.warning, color: Colors.red),
                        SizedBox(width: 8),
                        Text(
                          "Станция $station",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )).toList(),
                  ],
                ),
              ),
            ),
          if (lastErr != null && dateLastErrUTC != null)
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Последняя ошибка",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text("$lastErr"),
                    SizedBox(height: 10),
                    Text(
                      "Время ошибки: ${DateFormat('d MMMM y HH:mm', 'ru_RU').format(DateTime.fromMillisecondsSinceEpoch(dateLastErrUTC! * 1000).toLocal())}",
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
