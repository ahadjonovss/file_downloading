import 'package:file_downloading/data/models/file_model.dart';
import 'package:file_downloading/ui/widgets/file_item.dart';
import 'package:flutter/material.dart';

class FileDownloadPage extends StatelessWidget {
  const FileDownloadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.86),
      appBar: AppBar(
        title: Text("FileDownloading Page",style: TextStyle(color: Colors.black),),
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0.9),
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: files.length,
            itemBuilder: (context, index) => FileItemWidget(file: files[index]),
          )
        ],
      ),
    );
  }
}
