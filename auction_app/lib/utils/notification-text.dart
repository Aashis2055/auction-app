import 'package:flutter/material.dart';
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
Icon getNotificattionIcon(NotificationModel notification){
  String type = notification.type;
  if(type == "Sold") return Icon(Icons.check);
  else if(type == "Bought") return Icon(Icons.monetization_on_sharp);
  else if(type == "Fail") return Icon(Icons.money_off);
  else if(type == "Bid") return Icon(Icons.money_sharp);
  else if(type == "empty") return Icon(Icons.error_outline_sharp);
  else return Icon(Icons.error);
}