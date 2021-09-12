import 'dart:io';

import 'package:auction_app/models/comment.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
// widgets
import 'package:auction_app/widgets/alert_dialog.dart';
// models
import 'package:auction_app/models/user.dart';
import 'package:auction_app/models/vehicle_model.dart';
import 'package:auction_app/models/notification.dart';
//
import 'package:auction_app/services/storage.dart';
import 'package:auction_app/constants.dart';

class NetworkHelper {
  StorageHelper storage;
  Map<String, String> header;
  StreamSubscription<ConnectivityResult> subscription;
  var context;
  final Connectivity _connectivity = Connectivity();
  NetworkHelper(this.context) {
    storage = StorageHelper();
    initState();
  }
  Future<void> initState() async {
    String token = await storage.getToken();
    header = {'authorization': token};
    subscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<Map<String, dynamic>> getProfile() async {
    Uri uri = kURI.replace(path: '/user-api/');
    http.Response response = await http.get(uri, headers: header);
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      User user = User.fromJson(responseData['user']);
      responseData['posts'].map((element){
        print(element['bid'].toString());
      });
      List<Vehicle> posts = List<Vehicle>.from(
          responseData['posts'].map((x) => Vehicle.fromJson(x)));
      return {'user': user, 'posts': posts};
    } else {
      print('error');
      return null;
    }
  }

  Future<Map<String, dynamic>> getPost(String id) async {
    Uri uri = kURI.replace(path: '/user-api/vehicle/$id');
    http.Response response = await http.get(uri, headers: header);
    Map<String, dynamic> resposeData = jsonDecode(response.body);
    Vehicle post = Vehicle.fromJson(resposeData['post']);
    List<Comment> comment = List<Comment>.from(
      resposeData['comments'].map((x)=> Comment.fromJson(x))
    );
    print(comment);
    return {'post': post, 'comment': comment};
  }

  Future<List<Vehicle>> getPosts() async {
    print('inside the posts method');
    Uri uri = kURI.replace(path: '/user-api/vehicle');
    http.Response response = await http.get(uri, headers: header);
    var responseData = jsonDecode(response.body);
    print('here');
    print(responseData);
    List<Vehicle> posts = List<Vehicle>.from(
        responseData['posts'].map((x) => Vehicle.fromJson(x)));
    return posts;
  }

  Future<List<NotificationModel>> getNotifications() async {
    Uri uri = kURI.replace(path: '/user-api/notifications');
    http.Response response = await http.get(uri, headers: header);
    var responseData = jsonDecode(response.body);
    print(responseData);
    if(responseData['notifications'] == null){
      return <NotificationModel>[];
    }
    List<NotificationModel> notifications = List<NotificationModel>.from(
        responseData['notifications']
            .map((x) => NotificationModel.fromJson(x)));
    return notifications;
  }
  Future<String> getPrediction(model, year, brand, kmDriven) async{
    Uri uri = kURI.replace(path: '/user-api/prediction', queryParameters: {
      'model': model,
      'year': year,
      'brand': brand,
      'km_driven': kmDriven
    });
    http.Response response = await http.get(uri, headers: header );
    return response.body;

  }
  Future<bool> postProduct(FormData formData) async {
    var dio = Dio();
      // dio.options.headers['content-Type'] =
      dio.options.headers['authorization'] = "token";
      var response =
          await dio.post("http://$kIP:5000/user-api/vehicle", data: formData);
      if (response.statusCode == 200) {
        Navigator.pop(context);
        return true;
      } else {
        print('error in image upload');
        return false;
      }
  }
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      showMyAlertDialog();
    }
  }
  
  void showMyAlertDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyAlertDialog("Check Internet Connection");
        });
  }

  void dispose() {
    subscription.cancel();
  }
}
