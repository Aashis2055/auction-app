// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
//
// class QRCodeScreen extends StatefulWidget {
//   @override
//   _QRCodeScreenState createState() => _QRCodeScreenState();
// }
//
// class _QRCodeScreenState extends State<QRCodeScreen> {
//   GlobalKey globalKey = GlobalKey();
//
//   String data = "Hello from the  other side";
//
//   String inputErrorText;
//
//   final TextEditingController textController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final bodyHeight = MediaQuery.of(context).size.height;
//     return SafeArea(
//       child: Scaffold(
//         body: Center(
//           child: Padding(
//             padding: EdgeInsets.only(
//               top: 50.0,
//               bottom: 20.0,
//               left: 15.0,
//               right: 15.0
//             ),
//             child: Container(
//               child: RepaintBoundary(
//                 key: globalKey,
//                 child: QrImage(
//                   data: data,
//                   size: 0.5 * bodyHeight,
//                   errorStateBuilder: (cxt, err){
//                     return Container(
//                       child: Text('Something went wrong', textAlign: TextAlign.center,),
//
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
