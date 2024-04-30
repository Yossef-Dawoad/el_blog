import 'package:clean_blog/core/di/dependancy_injection.dart';
import 'package:clean_blog/core/routes/routes.dart';
import 'package:clean_blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_blog/features/auth/presentation/pages/login_page.dart';
import 'package:clean_blog/features/auth/presentation/pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    return switch (settings.name) {
      Routes.logIn => MaterialPageRoute(
          builder: (_) => BlocProvider<AuthBloc>(
            create: (context) => sl<AuthBloc>(),
            child: const LogInPage(),
          ),
        ),
      Routes.signUp => MaterialPageRoute(
          builder: (_) => BlocProvider<AuthBloc>(
            create: (context) => sl<AuthBloc>(),
            child: const SignUpPage(),
          ),
        ),
      _ => _errorRoute(settings.name),
    };
  }

  static Route<dynamic> _errorRoute(String? pageName) {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text(
            '404 not Found',
            style: TextStyle(fontSize: 32.0),
          ),
        ),
      ),
    );
  }
}
