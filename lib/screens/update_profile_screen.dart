import 'package:delivery_app_flutter/common/widgets/empty_display.dart';
import 'package:delivery_app_flutter/common/widgets/header.dart';
import 'package:delivery_app_flutter/common/profile/update_profile_card.dart';
import 'package:delivery_app_flutter/data/providers/auth_provider.dart';
import 'package:delivery_app_flutter/data/providers/user_provider.dart';
import 'package:delivery_app_flutter/data/repositories/user_repo.dart';
import 'package:delivery_app_flutter/utils/constants/enums.dart';
import 'package:delivery_app_flutter/utils/constants/sizes.dart';
import 'package:delivery_app_flutter/utils/constants/strings.dart';

import 'package:delivery_app_flutter/utils/helpers/helpers.dart';
import 'package:delivery_app_flutter/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateProfileScreen extends ConsumerWidget {
  const UpdateProfileScreen({super.key});

  static const route = "/updateProfile";
  static const routeName = "Update Profile";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final formKey = GlobalKey<FormState>();
    final userRepo = UserRepo();
    final isChangingPassword = ref.watch(updateStateProvider);
    final data = ref.watch(userProvider);
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final password2Controller = TextEditingController();

    void updateUserDetails() async {
      if (formKey.currentState!.validate()) {
        final isSuccess = await userRepo.updateUserDetails(
          usernameController.text,
          emailController.text,
          passwordController.text,
        );
        if (isSuccess) {
          ref.invalidate(userProvider);
          if (context.mounted) Navigator.pop(context);
        }
      }
    }

    void updatePassword() async {
      if (formKey.currentState!.validate()) {
        final isSuccess =
            await userRepo.updatePassword(passwordController.text);
        if (isSuccess) {
          ref.invalidate(userProvider);
          if (context.mounted) Navigator.pop(context);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Header(heading: "Update Profile")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: Sizes.xs),
              child: const Text(
                "Personal details",
                style: TextStyle(fontSize: Sizes.fontLg),
              ),
            ),
            data.when(
              data: (user) => user == null
                  ? const EmptyDisplay(message: Strings.defaultErrorMessage)
                  : Form(
                      key: formKey,
                      child: Column(
                        children: [
                          if (!isChangingPassword)
                            UpdateProfileCard(
                              fieldName: "Username",
                              labelText: "Enter a new username",
                              hintText: user.username,
                              controller: usernameController,
                              validator: Validators.validateUsername,
                            ),
                          if (!isChangingPassword)
                            UpdateProfileCard(
                              fieldName: "Email",
                              labelText: "Enter a new email",
                              hintText: user.email,
                              controller: emailController,
                              validator: Validators.validateEmail,
                            ),
                          UpdateProfileCard(
                            fieldName: "Password",
                            labelText: isChangingPassword
                                ? "Enter a new password"
                                : "Enter your current password",
                            controller: passwordController,
                            validator: Validators.validatePassword,
                            isPasswordField: true,
                          ),
                          if (isChangingPassword)
                            UpdateProfileCard(
                              fieldName: "Confirm Password",
                              labelText: "Re-enter your new password",
                              controller: password2Controller,
                              validator2: (value, _) =>
                                  Validators.validatePassword2(
                                value,
                                password2Controller.text,
                              ),
                              isPasswordField: true,
                              comparator: passwordController.text,
                            ),
                          Container(
                            margin: const EdgeInsets.only(top: Sizes.lg),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () => isChangingPassword
                                      ? updatePassword()
                                      : updateUserDetails(),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor:
                                        scheme.get(MainColors.secondary),
                                  ),
                                  child: const Text("Update"),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: Sizes.sm),
                                  child: ElevatedButton(
                                    onPressed: () => ref
                                        .read(updateStateProvider.notifier)
                                        .state = !isChangingPassword,
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor:
                                          scheme.get(MainColors.secondary),
                                    ),
                                    child: Text(
                                      "Change ${isChangingPassword ? "User Details" : "Password"}",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
              error: (_, __) => const EmptyDisplay(),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
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
