import 'package:flutter_test_task/helpers/routes.dart';
import 'package:flutter_test_task/models/car_model.dart';
import 'package:flutter_test_task/providers/car-providers.dart';
import 'package:flutter_test_task/screens/updateCar.dart';
import 'package:provider/provider.dart';
import 'package:sembast/sembast.dart';
import 'package:flutter/material.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  late CarsProvider carProvider;
  List<Car> allCars = [];
  bool _isLoading = true;
  @override
  void didChangeDependencies() async {
    //instantiated the car provider
    carProvider = Provider.of<CarsProvider>(context, listen: false);
    //fetching all the cars currently registered
    allCars = await carProvider.getAllCars().whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('User Dashboard'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RouteHelper.registerCar);
                  },
                  child: Text('Register a car')),
            ),
          ),
          allCars.isNotEmpty
              ? _isLoading
                  ? CircularProgressIndicator()
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: allCars.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Material(
                                color: Color.fromARGB(255, 210, 200, 200),
                                elevation: 2,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('Name: ${allCars[index].carName}'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('Make: ${allCars[index].make}'),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text('Model: ${allCars[index].model}'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                            'Registration-no: ${allCars[index].regNo}'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateCar(
                                                    carMake:
                                                        allCars[index].make ??
                                                            '',
                                                    carModel:
                                                        allCars[index].model ??
                                                            '',
                                                    carName: allCars[index]
                                                            .carName ??
                                                        '',
                                                    registrationNo:
                                                        allCars[index].regNo ??
                                                            '',
                                                    id: allCars[index].id ?? 1,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text('Update')),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              // final car = Car(
                                              //     carName:
                                              //         allCars[index].carName,
                                              //     make: allCars[index].make,
                                              //     model: allCars[index].model,
                                              //     regNo: allCars[index].regNo);
                                              carProvider
                                                  .deleteCar(allCars[index].id)
                                                  .then((_) => Navigator.of(
                                                          context)
                                                      .pushNamedAndRemoveUntil(
                                                          RouteHelper
                                                              .userDashboard,
                                                          (Route<dynamic>
                                                                  route) =>
                                                              false));
                                            },
                                            child: Text('Delete')),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })),
                    )
              : Text('No cars registered yet'),
        ],
      ),
    ));
  }
}
