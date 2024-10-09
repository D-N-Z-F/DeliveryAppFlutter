import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const route = "/register";
  static const routeName = "Register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                "New here?",
                style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.w500),
              ),
              const Text("Create your account here"),
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
            ],
          ))),
    );
  }
}
