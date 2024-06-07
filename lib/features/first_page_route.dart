import 'package:clean_blog/core/common/blocs/app_user/app_user_bloc.dart';
import 'package:clean_blog/core/di/dependancy_injection.dart';
import 'package:clean_blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_blog/features/auth/presentation/pages/login_page.dart';
import 'package:clean_blog/features/blog/presentation/bloc/blog_bloc/blog_bloc.dart';
import 'package:clean_blog/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageFirstRoute extends StatelessWidget {
  const ManageFirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>()..add(AuthGetCurrentUserEvt()),
        ),
      ],
      child: BlocSelector<AuthenticatedUserBloc, AuthenticatedUserState, bool>(
        selector: (state) => state is AuthenticatedUserLoggedInSuccess,
        builder: (context, loggedInState) => switch (loggedInState) {
          true => BlocProvider(
              create: (context) => sl<BlogBloc>(),
              child: const BlogPage(),
            ),
          false => const LogInPage(),
        },
      ),
    );
  }
}
