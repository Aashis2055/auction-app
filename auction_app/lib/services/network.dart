import 'package:auction_app/models/vehicle_detail_model.dart';
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
import 'package:auction_app/models/comment.dart';

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
      return {'user': user,};
    } else {
      print('error');
      return null;
    }
  }

  Future<VDe> getPost(String id) async {
    Uri uri = kURI.replace(path: '/user-api/vehicle/$id');
    http.Response response = await http.get(uri, headers: header);
    if(response.statusCode == 200){
      print(response.body);
      Map<String, dynamic> resposeData = jsonDecode(response.body);

      VehicleDetail post = VehicleDetail.fromJson(resposeData['post']);
      List<Comment> comment = List<Comment>.from(
          resposeData['comments'].map((x)=> Comment.fromJson(x))
      );
      print(comment);
      VDe vde = VDe(post: post, comments: comment, yId: resposeData['yId']);
      return vde;
    }else{
      return null;
    }

  }
  Future<bool> postBid(String id, int price)async{
    Uri uri = kURI.replace(path: '/user-api/bid/$id');
    print(id);
    print(price);
    http.Response response = await http.post(uri,body:{
      "price": price.toString()
    }, headers: header);

    if(response.statusCode == 200){
      return true;
    }else return false;
  }

  Future<List<Vehicle>> getPosts() async {
    Uri uri = kURI.replace(path: '/user-api/vehicle');
    http.Response response = await http.get(uri, headers: header);
    if(response.statusCode == 200){
      var responseData = jsonDecode(response.body);
      List<Vehicle> posts = List<Vehicle>.from(
          responseData['posts'].map((x) => Vehicle.fromJson(x)));
      return posts;
    }else{
      return [];
    }

  }
  Future<List<Vehicle>> getUpcomingPosts() async {
    Uri uri = kURI.replace(path: '/user-api/upcoming');
    http.Response response = await http.get(uri, headers: header);
    if(response.statusCode == 200){
      print(response.body);
      var responseData = jsonDecode(response.body);
      print(responseData['u_id']);
      if(responseData['u_id'] == String){
        print("is string");
      }else{
        UserLocation.fromJson(responseData['u_id']);
      }
      List<Vehicle> posts = List<Vehicle>.from(
          responseData['posts'].map((x) => Vehicle.fromJson(x)));
      return posts;
    }else{
      return <Vehicle>[];
    }

  }

  Future<List<Vehicle>> getUserPosts() async {
    Uri uri = kURI.replace(path: '/user-api/myPosts');
    http.Response response = await http.get(uri, headers: header);
    if(response.statusCode == 200){
      var responseData = jsonDecode(response.body);
      print(responseData);
      List<Vehicle> posts = List<Vehicle>.from(
          responseData['posts'].map((x) => Vehicle.fromJson(x)));
      return posts;
    }else{
      return <Vehicle>[];
    }

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
  Future<Map<String, dynamic>> getPrediction({String model,int year,String brand,int kmDriven, String type}) async{
    Uri uri = kURI.replace(path: '/user-api/prediction', queryParameters: {
      'model': model,
      'year': year.toString(),
      'brand': brand,
      'km_Driven': kmDriven.toString(),
      'type': type.toString()
    });
    http.Response response = await http.get(uri, headers: header );
    if(response.statusCode == 200){
      print(response.body);
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData;
    }else{
      return null;
    }
  }
  Future<List<String>> getAvailabeBrands(String type)async{
    Uri uri = kURI.replace(path: '/public/availableBrands/$type');
    http.Response response = await http.get(uri);
    if(response.statusCode == 200){
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      List<String> resultList = List<String>.from(responseBody['result'].map((x)=> x.toString()));
      return resultList;
    }else return <String>[];
  }
  Future<List<String>> getAvailableModels(String brand)async{
    Uri uri = kURI.replace(path: '/public/availableModels/$brand');
    http.Response response = await http.get(uri);
    if(response.statusCode == 200){
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      List<String> resultList = List<String>.from(responseBody['result'].map((x)=> x.toString()));
      return resultList;
    }else return <String>[];
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
  Future<bool> postComment(String comment, String id)async{
    Uri uri = kURI.replace(path: '/user-api/comment/$id',);
    http.Response response = await http.post(uri, headers: header, body: {
      'comment': comment
    });
    if(response.statusCode == 500){
      return false;
    }else{
      return true;
    }
  }
  Future<bool> postReply(String reply, String id)async{
    Uri uri = kURI.replace(path: '/user-api/reply/$id',);
    http.Response response = await http.post(uri, headers: header, body: {
      'reply': reply
    });
    if(response.statusCode == 500){
      return false;
    }else{
      return true;
    }
  }
  Future<List<Vehicle>> getWatchList()async{
    Uri uri = kURI.replace(path: '/user-api/watch');
    http.Response response = await http.get(uri, headers: header);
    if(response.statusCode == 200){
      var responseData = jsonDecode(response.body);
      List<Vehicle> posts = List<Vehicle>.from(
        responseData['posts'].map((x) => Vehicle.fromJson(x)));
      return posts;
    }else{
      return <Vehicle>[];
    }
  }
  Future<bool> addWatchList(String id) async{
    Uri uri = kURI.replace(path: '/user-api/watch/$id');
    http.Response response = await http.post(uri);
    if(response.statusCode == 201){
      return true;
    }else{
      return false;
    }
  }
  Future<bool> deleteWatchList(String id) async{
    Uri uri = kURI.replace(path: '/user-api/watch/$id');
    http.Response response = await http.delete(uri);
    if(response.statusCode == 201){
      return true;
    }else{
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

