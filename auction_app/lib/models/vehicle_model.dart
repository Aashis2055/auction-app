class Vehicle{
  String id;
  String uId;
  final String type;
  String model = "";
  String color = "";
  int initial_Price = 0;
  Bid bid;
  String img;
  int year;
  String kmDriven;
  String brand;
  String endDate;
  String auctionDate;
  String addedDate;
  Vehicle({
    this.type,
    this.initial_Price,
    this.color,
    this.model,
    this.bid,
    this.img,
    this.year,
    this.kmDriven,
    this.addedDate,
    this.auctionDate,
    this.brand,
    this.endDate,
    this.id,
    this.uId
  });
  Vehicle.fromJson(Map<String, dynamic> json): id = json['_id'], model = json['model'], type = json['type'], color = json['type'], initial_Price = json['initial_price'],
        img = json['img'], year = json['year'] , kmDriven = json['km_driven'].toString(), addedDate = json['added_date'],
        auctionDate = json['auction_date'], brand = json['brand'], endDate = json['end_date'],
        uId = json['u_id'].toString(),
        bid = json['bid'] == null ? null :Bid.fromJson(json['bid']);
}
class Bid{
  String price;
  String u_id;
  Bid.fromJson(Map<String, dynamic> json): price = json['price'].toString(), u_id = json['u_id'];
}