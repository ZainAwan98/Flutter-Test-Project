import 'package:flutter/material.dart';
import 'package:flutter_test_task/helpers/routes.dart';
import 'package:flutter_test_task/providers/auth_providers.dart';
import 'package:flutter_test_task/providers/car-providers.dart';
import 'package:flutter_test_task/screens/register_car.dart';
import 'package:flutter_test_task/screens/sign_in.dart';
import 'package:flutter_test_task/screens/sign_up.dart';
import 'package:flutter_test_task/screens/splash_screen.dart';
import 'package:flutter_test_task/screens/updateCar.dart';
import 'package:flutter_test_task/screens/user_dashboard.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    List currentUser = [];
    return MultiProvider(
      providers: [
        //here are all the providers
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<CarsProvider>(
          create: (_) => CarsProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),

        //all the routes are defined here
        routes: {
          RouteHelper.signUpRoute: (context) => SignupScreen(),
          RouteHelper.loginRoute: (context) => SignInScreen(),
          RouteHelper.userDashboard: (context) => const UserDashboard(),
          RouteHelper.registerCar: (context) => RegisterCar(),
        },
      ),
    );
  }
}
