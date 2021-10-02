import 'package:auction_app/constants.dart';
import 'package:auction_app/models/vehicle_model.dart';
import 'package:flutter/material.dart';
// screens
//widgets
import 'package:auction_app/models/user.dart';
import 'package:auction_app/services/network.dart';

// class ProfileFrag extends StatefulWidget {
//   static final  String id= "profile_screen";
//   @override
//   _ProfileFragState createState() => _ProfileFragState();
// }
//
// class _ProfileFragState extends State<ProfileFrag> {
//   User user;
//   List<Vehicle> posts = [];
//   NetworkHelper networkHelper;
//   @override
//   void initState() {
//     super.initState();
//     networkHelper = NetworkHelper(context);
//     setUp();
//   }
//
//   setUp() async {
//     await networkHelper.initState();
//     Map data = await networkHelper.getProfile();
//     if (data['user'] == null) {
//       return;
//     } else {
//       setState(() {
//         user = data['user'];
//         posts = data['posts'];
//       });
//       print(user.firstName);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//        body: SingleChildScrollView(
//         child: user == null
//             ? ProgressScreen()
//             : Column(
//                 children: [
//                   Image.network('http://$kIP:5000/profile-image/${user.img}'),
//                   Text('User Detail'),
//                   Text('name'),
//                   Text('Name: ${user.firstName}'),
//                   Text('Last Name: ${user.lastName}'),
//                   Text('Email: ${user.email}'),
//                   Text('Phone No: ${user.phoneNo}'),
//                   !user.status
//                       ? Text(
//                           'Status: Active',
//                           style: TextStyle(backgroundColor: Colors.green),
//                         )
//                       : Text(
//                           'Status: Inactive',
//                           style: TextStyle(backgroundColor: Colors.red),
//                         ),
//                 ],
//               ),
//         )
//       ),
//     );
//   }
// }

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [CircularProgressIndicator(), Text('Loading ...')],
        ),
      ),
    );
  }
}

class ProfileFrag extends StatefulWidget {
  static final String id = "profile_screen";
  @override
  _ProfileFragState createState() => _ProfileFragState();
}

class _ProfileFragState extends State<ProfileFrag> {
  User user;
  List<Vehicle> posts = [];
  NetworkHelper networkHelper;
  @override
  void initState() {
    super.initState();
    networkHelper = NetworkHelper(context);
    setUp();
  }

  setUp() async {
    await networkHelper.initState();
    Map data = await networkHelper.getProfile();
    if (data['user'] == null) {
      return;
    } else {
      setState(() {
        user = data['user'];
        posts = data['posts'];
      });
      print(user.firstName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child:
            user == null
                ? ProgressScreen()
                :
            Column(
              children: [
                Stack(
                  children: [
                    ClipPath(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(
                                Colors.purple.withOpacity(0.6), BlendMode.srcATop),
                            image: NetworkImage(
                              'https://avatars.dicebear.com/api/initials/${user.firstName}-${user.lastName}.svg',
                            ),
                          ),
                        ),
                      ),
                      clipper: CustomClipPath(),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 40,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 8, color: Colors.white),
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: new NetworkImage(
                                'http://$kIP:5000/profile-image/${user.img}'
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 45,
                      bottom: 9,
                      child: Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: Colors.grey),
                          color: Colors.green.shade700,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 15,
                      bottom: 0,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text('${user.firstName} ${user.lastName}',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            )),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.email,
                      color: Colors.purple,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      user.email,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.phone,
                      color: Colors.purple,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      user.phoneNo.toString(),
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.phone,
                      color: Colors.purple,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      !user.status ? "Active": "Inactive",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.home_filled,
                      color: Colors.purple,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '${user.location.province}',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.home_filled,
                      color: Colors.purple,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '${user.location.district}',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}



class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(
        0, size.height - 70); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 1.5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width - 50, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart = Offset(size.width - (size.width / 3), size.height);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}