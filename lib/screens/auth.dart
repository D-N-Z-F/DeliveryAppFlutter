import 'package:delivery_app_flutter/common/auth/auth_text_form_field.dart';
import 'package:delivery_app_flutter/common/widgets/loading_indicator.dart';
import 'package:delivery_app_flutter/data/providers/auth_provider.dart';
import 'package:delivery_app_flutter/data/providers/loading_provider.dart';
import 'package:delivery_app_flutter/data/repositories/user_repo.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';

import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:delivery_app_flutter/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  static const route = "/auth";
  static const routeName = "Auth";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final isRegistering = ref.watch(authStateProvider);
    final isLoading = ref.watch(loadingProvider);
    final formKey = GlobalKey<FormState>();
    final userRepo = UserRepo();
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final password2Controller = TextEditingController();

    void login() async {
      if (formKey.currentState!.validate()) {
        ref.read(loadingProvider.notifier).startLoading();
        await userRepo.login(emailController.text, passwordController.text);
        ref.read(loadingProvider.notifier).stopLoading();
      }
    }

    void register() async {
      if (formKey.currentState!.validate()) {
        ref.read(loadingProvider.notifier).startLoading();
        await userRepo.register(
          usernameController.text,
          emailController.text,
          passwordController.text,
          password2Controller.text,
        );
        ref.read(loadingProvider.notifier).stopLoading();
      }
    }

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isRegistering ? "New here?" : "Welcome back!",
                style: const TextStyle(
                  fontSize: Sizes.fontLg,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                isRegistering
                    ? "Create your account here"
                    : "Enter your email and password to sign in",
                style: const TextStyle(fontSize: Sizes.fontSm),
              ),
              if (isRegistering)
                AuthTextFormField(
                  controller: usernameController,
                  validator: Validators.validateUsername,
                  labelText: "Enter your username",
                  hintText: "e.g John Doe",
                ),
              AuthTextFormField(
                controller: emailController,
                validator: Validators.validateEmail,
                labelText: "Enter your email",
                hintText: "e.g johndoe@gmail.com",
              ),
              AuthTextFormField(
                controller: passwordController,
                validator: Validators.validatePassword,
                labelText: "Enter your password",
                hintText: "e.g johndoe123",
                isPasswordField: true,
              ),
              if (isRegistering)
                AuthTextFormField(
                  controller: password2Controller,
                  validator2: (value, _) => Validators.validatePassword2(
                    value,
                    passwordController.text,
                  ),
                  labelText: "Confirm password",
                  isPasswordField: true,
                  comparator: passwordController.text,
                ),
              TextButton(
                onPressed: () =>
                    ref.read(authStateProvider.notifier).state = !isRegistering,
                child: Text(
                  isRegistering
                      ? "Already have an account? Sign In now!"
                      : "Don't have an account? Sign Up now!",
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : isRegistering
                          ? register
                          : login,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: scheme.get(MainColors.secondary),
                  ),
                  child: isLoading
                      ? const LoadingIndicator()
                      : Text(isRegistering ? "Register" : "Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
