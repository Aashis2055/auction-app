import 'package:flutter/material.dart';
// screens
import 'package:auction_app/screens/ProfileFrag.dart';
import 'package:auction_app/screens/UploadModal.dart';
import 'package:auction_app/screens/VehicleFrag.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  List<Choice> choices = <Choice>[
    Choice(
        title: 'Logout',
        icon: Icons.logout,
        callback: () {
          Fluttertoast.showToast(msg: 'TODO Logout');
        }),
    Choice(
        title: 'Settings',
        icon: Icons.settings,
        callback: () {
          Fluttertoast.showToast(msg: 'TODO Settings');
        }),
    Choice(
        title: 'About Us',
        icon: Icons.info,
        callback: () {
          Fluttertoast.showToast(msg: 'TODO about us');
        })
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _kTabPages.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
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
            radius: 20,
            child: Image.asset('images/avatar-ninja.png'),
          ),
          title: Text('Vehicle Auction'),
          actions: [
            IconButton(
                icon: Icon(Icons.power_settings_new_outlined),
                onPressed: () {}),
            PopupMenuButton(
              onSelected: (choice) {
                Fluttertoast.showToast(msg: 'pop up');
              },
              itemBuilder: (BuildContext context) {
                return choices.map((choice) {
                  return PopupMenuItem(
                    value: choice,
                    child: Text(choice.title),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: _kTabPages,
        ),
        floatingActionButton: _currentIndex == 1
            ? FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, UploadModal.id);
                },
              )
            : Container(),
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

class ChoiceCard extends StatelessWidget {
  final Choice choice;
  const ChoiceCard({this.choice});
  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.headline1;
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              choice.icon,
              size: 128.0,
            ),
            Text(
              choice.title,
              style: textStyle,
            )
          ],
        ),
      ),
    );
  }
}

class Choice {
  Choice({this.title, this.icon, this.callback});
  final String title;
  final IconData icon;
  final Function callback;
}
