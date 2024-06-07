import 'package:clean_blog/core/di/dependancy_injection.dart';
import 'package:clean_blog/core/routes/routes.dart';
import 'package:clean_blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_blog/features/auth/presentation/pages/login_page.dart';
import 'package:clean_blog/features/auth/presentation/pages/signup_page.dart';
import 'package:clean_blog/features/blog/presentation/bloc/blog_bloc/blog_bloc.dart';
import 'package:clean_blog/features/blog/presentation/pages/blog_page.dart';
import 'package:clean_blog/features/first_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    return switch (settings.name) {
      Routes.intitalRoute => MaterialPageRoute(builder: (_) => const ManageFirstRoute()),
      Routes.logIn => MaterialPageRoute(
          builder: (_) =>
              BlocProvider<AuthBloc>(create: (context) => sl<AuthBloc>(), child: const LogInPage()),
        ),
      Routes.signUp => MaterialPageRoute(
          builder: (_) => BlocProvider<AuthBloc>(
            create: (context) => sl<AuthBloc>(),
            child: const SignUpPage(),
          ),
        ),
      Routes.home => MaterialPageRoute(
          builder: (_) => BlocProvider<BlogBloc>(
            create: (context) => sl<BlogBloc>(),
            child: const BlogPage(),
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
