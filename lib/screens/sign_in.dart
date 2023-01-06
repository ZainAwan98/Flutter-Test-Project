import 'package:flutter/material.dart';

import 'package:flutter_test_task/helpers/routes.dart';
import 'package:flutter_test_task/providers/auth_providers.dart';
import 'package:flutter_test_task/utils/validators.dart';
import 'package:flutter_test_task/widgets/custom_snackbar.dart';
import 'package:flutter_test_task/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late AuthProvider authProvider;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final FocusNode _emailFocus = FocusNode();

  final FocusNode _passwordFocus = FocusNode();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    FocusScopeNode _currentFocus = FocusScope.of(context);
    return Scaffold(
        key: _key,
        body: SafeArea(
          child: Center(
            child: Scrollbar(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: SizedBox(
                    width: 1170,
                    child: Column(children: [
                      const SizedBox(height: 20),
                      Text('Login', style: TextStyle(fontSize: 20)),
                      const SizedBox(height: 40),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).cardColor,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 0,
                                blurRadius: 1)
                          ],
                        ),
                        child: Column(children: [
                          Row(children: [
                            Expanded(
                                flex: 1,
                                child: CustomTextField(
                                  onChanged: () {},
                                  onSubmit: () {},
                                  hintText: 'Enter your e-mail',
                                  controller: _emailController,
                                  focusNode: _emailFocus,
                                  nextFocus: _passwordFocus,
                                  inputType: TextInputType.emailAddress,
                                  prefixIcon: Icons.email,
                                  divider: false,
                                )),
                          ]),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            onChanged: () {},
                            nextFocus: FocusNode(),
                            hintText: 'Enter your password',
                            controller: _passwordController,
                            focusNode: _passwordFocus,
                            inputAction: TextInputAction.done,
                            inputType: TextInputType.visiblePassword,
                            prefixIcon: Icons.password,
                            isPassword: true,
                            onSubmit: () {},
                          ),
                        ]),
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            authProvider.login(_emailController.text.trim(),
                                _passwordController.text.trim(), _key);
                          },
                          child: Text('Login')),
                      const SizedBox(height: 30),
                      TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: const Size(1, 40),
                        ),
                        onPressed: () async {
                          Navigator.of(context)
                              .pushNamed(RouteHelper.signUpRoute);
                        },
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'New User? ',
                              style: TextStyle(
                                  fontFamily: 'Barlow',
                                  color: Theme.of(context).disabledColor)),
                          TextSpan(
                              text: 'Signup',
                              style: TextStyle(
                                  fontFamily: 'Barlow',
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color)),
                        ])),
                      )
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
