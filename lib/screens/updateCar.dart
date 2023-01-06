import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_test_task/helpers/routes.dart';
import 'package:flutter_test_task/models/car_model.dart';
import 'package:flutter_test_task/providers/car-providers.dart';
import 'package:flutter_test_task/utils/validators.dart';
import 'package:flutter_test_task/widgets/custom_snackbar.dart';
import 'package:flutter_test_task/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class UpdateCar extends StatefulWidget {
  String carName;
  String carMake;
  String carModel;
  String registrationNo;
  int id;
  UpdateCar(
      {required this.carName,
      required this.carMake,
      required this.carModel,
      required this.registrationNo,
      required this.id});

  @override
  State<UpdateCar> createState() => _UpdateCarState();
}

class _UpdateCarState extends State<UpdateCar> {
  GlobalKey _key = GlobalKey();

  final FocusNode _carNameFocus = FocusNode();

  final FocusNode _carModelFocus = FocusNode();

  final FocusNode _carMakeFocus = FocusNode();

  final FocusNode _registrationNoFocus = FocusNode();

  final TextEditingController _carNameController = TextEditingController();

  final TextEditingController _carModelController = TextEditingController();

  final TextEditingController _carMakeController = TextEditingController();

  final TextEditingController _regisrationNumberController =
      TextEditingController();

  late CarsProvider carProvider;

  @override
  void didChangeDependencies() {
    //instantiating the car provider
    carProvider = Provider.of<CarsProvider>(context, listen: false);
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
              const Text('Update car details', style: TextStyle(fontSize: 20)),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  isPassword: false,
                  maxLines: 1,
                  inputType: TextInputType.name,
                  hintText: 'Name',
                  controller: _carNameController..text = widget.carName,
                  focusNode: _carNameFocus,
                  nextFocus: _carModelFocus,
                  onSubmit: () {},
                  onChanged: () {},
                  prefixIcon: Icons.car_crash),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  inputType: TextInputType.number,
                  hintText: 'Model',
                  controller: _carModelController..text = widget.carModel,
                  focusNode: _carModelFocus,
                  nextFocus: _carMakeFocus,
                  onSubmit: () {},
                  onChanged: () {},
                  prefixIcon: Icons.car_crash),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  hintText: 'Make',
                  controller: _carMakeController..text = widget.carMake,
                  focusNode: _carMakeFocus,
                  nextFocus: _registrationNoFocus,
                  onSubmit: () {},
                  onChanged: () {},
                  prefixIcon: Icons.car_crash),
              const SizedBox(
                height: 28,
              ),
              CustomTextField(
                  inputType: TextInputType.number,
                  hintText: 'Registration no.',
                  controller: _regisrationNumberController
                    ..text = widget.registrationNo,
                  focusNode: _registrationNoFocus,
                  nextFocus: FocusNode(),
                  onSubmit: () {},
                  onChanged: () {},
                  prefixIcon: Icons.numbers),
              const SizedBox(
                height: 28,
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () {
                    updateCar();
                  },
                  child: const Text('Update')),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //function to update the car data
  void updateCar() async {
    String _carName = _carNameController.text.trim();
    String _carMake = _carMakeController.text.trim();
    String _carModel = _carModelController.text.trim();
    String _regNo = _regisrationNumberController.text.trim();

    if (_carName.isEmpty) {
      showCustomSnackBar(context, 'Enter car name');
    } else if (_carName.length > 15) {
      showCustomSnackBar(context, "Car name can't be more than 15 characters");
    } else if (_carMake.isEmpty) {
      showCustomSnackBar(context, 'Enter car make');
    } else if (_carMake.length > 15) {
      showCustomSnackBar(context, "Car make can't be more than 15 characters");
    } else if (_carModel.isEmpty) {
      showCustomSnackBar(context, 'Enter car model');
    } else if (_carModel.length > 4) {
      showCustomSnackBar(context, "Car name can't be more than 4 characters ");
    } else if (_regNo.isEmpty) {
      showCustomSnackBar(context, 'Enter car registration number');
    } else if (_regNo.length > 20) {
      showCustomSnackBar(
          context, "Registration number can't be more than 20 characters");
    } else {
      Car _car = Car(
          carName: _carName, make: _carMake, model: _carModel, regNo: _regNo);
      carProvider.updateCarDetails(_car, widget.id).then((_) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouteHelper.userDashboard, (Route<dynamic> route) => false);
        showCustomSnackBar(context, 'Updated Successfully');
      });
    }
  }
}
