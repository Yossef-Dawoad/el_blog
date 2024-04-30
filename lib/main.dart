import 'package:flutter/material.dart';

import 'core/di/dependancy_injection.dart';
import 'core/routes/router_config.dart';
import 'core/routes/routes.dart';
import 'core/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependancies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog Demo',
      theme: AppTheme.darkThemeData,
      initialRoute: Routes.signUp,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
