import 'package:clean_blog/core/routes/router_config.dart';
import 'package:clean_blog/core/routes/routes.dart';
import 'package:clean_blog/core/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog Demo',
      theme: AppTheme.darkThemeData,
      initialRoute: Routes.intitalRoute,
      onGenerateRoute: AppRouter.onGenerateRoute,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
