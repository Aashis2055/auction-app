import './comment.dart';
class VDe{
  VehicleDetail post;
  List<Comment> comments;
  String yId;
  VDe({this.post, this.comments, this.yId});
}
class VehicleDetail{
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
  Bid bid;
  final String addedDate;
  VehicleDetail({
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
  });
  VehicleDetail.fromJson(Map<String, dynamic> json): id = json['_id'], model = json['model'], type = json['type'], color = json['type'], initialPrice = json['initial_price'],
        img = json['img'], year = json['year'] , kmDriven = json['km_driven'].toString(), addedDate = json['added_date'],
        auctionDate = json['auction_date'], brand = json['brand'], endDate = json['end_date'],
        this.uId = json['u_id'].toString(),
        bid = json['bid'] == null ? null :Bid.fromJson(json['bid']);
}

class Bid{
  String price;
  String uID;
  Bid.fromJson(Map<String, dynamic> json): price = json['price'].toString(), uID = json['u_id'];
}
