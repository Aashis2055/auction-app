import 'package:auction_app/constants.dart';
import 'package:auction_app/models/vehicle_model.dart';
import 'package:auction_app/screens/DetailScreen.dart';
import 'package:flutter/material.dart';
// class MyCard extends StatelessWidget {
//   final Vehicle vehicle;
//   MyCard(this.vehicle);
//   Widget build(BuildContext context) {
//     // print(productImages);
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: Material(
//         child: InkWell(
//           // onTap: () => Navigator.pushNamed(context, ProductDetails.routeName,
//           //     arguments: productsAttributes.id),
//           onTap: ()=> Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => DetailScreen(vehicle.id))),
//           child: Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(6),
//             ),
//             child: Column(
//               children: [
//                 Column(
//                   children: [
//                     Stack(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(2),
//                           child: Container(
//                               width: double.infinity,
//                               height: MediaQuery
//                                   .of(context)
//                                   .size
//                                   .height * .6,
//                               child: Image.network(
//                                   "http://$kIP:5000/vehicle-images/"+vehicle.img,
//                                   fit: BoxFit.fill)),
//                         ),
//                         Positioned(
//                           top: 10,
//                           left: 0,
//                           child: AnimatedContainer(
//                             duration: Duration(milliseconds: 500),
//                             curve: Curves.easeInBack,
//                             decoration: BoxDecoration(
//                                 color: Colors.grey,
//                                 borderRadius: BorderRadius.only(
//                                     topRight: Radius.circular(20),
//                                     bottomRight: Radius.circular(20))),
//                             padding: EdgeInsets.all(12),
//                             child: Text(
//                               vehicle.brand,
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           right: 0,
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: Colors.grey,
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(20))),
//                             padding: EdgeInsets.all(12),
//                             child: Text(
//                               "Status",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(left: 8,),
//                   margin: EdgeInsets.only(left: 5, bottom: 2, right: 3),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         vehicle.brand,
//                         maxLines: 1,
//                         style: TextStyle(
//                             fontSize: 22.0, fontWeight: FontWeight.bold),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             vehicle.color,
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.purple,
//                                 fontSize: 18),
//                           ),
//                           // Spacer(flex: 1,),
//                           Material(
//                             color: Colors.transparent,
//                             child: Padding(
//                                 padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
//                                 child: Text(
//                                     vehicle.year.toString()
//                                 )
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


class MyCard extends StatelessWidget {
  final Vehicle vehicle;
  static const height = 360.0;
  MyCard(this.vehicle);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          child: Column(
            children: [
              Image.network(kURI.toString()+"/vehicle-images/"+vehicle.img),
        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            vehicle.color,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                                fontSize: 18),
                          ),
                          // Spacer(flex: 1,),
                          Material(
                            color: Colors.transparent,
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                                child: Text(
                                    vehicle.year.toString()
                                )
                            ),
                          )
                        ],
                      )
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailScreen(vehicle.id)));
          },
          splashColor: Colors.blue,
        ),
      ),
    );
  }
}
