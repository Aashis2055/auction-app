import 'package:auction_app/models/notification.dart';
String getNotificationText(NotificationModel notification){
  String type = notification.type;
  if(type == "Sold") return "You Bought a vehicle";
  else if(type == "Bought") return "You Bought a vehicle";
  else if(type == "Fail") return "You vehicle was not sold";
  else if(type == "Bid") return "some one bid on your vehicle";
  else if(type == "empty") return "No message";
  else return "";
}