import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pantest/lib.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      injectionInit();

      await initializeDateFormatting('id_ID').then(
        (value) => runApp(
          const MyApp(),
        ),
      );
    },
    (error, stackTrace) {
      if (kDebugMode) {
        print('MAIN ERROR || ${stackTrace.toString()}');
      }
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.routeName,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
