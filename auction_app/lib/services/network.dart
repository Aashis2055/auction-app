import 'package:auction_app/models/comment.dart';
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
    print(resposeData);
    Vehicle post = Vehicle.fromJson(resposeData['post']);
    List<Comment> comment = List<Comment>.from(
      resposeData['comments'].map((x)=> Comment.fromJson(x))
    );
    return {'post': post};
  }

  Future<List<Vehicle>> getPosts() async {
    Uri uri = kURI.replace(path: '/user-api/vehicle');
    http.Response response = await http.get(uri, headers: header);
    var responseData = jsonDecode(response.body);
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
    if(responseData['result'] == null){
      return <NotificationModel>[];
    }
    List<NotificationModel> notifications = List<NotificationModel>.from(
        responseData['notifications']
            .map((x) => NotificationModel.fromJson(x)));
    return notifications;
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
          return MyAlertDialog();
        });
  }

  void dispose() {
    subscription.cancel();
  }
}
