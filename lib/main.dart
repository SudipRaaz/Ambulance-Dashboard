import 'package:ambulance_dashboard/model/tab_manager.dart';
import 'package:ambulance_dashboard/utilities/route/route_path.dart';
import 'package:ambulance_dashboard/utilities/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [Provider(create: (_) => TabManager())],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ambulance Dashboard',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: RouteNames.pageLayout,
          onGenerateRoute: Routes.generateRoutes,
        ));
  }
}
