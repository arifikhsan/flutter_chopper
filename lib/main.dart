import 'package:flutter/material.dart';
import 'package:flutter_chopper/data/post_api_service.dart';
import 'package:flutter_chopper/home_page.dart';
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';

void main() {
  _setupLogging();
  runApp(MyApp());
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PostApiService.create(),
      dispose: (_, PostApiService service) => service.client.dispose(),
      child: MaterialApp(
        title: 'Material App',
        home: HomePage(),
      ),
    );
  }
}
