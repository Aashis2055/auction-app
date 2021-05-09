import 'package:flutter/material.dart';
// screens
import 'package:auction_app/screens/ProfileFrag.dart';
import 'package:auction_app/screens/UploadModal.dart';
import 'package:auction_app/screens/VehicleFrag.dart';
import 'ChatFrag.dart';

// widgets
class DashBoard extends StatefulWidget {
  static String id = 'dashboard_screen';
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _currentIndex = 1;

  // static const _kTabPages = <Widget>[
  //   ProfileFrag(),
  // ]
  final _kTabPages = <Widget>[ProfileFrag(), VehiclesFrag(), ChatFrag()];
  static const _kTabIcons = <Tab>[
    Tab(
      icon: Icon(Icons.account_circle_outlined),
      text: 'Profile',
    ),
    Tab(
      icon: Icon(
        Icons.home_outlined,
      ),
      text: 'Home',
    ),
    Tab(
      icon: Icon(Icons.chat),
      text: 'Chat',
    )
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _kTabPages.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
      print(_currentIndex);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: CircleAvatar(
            child: Image.asset('images/avatar-ninja.png'),
          ),
          title: Text('Vehicle Auction'),
          actions: [
            IconButton(
                icon: Icon(Icons.power_settings_new_outlined), onPressed: () {})
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: _kTabPages,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, UploadModal.id);
          },
        ),
        bottomNavigationBar: Material(
          color: Colors.blueGrey,
          child: TabBar(
            tabs: _kTabIcons,
            controller: _tabController,
          ),
        ),
      ),
    );
  }
}
