import 'package:clean_blog/core/common/blocs/localization/localization_bloc.dart';
import 'package:clean_blog/core/di/dependancy_injection.dart';
import 'package:clean_blog/core/routes/router_config.dart';
import 'package:clean_blog/core/routes/routes.dart';
import 'package:clean_blog/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocalizationBloc>(
          create: (BuildContext context) => sl<LocalizationBloc>()..add(GetCurrentLocale()),
        ),
      ],
      child: BlocBuilder<LocalizationBloc, LocalizationState>(
        // buildWhen: (prev, curr) => curr is LocalizationChangeSuccess,
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Blog Demo',
            theme: AppTheme.darkThemeData,
            initialRoute: Routes.intitalRoute,
            onGenerateRoute: AppRouter.onGenerateRoute,
            locale: state.selectedLanguage.locale,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
          );
        },
      ),
    );
  }
}
