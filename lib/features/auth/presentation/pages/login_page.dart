import 'package:clean_blog/core/common/space.dart';
import 'package:clean_blog/core/common/widgets/cta_button.dart';
import 'package:clean_blog/core/common/widgets/loaders.dart';
import 'package:clean_blog/core/common/widgets/snackbars.dart';
import 'package:clean_blog/core/extensions/context_ext.dart';
import 'package:clean_blog/core/routes/routes.dart';
import 'package:clean_blog/core/theme/color_pallete.dart';
import 'package:clean_blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_blog/generated/l10n.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/auth_input_field.dart';
import '../../../../core/common/widgets/language_switcher_widget.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Space.dfltSpace).copyWith(top: 30.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listenWhen: (prev, curr) => curr is AuthFailure || curr is AuthSuccess,
            listener: (context, state) => switch (state) {
              AuthFailure() => showSnackBar(context, state.message),
              AuthSuccess() => context.pushNamedRoute(Routes.home),
              _ => showSnackBar(context, 'Sometning went wrong'),
            },
            builder: (context, state) {
              if (state is AuthLoading) return const FullBodyLoadinIndicator();
              return Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.signIn,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 30),
                        AuthInputField(
                          hintText: 'Email',
                          controller: emailController,
                        ),
                        const SizedBox(height: 15),
                        AuthInputField(
                          hintText: 'Password',
                          controller: passwordController,
                          obscureText: true,
                        ),
                        const SizedBox(height: 30),
                        CTAButton(
                          label: l10n.signIn,
                          onPressed: () => _performLogIn(context),
                        ),
                        const SizedBox(height: 30),
                        RichText(
                          text: TextSpan(
                            text: l10n.dontHaveAcc,
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                              TextSpan(
                                text: l10n.signUp,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: Pallete.gradient1,
                                      fontWeight: FontWeight.bold,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => context.pushNamedRoute(Routes.signUp),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  LanguageSwitcher(l10n: l10n),
                  const SizedBox(height: 12.0)
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _performLogIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthSignInEvt(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            ),
          );
    }
  }
}
