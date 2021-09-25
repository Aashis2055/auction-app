// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_khalti/flutter_khalti.dart';
// import 'package:frontend_ui/Controllers/checkoutController.dart';
// import 'package:frontend_ui/models/routesArgs.dart';
// import 'package:frontend_ui/views/MainComponents/reusableComponents.dart';
// import 'package:frontend_ui/views/checkoutScreen/components/paymentContent.dart';
// import 'package:frontend_ui/views/checkoutScreen/components/reviewContent.dart';
// import 'package:frontend_ui/views/checkoutScreen/components/reviewOrder.dart';
// import 'package:frontend_ui/views/confirmOrder/confirmOrder.dart';
// import 'package:line_icons/line_icons.dart';
// import 'package:provider/provider.dart';
//
// class CheckoutReview extends StatelessWidget {
//   const CheckoutReview({Key? key}) : super(key: key);
//   static String route = "checkoutReview";
//
//   Widget build(BuildContext context) {
//     final args =
//         ModalRoute.of(context)!.settings.arguments as AddressAndPayment;
//     String addId = args.addressId;
//     String payType = args.paymentType;
//     print(payType);
//     // print(args.paymentType) ;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.purple,
//         title: Text("Checkout"),
//         leading: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(LineIcons.arrowLeft),
//         ),
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(65),
//           child: Container(
//             color: Colors.white,
//             padding: EdgeInsets.all(12),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Spacer(),
//                 checkoutTopIcon("1", "Shipping", Colors.purple.shade400),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 checkoutTopIcon("2", "Payment", Colors.purple.shade400),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 checkoutTopIcon("3", "Review", Colors.purple.shade400),
//                 Spacer(),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: ReviewContent(addressId: addId),
//       ),
//       bottomNavigationBar:
//           checkoutBottomAppBar(context, "Checkout", 105.0, LineIcons.check, () {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) => alertDialogGlobal(
//             context,
//             "Proceed to Checkout?",
//             () {
//               if (payType != "Payment.COD") {
//                 _payViaKhalti() async {
//                   FlutterKhalti _flutterKhalti = FlutterKhalti.configure(
//                     publicKey:
//                         "test_public_key_d10a910c30ac47b3b842dc83e4521bb9",
//                     urlSchemeIOS: "KhaltiPayFlutterExampleScheme",
//                     paymentPreferences: [
//                       KhaltiPaymentPreference.KHALTI,
//                     ],
//                   );
//
//                   KhaltiProduct product = KhaltiProduct(
//                     id: "test",
//                     amount: 1000,
//                     name: "Hello Product",
//                   );
//                   _flutterKhalti.startPayment(
//                     product: product,
//                     onSuccess: (data) {
//                       print("HEre is khalti data");
//                       print(data);
//                       ScaffoldMessenger.of(context)
//                           .showSnackBar(SnackBar(content: Text("Successful")));
//                       Navigator.pushNamed(context, ConfirmedOrder.route, arguments: );
//                     },
//                     onFaliure: (error) {
//                       print("Here is khalti error");
//                       print(error);
//                       ScaffoldMessenger.of(context)
//                           .showSnackBar(SnackBar(content: Text("failed")));
//                     },
//                   );
//                 }
//                 _payViaKhalti();
//               } else {
//                 Navigator.pushNamed(context, ConfirmedOrder.route);
//               }
//             },
//           ),
//         );
//       }),
//     );
//   }
// }