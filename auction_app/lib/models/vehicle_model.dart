class Vehicle{
  int id;
  final String type;
  String model = "";
  String color = "";
  int initial_Price = 0;
  String img = "images/avatar-ninja.png";
  Vehicle({
    this.type,
    this.initial_Price,
    this.color,
    this.model
  });
  Vehicle.fromJson(Map<String, dynamic> json): id = json['_id'], model = json['model'], type = json['type'], color = json['type'], initial_Price = json['initial_price'];
}