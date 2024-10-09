import 'package:delivery_app_flutter/data/repositories/user_repo.dart';
import 'package:delivery_app_flutter/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  static const route = "/auth";
  static const routeName = "Auth";

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final authStateProvider = StateProvider<bool>((ref) => false);
  final formKey = GlobalKey<FormState>();
  final userRepo = UserRepo();
  final Map<String, TextEditingController> controllers = {
    "username": TextEditingController(),
    "email": TextEditingController(),
    "password": TextEditingController(),
    "password2": TextEditingController(),
  };

  void login() async {
    if (formKey.currentState!.validate()) {
      await userRepo.login(
        controllers["email"]!.text,
        controllers["password"]!.text,
      );
    }
  }

  void register() async {
    if (formKey.currentState!.validate()) {
      await userRepo.register(
        controllers["username"]!.text,
        controllers["email"]!.text,
        controllers["password"]!.text,
        controllers["password2"]!.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRegistering = ref.watch(authStateProvider);
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
              if (isRegistering)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child: TextFormField(
                      controller: controllers["username"],
                      validator: (value) => Validators.validateUsername(value),
                      decoration: InputDecoration(
                          labelText: "Enter your username",
                          hintText: "e.g John Doe",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)))),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: TextFormField(
                    controller: controllers["email"],
                    validator: (value) => Validators.validateEmail(value),
                    decoration: InputDecoration(
                        labelText: "Enter your email",
                        hintText: "e.g johndoe@gmail.com",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)))),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: TextFormField(
                    controller: controllers["password"],
                    obscureText: true,    
                    validator: (value) => Validators.validatePassword(value),
                    decoration: InputDecoration(
                        labelText: "Enter your password",
                        hintText: "e.g johndoe123",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)))),
              ),
              if (isRegistering)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child: TextFormField(
                      controller: controllers["password2"],
                      obscureText: true,
                      validator: (value) => Validators.validatePassword2(
                          value, controllers["password"]!.text),
                      decoration: InputDecoration(
                          labelText: "Confirm password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)))),
                ),
              TextButton(
                  onPressed: () {
                    ref.read(authStateProvider.notifier).state = !isRegistering;
                  },
                  child: Text(isRegistering
                      ? "Already have an account? Sign In now!"
                      : "Don't have an account? Sign Up now!")),
              Center(
                  child: FilledButton(
                      onPressed: isRegistering ? register : login,
                      child: Text(isRegistering ? "Register" : "Login")))
            ],
          ),
        ),
      ),
    );
  }
}
