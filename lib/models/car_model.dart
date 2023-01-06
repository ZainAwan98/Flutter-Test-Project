class Car {
  int? id;
  String? carName;
  String? model;
  String? make;
  String? regNo;

  Car(
      {required this.carName,
      required this.model,
      required this.make,
      required this.regNo});

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carName = json['carName'];
    model = json['model'];
    make = json['make'];
    regNo = json['regNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['carName'] = carName;
    data['model'] = model;
    data['make'] = make;
    data['regNo'] = regNo;
    return data;
  }
}
