import 'package:auction_app/models/vehicle_status.dart';
import 'package:auction_app/models/vehicle_model.dart';
import 'package:flutter/material.dart';
VehicleStatus getVehicleStatus(Vehicle vehicle){
  DateTime auctionDate = DateTime.parse(vehicle.auctionDate);
  DateTime endDate = DateTime.parse(vehicle.endDate);
  DateTime initDate = DateTime.parse(vehicle.addedDate);
  DateTime currentDate = DateTime.now();
  if(currentDate.isAfter(auctionDate) && currentDate.isBefore(endDate)) return VehicleStatus.active;
  else if(currentDate.isAfter(endDate)) return VehicleStatus.ended;
  else if(currentDate.isBefore(initDate)) return VehicleStatus.upcoming;
  else return VehicleStatus.none;
}

Text getVehicleStatusText(Vehicle vehicle){
  VehicleStatus status = getVehicleStatus(vehicle);
  if(status == VehicleStatus.active) return Text('Ongoing', style: TextStyle(backgroundColor: Colors.green),);
  else if(status == VehicleStatus.ended) return Text('Ended', style: TextStyle(backgroundColor: Colors.grey),);
  else if(status == VehicleStatus.upcoming) return Text('Upcoming', style: TextStyle(backgroundColor: Colors.yellow),);
  else return Text('Error', style: TextStyle(backgroundColor: Colors.red),);
}