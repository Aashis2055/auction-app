import 'package:auction_app/models/vehicle_model.dart';
import 'package:auction_app/screens/ProfileScreen.dart';
import 'package:auction_app/services/network.dart';
import 'package:flutter/material.dart';
// widget
import 'package:auction_app/widgets/MyCard.dart';
class MyPosts extends StatefulWidget {
  static final String id = "my_post_screen";
  @override
  _MyPostsState createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  NetworkHelper networkHelper;
  List<Vehicle> posts;
  @override
  void initState() {
    networkHelper = NetworkHelper(context);
    super.initState();
    setUp();
  }
  setUp() async {
    await networkHelper.initState();
    List<Vehicle> myPosts = await networkHelper.getPosts();
    print(myPosts);
    if (myPosts == null) {
      return;
    } else {
      setState(() {
        posts = myPosts;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: posts == null? ProgressScreen(): 
      Column(
        children: posts.length == 0?[
          Text("You Haven't posted any thing yet"),
        ]: posts.map((post)=> MyCard(post)).toList(),
      ),
      
    );
  }
}