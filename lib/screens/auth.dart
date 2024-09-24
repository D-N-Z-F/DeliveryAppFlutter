import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginRegisterProvider = StateProvider<bool>((ref) => true);
final formKey = GlobalKey<FormState>();
final emailNode = FocusNode();
final passwordNode = FocusNode();

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  static const route = "/auth";
  static const routeName = "Auth";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRegistering = ref.watch(loginRegisterProvider);
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
                    fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              Text(isRegistering
                  ? "Create your account here"
                  : "Enter your email and password to sign in"),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: TextFormField(
                    focusNode: emailNode,
                    decoration: InputDecoration(
                        labelText: "Enter your email",
                        hintText: "e.g 123@gmail.com",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)))),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: TextFormField(
                    focusNode: passwordNode,
                    decoration: InputDecoration(
                        labelText: "Enter your password",
                        hintText: "e.g 1234567890",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)))),
              ),
              TextButton(
                  onPressed: () {
                    ref.read(loginRegisterProvider.notifier).state =
                        !isRegistering;
                  },
                  child: Text(isRegistering
                      ? "Already have an account? Sign In now!"
                      : "Don't have an account? Sign Up now!")),
              Center(
                  child: FilledButton(
                      onPressed: () {},
                      child: Text(isRegistering ? "Register" : "Login")))
            ],
          ),
        ),
      ),
    );
  }
}
