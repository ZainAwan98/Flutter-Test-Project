import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_test_task/helpers/routes.dart';
import 'package:flutter_test_task/providers/auth_providers.dart';
import 'package:flutter_test_task/utils/validators.dart';
import 'package:flutter_test_task/widgets/custom_snackbar.dart';
import 'package:flutter_test_task/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey _key = GlobalKey();

  final FocusNode _emailFocus = FocusNode();

  late AuthProvider authProvider;

  final FocusNode _firstNameFocus = FocusNode();

  final FocusNode _lastNameFocus = FocusNode();

  final FocusNode _passwordFocus = FocusNode();

  final FocusNode _confirmPasswordFocus = FocusNode();

  bool _shouldRegisterNow = false;

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordConroller =
      TextEditingController();

  @override
  void didChangeDependencies() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text('Signup', style: TextStyle(fontSize: 20)),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  isPassword: false,
                  maxLines: 1,
                  inputType: TextInputType.name,
                  hintText: 'First Name',
                  controller: _firstNameController,
                  focusNode: _firstNameFocus,
                  nextFocus: _lastNameFocus,
                  onSubmit: () {},
                  onChanged: () {},
                  prefixIcon: Icons.person),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  isPassword: false,
                  maxLines: 1,
                  inputType: TextInputType.name,
                  hintText: 'Last Name',
                  controller: _lastNameController,
                  focusNode: _lastNameFocus,
                  nextFocus: _emailFocus,
                  onSubmit: () {},
                  onChanged: () {},
                  prefixIcon: Icons.person),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  hintText: 'Email',
                  controller: _emailController,
                  focusNode: _emailFocus,
                  nextFocus: _passwordFocus,
                  onSubmit: () {},
                  onChanged: () {},
                  prefixIcon: Icons.email),
              const SizedBox(
                height: 28,
              ),
              CustomTextField(
                  hintText: 'Password',
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  nextFocus: _confirmPasswordFocus,
                  onSubmit: () {},
                  onChanged: () {},
                  prefixIcon: Icons.password),
              const SizedBox(
                height: 28,
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () {
                    authProvider.register(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                        _firstNameController.text.trim(),
                        _lastNameController.text.trim(),
                        _key);
                  },
                  child: const Text('SignUp')),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(1, 40),
                ),
                onPressed: () async {
                  Navigator.of(context).pushNamed(RouteHelper.loginRoute);
                },
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Already a user? ',
                      style: TextStyle(color: Theme.of(context).disabledColor)),
                  TextSpan(
                      text: 'Login',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color)),
                ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
