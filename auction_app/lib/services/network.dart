import 'package:auction_app/constants.dart';
import 'package:auction_app/services/storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:auction_app/models/user.dart';
import 'package:auction_app/models/vehicle_model.dart';

class NetworkHelper {
  StorageHelper storage;
  Map<String, String> header;
  NetworkHelper(){
    storage = StorageHelper();
    initState();
  }
  void initState() async{
    String token = await storage.getToken();
    header = {
      'authorization': token
    };
  }
  Future<User> getProfile() async {
    Uri uri = kURI.replace(path: '/user-api/');
    
    http.Response response = await http.get(uri, headers: header);
    if (response.statusCode == 200) {
      var responsedata = jsonDecode(response.body);
      User user = User.fromJson(responsedata);
    }else{
      return null;
    }
  }
  Future<Vehicle> getPost(String id) async{

  }
  Future<List<Vehicle>> getPosts() async{
    Uri uri = kURI.replace(path: '/user-api/vehicle');
    http.Response response = await http.get(uri, headers: header)
  }
}
