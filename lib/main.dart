import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

Future<void> getWhat() async {
  final chopper = ChopperClient(
    baseUrl: 'https://jsonplaceholder.com',
    services: [],
    converter: JsonConverter(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}
