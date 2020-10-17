import './config/palette.dart';
import './screens/screens.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'dart:async' show runZoned;
import 'package:path/path.dart' show join, dirname;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';

void main() {
  // Assumes the server lives in bin/ and that `webdev build` ran
  var pathToBuild = join(dirname(Platform.script.toFilePath()), '..', 'build');

  var handler = createStaticHandler(pathToBuild, defaultDocument: 'index.html');

  var portEnv = Platform.environment['PORT'];
  var port = portEnv == null ? 9999 : int.parse(portEnv);

  runZoned(() {
    io.serve(handler, '0.0.0.0', port);
    print("Serving $pathToBuild on port $port");
  }, onError: (e, stackTrace) => print('Oh noes! $e $stackTrace'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Facebook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Palette.scaffold,
      ),
      home: NavScreen(),
    );
  }
}
