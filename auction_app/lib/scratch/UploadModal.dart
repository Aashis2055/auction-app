import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

// import 'package:dio/dio.dart';
// import 'package:path/path.dart';
// import 'package:flutter/widgets.dart';
//
class UploadModal extends StatefulWidget {
  static String id = "upload_modal";
  @override
  _UploadModalState createState() => _UploadModalState();
}

class _UploadModalState extends State<UploadModal> {
//   File selectedfile;
//   Response response;
//   String progress;
//   Dio dio = new Dio();
//   String uploadurl = "http://";
//
//   selectFile() async {
//     FilePickerResult result = await FilePicker.platform
//         .pickFiles(type: FileType.custom, allowedExtensions: ['png', 'jpg']);
//     if (result != null) {
//       selectedfile = File(result.files.single.path);
//    print(file.name);
//    print(file.bytes);
//    print(file.size);
//    print(file.extension);
//    print(file.path);
//     }
//   }
  // selectMultipleFiles() async {
  //   FilePickerResult result =
  //       await FilePicker.platform.pickFiles(allowMultiple: true);
  //   if (result != null) {
  //     List<File> files = result.paths.map((path) => File(path)).toList();
  //   }else{
  //     // show error
  //   }
  // }

//   uploadFile() async {
//     FormData formData = FormData.fromMap({
//       "file": await MultipartFile.fromFile(selectedfile.path,
//           filename: basename(selectedfile.path))
//     });
//     response = await dio.post(
//       uploadurl,
//       data: formData,
//       onSendProgress: (int sent, int total) {
//         String percentage = (sent / total * 100).toStringAsFixed(2);
//         setState(() {
//           progress = "$sent Bytes of $total Bytes $percentage % uploaded";
//         });
//       },
//     );
//
//     if (response.statusCode == 200) {
//       print(response.toString());
//     } else {
//       print("Error during connection to server");
//     }
//   }
//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              // child: progress == null
              //     ? Text("Progress: 0%")
              //     : Text(
              //         basename("progress: $progress"),
              //         textAlign: TextAlign.center,
              //         style: TextStyle(fontSize: 18),
              //       ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              // child: selectedfile == null
              //     ? Text("ChooseFile")
              //     : Text(basename(selectedfile.path)),
            ),
            Container(
              child: TextButton(
                child: Icon(Icons.folder_open),
                onPressed: () {
                  // selectFile();
                },
              ),
            ),
            // selectedfile == null
            //     ? Container()
            //     : Container(
            //         child: TextButton(
            //           child: Icon(Icons.folder_open),
            //           onPressed: () {
            //             uploadFile();
            //           },
            //         ),
            //       )
          ],
        ),
      ),
    );
  }
}
