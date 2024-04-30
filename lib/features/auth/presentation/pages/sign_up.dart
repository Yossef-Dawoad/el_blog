import 'package:clean_blog/core/common/space.dart';
import 'package:clean_blog/core/common/widgets/cta_button.dart';
import 'package:clean_blog/core/common/widgets/loaders.dart';
import 'package:clean_blog/core/common/widgets/snackbars.dart';
import 'package:clean_blog/core/extensions/context_ext.dart';
import 'package:clean_blog/core/routes/routes.dart';
import 'package:clean_blog/core/theme/color_pallete.dart';
import 'package:clean_blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_blog/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(Space.dfltSpace),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) => switch (state) {
            AuthFailure() => showSnackBar(context, state.message),
            AuthSuccess() => context.popUntilRouteNamed(Routes.logIn),
            _ => showSnackBar(context, 'Sometning went wrong'),
          },
          builder: (context, state) {
            if (state is AuthLoading) return const FullBodyLoadinIndicator();

            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      'Sign Up.',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 30),
                    AuthInputField(
                        hintText: 'Name', controller: nameController),
                    const SizedBox(height: 15),
                    AuthInputField(
                        hintText: 'Email', controller: emailController),
                    const SizedBox(height: 15),
                    AuthInputField(
                      hintText: 'Password',
                      controller: passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 30),
                    CTAButton(
                      label: 'Sign Up',
                      onPressed: () => _performSignUp(context),
                    ),
                    const SizedBox(height: 30),
                    RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Pallete.gradient1,
                                  fontWeight: FontWeight.bold,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () => context.pushNamedRoute(Routes.logIn),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _performSignUp(BuildContext ctx) {
    if (_formKey.currentState!.validate()) {
      ctx.read<AuthBloc>().add(
            AuthSignUpEvt(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
              name: nameController.text.trim(),
            ),
          );
    }
    //TODO display popup wit te error
  }
}
