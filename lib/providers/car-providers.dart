import 'package:flutter/cupertino.dart';
import 'package:flutter_test_task/models/car_model.dart';
import 'package:sembast/sembast.dart';

import '../helpers/database.dart';

class CarsProvider extends ChangeNotifier {
  static const String folderName = "Cars";
  final _carsFolder = intMapStoreFactory.store(folderName);

  Future<Database> get _db async => await AppDatabase.instance.database;

  //funtion to create a new car
  Future createCar(Car cars) async {
    await _carsFolder.add(await _db, cars.toJson());
  }

  //funtion to update car details
  Future updateCarDetails(Car cars, id) async {
    final finder = Finder(filter: Filter.byKey(id));
    await _carsFolder.update(await _db, cars.toJson(), finder: finder);
  }

  //funtion to delete car details
  Future deleteCar(id) async {
    final finder = Finder(filter: Filter.byKey(id));
    await _carsFolder.delete(await _db, finder: finder);
  }

  //funtion to get all cars details
  Future<List<Car>> getAllCars() async {
    final recordSnapshot = await _carsFolder.find(await _db);
    return recordSnapshot.map((snapshot) {
      final cars = Car.fromJson(snapshot.value);
      cars.id = snapshot.key;
      return cars;
    }).toList();
  }
}
