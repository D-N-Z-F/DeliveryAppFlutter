import 'package:delivery_app_flutter/common/widgets/empty_display.dart';
import 'package:delivery_app_flutter/data/providers/user_provider.dart';
import 'package:delivery_app_flutter/data/repositories/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateProfileScreen extends ConsumerStatefulWidget {
  final String id;
  const UpdateProfileScreen({super.key, required this.id});

  static const route = "/updateProfile/:id";
  static const routeName = "Update Profile";

  @override
  ConsumerState<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends ConsumerState<UpdateProfileScreen> {
  final userRepo = UserRepo();

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(userProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Update Profile"),
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Personal details",
                style: TextStyle(fontSize: 18.0),
              ),
              Form(
                  child: data.when(data: (user) {
                    return Column(
                children: [
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Name"),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  labelText: "Enter your username",
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always),
                            ),
                          )
                        ],
                      ), // Instantiated TextFormField widget
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Email"),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: "Enter your email",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always)),
                            )
                          ],
                        ), // Instantiated TextFormField widget
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Password"),
                          Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: "Enter your password",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always)))
                        ],
                      ), // Instantiated TextFormField widget
                    ),
                  ),
                  
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Update"),
                    ),
                  )
                ],
              );
                  },   error: (_, __) => const EmptyDisplay(),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),))
            ],
          ),
        ));
  }
}
