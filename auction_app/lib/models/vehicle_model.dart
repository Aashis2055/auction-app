class Vehicle{
  String id;
  final String type;
  String model = "";
  String color = "";
  int initial_Price = 0;
  Bid bid;
  String img = "images/avatar-ninja.png";
  Vehicle({
    this.type,
    this.initial_Price,
    this.color,
    this.model,
    this.bid
  });
  Vehicle.fromJson(Map<String, dynamic> json): id = json['_id'], model = json['model'], type = json['type'], color = json['type'], initial_Price = json['initial_price'], bid = Bid.fromJson(json['bid']);
}
class Bid{
  int price;
  String u_id;
  Bid.fromJson(Map<String, dynamic> json): price = json['price'], u_id = json['u_id'];
}