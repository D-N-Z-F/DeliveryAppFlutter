import 'package:delivery_app_flutter/main.dart';
import 'package:delivery_app_flutter/screens/home.dart';
import 'package:delivery_app_flutter/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const route = "/login";
  static const routeName = "Login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _navigateToHome() {
    context.push(HomeScreen.route);
  }

  void _navigateToSignUp() {
    context.push(RegisterScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: const EdgeInsets.all(10.0),
          child: Form(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.w500),
              ),
              const Text("Enter your email and password to sign in"),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Enter your email",
                        hintText: "e.g 123@gmail.com",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)))),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Enter your password",
                        hintText: "e.g 1234567890",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)))),
              ),
              TextButton(
                  onPressed: _navigateToSignUp,
                  child: const Text("Don't have an account? Sign Up now!")),
              Center(
                  child: FilledButton(
                      onPressed: _navigateToHome, child: const Text("Login")))
            ],
          ))),
    );
  }
}
