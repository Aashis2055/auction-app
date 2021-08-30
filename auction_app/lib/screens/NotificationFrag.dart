import 'package:auction_app/screens/ProfileFrag.dart';
import 'package:auction_app/services/network.dart';
import 'package:flutter/material.dart';
// models
import 'package:auction_app/models/notification.dart';
// widget
import 'package:auction_app/widgets/NotificationTile.dart';
import 'package:auction_app/utils/notification-text.dart';

class NotificationFrag extends StatefulWidget {
  @override
  _NotificationFragState createState() => _NotificationFragState();
}

class _NotificationFragState extends State<NotificationFrag> {
  NetworkHelper networkHelper;
  List<NotificationModel> notification = <NotificationModel>[];
  @override
  void initState() {
    super.initState();
    networkHelper = NetworkHelper(context);
    setUp();
  }

  setUp() async {
    await networkHelper.initState();
    List<NotificationModel> myNotifications =
        await networkHelper.getNotifications();
    if (myNotifications == null) {
      return;
    } else {
      setState(() {
        notification = myNotifications;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(notification);
    return Container(
        child: notification == null? ProgressScreen() :Column(
          children: notification.length == 0? [
            Text('No Notification to Show')
          ]:notification.map((e) => NotificationTile(e, getNotificationText(e))).toList(),
        )
    //     ListView.builder(
    //   itemBuilder: (builder, index) {
    //     return NotificationTile(notification[index], getNotificationText(notification[index]));
    //   },
    // )
    );
  }
}
