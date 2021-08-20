import 'package:auction_app/screens/LoginScreen.dart';
import 'package:auction_app/services/storage.dart';
import 'package:auction_app/widgets/FilterBox.dart';
import 'package:flutter/material.dart';
// screens
import 'package:auction_app/screens/ProfileFrag.dart';
import 'package:auction_app/screens/UploadScreen.dart';
import 'package:auction_app/screens/VehicleFrag.dart';
import 'NotificationFrag.dart';

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

  final _kTabPages = <Widget>[ProfileFrag(), VehiclesFrag(), NotificationFrag()];
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
      icon: Icon(Icons.notifications),
      text: 'Notification',
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
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  void filterContent(RangeValues rangeValues){
    
  }
  // function to show the filter dialog
  // Future<void> _displayTextInputDialog( context)async{
  //   return showDialog(
  //     context: context, 
  //     builder: (context){
  //       return FilterBox(filterContent);
  //     });
  // }
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
                onPressed: () {
                  showModalBottomSheet(
                      context: context, builder: (context) => FilterBox(filterContent));
                }),
            IconButton(icon: Icon(Icons.apps_sharp), onPressed: () {

            }),
            PopupMenuButton(
              onSelected: (choice) {
              },
              itemBuilder: (BuildContext context) {
                return <Choice>[
                  Choice(
                      title: 'Logout',
                      icon: Icons.logout,
                      callback: () async {
                        StorageHelper storageHelper = StorageHelper();
                        bool isLoggedout = await storageHelper.removeToken();
                        if (isLoggedout) {
                          Navigator.pushNamed(context, LoginScreen.id);
                        } else {
                          print('logout error');
                        }
                      }),
                  // Choice(
                  //     title: 'Settings',
                  //     icon: Icons.settings,
                  //     callback: () {
                  //       print('TODO settings');
                  //     }),
                  // Choice(
                  //     title: 'About Us',
                  //     icon: Icons.info,
                  //     callback: () {
                  //     })
                ].map((choice) {
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
                  Navigator.pushNamed(context, UploadScreen.id);
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
