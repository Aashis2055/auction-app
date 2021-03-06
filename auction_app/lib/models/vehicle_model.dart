import './user.dart';
class Vehicle{
  String id;
  String uId;
  final String type;
  String model = "";
  String color = "";
  int initialPrice = 0;
  String img;
  int year;
  String kmDriven;
  String brand;
  String endDate;
  String auctionDate;
  final String addedDate;
  UserLocation location;
  Vehicle({
    this.type,
    this.initialPrice,
    this.color,
    this.model,
    this.img,
    this.year,
    this.kmDriven,
    this.addedDate,
    this.auctionDate,
    this.brand,
    this.endDate,
    this.id,
    this.uId,
    this.location
  });
  Vehicle.fromJson(Map<String, dynamic> json): id = json['_id'], model = json['model'], type = json['type'], color = json['type'], initialPrice = json['initial_price'],
        img = json['img'], year = json['year'] , kmDriven = json['km_driven'].toString(), addedDate = json['added_date'],
        auctionDate = json['auction_date'], brand = json['brand'], endDate = json['end_date'],
        uId = json['u_id'].toString(),
        location = json['u_id'] == String ? null : UserLocation.fromJson(json['u_id']['address']);
}

