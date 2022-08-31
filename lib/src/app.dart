import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduler/src/routing/routing.gr.dart';

class MyApp extends ConsumerWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Builder(builder: (context) {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Daily Task',
        themeMode: ThemeMode.dark,
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(),
      );
    });
  }
}
