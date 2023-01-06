import 'package:flutter/material.dart';
import 'package:flutter_test_task/helpers/routes.dart';
import 'package:flutter_test_task/providers/auth_providers.dart';
import 'package:flutter_test_task/providers/car-providers.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  late AuthProvider authProvider;
  List currentUser = [];
  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    //here we check if the user has already logged in or not
    authProvider.getCurrentUser().then((value) {
      if (value != null) {
        currentUser = value;
      }
    }).then((_) {
      if (currentUser.isNotEmpty) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouteHelper.userDashboard, (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouteHelper.loginRoute, (Route<dynamic> route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Image.asset('assets/logo.png', width: 200),
            const SizedBox(height: 10),
            const Text('Welcome',
                style: TextStyle(fontWeight: FontWeight.w500),
                textAlign: TextAlign.center),
          ]),
        ),
      ),
    );
  }
}
