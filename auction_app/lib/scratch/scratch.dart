// import 'package:dio/dio.dart';
// void getHttp() async {
//   try {
//     var response = await Dio().get('http://www.google.com');
//     print(response);
//   } catch (e) {
//     print(e);
//   }
// }

// import 'package:socket_io_client/socket_io_client.dart' as IO;

// main() {
//   // Dart client
//   IO.Socket socket = IO.io('http://localhost:3000');
//   socket.onConnect((_) {
//     print('connect');
//     socket.emit('msg', 'test');
//   });
//   socket.on('event', (data) => print(data));
//   socket.onDisconnect((_) => print('disconnect'));
//   socket.on('fromServer', (_) => print(_));
// }
// IO.Socket socket = IO.io('http://localhost:3000',
//   OptionBuilder()
//       .setTransports(['websocket']) // for Flutter or Dart VM
//       .setExtraHeaders({'foo': 'bar'}) // optional
//       .build());
// import 'dart:async';

// // STEP1:  Stream setup
// class StreamSocket{
//   final _socketResponse= StreamController<String>();

//   void Function(String) get addResponse => _socketResponse.sink.add;

//   Stream<String> get getResponse => _socketResponse.stream;

//   void dispose(){
//     _socketResponse.close();
//   }
// }

// StreamSocket streamSocket =StreamSocket();

// //STEP2: Add this function in main function in main.dart file and add incoming data to the stream
// void connectAndListen(){
//   IO.Socket socket = IO.io('http://localhost:3000',
//       OptionBuilder()
//        .setTransports(['websocket']).build());

//     socket.onConnect((_) {
//      print('connect');
//      socket.emit('msg', 'test');
//     });

//     //When an event recieved from server, data is added to the stream
//     socket.on('event', (data) => streamSocket.addResponse);
//     socket.onDisconnect((_) => print('disconnect'));

// }

// //Step3: Build widgets with streambuilder

// class BuildWithSocketStream extends StatelessWidget {
//   const BuildWithSocketStream({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: StreamBuilder(
//         stream: streamSocket.getResponse ,
//         builder: (BuildContext context, AsyncSnapshot<String> snapshot){
//           return Container(
//             child: snapshot.data,
//           );
//         },
//       ),
//     );
//   }
// }
