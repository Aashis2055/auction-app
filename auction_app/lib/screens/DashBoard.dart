import 'package:auction_app/screens/EstimateScreen.dart';
import 'package:auction_app/screens/MyPostScreen.dart';
import 'package:auction_app/screens/fragments/UpcomingScreen.dart';
import 'package:flutter/material.dart';
// screens
import 'package:auction_app/screens/LoginScreen.dart';
import 'package:auction_app/screens/ProfileScreen.dart';
import 'package:auction_app/screens/UploadScreen.dart';
import 'package:auction_app/screens/fragments/VehicleFrag.dart';
//models
// widgets
import 'fragments/NotificationFrag.dart';
import 'package:auction_app/widgets/FilterBox.dart';
//
import 'package:auction_app/services/storage.dart';

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

  List<Widget> _kTabPages;
  static const _kTabIcons = <Tab>[
    Tab(
      icon: Icon(Icons.home_outlined),
      text: 'Home',
    ),
    Tab(
      icon: Icon(
        Icons.explore,
      ),
      text: 'Explore',
    ),
    Tab(
      icon: Icon(Icons.notifications),
      text: 'Notification',
    )
  ];

  @override
  void initState() {
    super.initState();
    _kTabPages = <Widget>[VehiclesFrag(), UpcomingScreen(), NotificationFrag()];
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
  // function to get range values from filterbox
  void filterContent(RangeValues rangeValues){
    print('range value');
    print(rangeValues.end);
    print(rangeValues.start);
  }
  // // function to show the filter dialog
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
          
          title: Text('Vehicle Auction'),
          actions: [
            PopupMenuButton(
              onSelected: (choice) {},
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
                          // TODO something here
                        }
                      }),
                ].map((choice) {
                  return PopupMenuItem(
                    value: choice,
                    child: TextButton(onPressed: (){
                      choice.callback();
                    }, child: Text(choice.title),),
                    // child: Text(choice.title),

                  );
                }).toList();
              },
            )
          ],
        ),
        drawer: Drawer(
          child: SingleChildScrollView( child:Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: CircleAvatar(
                radius: 20,
                child: Image.asset('images/avatar-ninja.png'),
              ),
              ),
              ListTile(leading: Icon(Icons.account_circle),
                title: Text("Profile"),
                onTap: (){
                  Navigator.pushNamed(context, ProfileFrag.id);
                },
              ),
              ListTile(
                leading: Icon(Icons.car_rental),
                title: Text("My Posts"),
                onTap: (){
                  Navigator.pushNamed(context, MyPosts.id);
                },
              ),
              ListTile(
                leading: Icon(Icons.upload),
                title: Text("Upload "),
                onTap: (){
                  Navigator.pushNamed(context, UploadScreen.id);
                }
              ),
              ListTile(
                leading: Icon(Icons.monetization_on),
                title: Text("Estimate"),
                onTap: (){
                  Navigator.pushNamed(context, EstimateScreen.id);
                },
              ),
              const Divider(height: 20, thickness: 3,),
              ListTile(
                leading: Icon(Icons.info),
                title: Text("About US"),
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Exit App"),
                onTap: (){
                  Navigator.pop(context);
                },
              )
            ],
          ),
        )),
        body: TabBarView(
          controller: _tabController,
          children: _kTabPages,
        ),
        floatingActionButton: _currentIndex == 1
            ? FloatingActionButton(
                child: Icon(Icons.grid_on_rounded),
                onPressed: () {
                    showModalBottomSheet(
                      context: context, builder: (context) => FilterBox(filterContent));
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
        child: GestureDetector(
        child:Column(
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
          onTap: (){
            // choice.callback;
          },
        )
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
