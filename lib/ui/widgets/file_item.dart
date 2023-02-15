import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_downloading/bloc/file_download_cubit/file_download_cubit.dart';
import 'package:file_downloading/data/models/file_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_filex/open_filex.dart';

class FileItemWidget extends StatefulWidget {
  FileModel file;

  FileItemWidget({required this.file,Key? key}) : super(key: key);

  @override
  State<FileItemWidget> createState() => _FileItemWidgetState();
}

class _FileItemWidgetState extends State<FileItemWidget> {
  var downloadedImagePath = '/storage/emulated/0/Download/';
  CancelToken cancelToken = CancelToken();
  double done = 0;
  bool isDownloaded=false;

  checkStatus() async {
    isDownloaded = await File("$downloadedImagePath${widget.file.fileName}").exists();
    setState(() {});
  }
  @override
  void initState() {
    checkStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FileDownloadCubit,FileDownloadState>(
      listener: (context, state) {
        if(state is FileDownloadInSuccessState){
          checkStatus();
        }
      },
      builder: (context, state) => ListTile(
          title: Text(widget.file.fileName),
          subtitle: LinearProgressIndicator(
            value: isDownloaded?100:state is FileDownloadInProgressState?state.progress.toDouble():0,
            backgroundColor: Colors.grey,
          ),
          trailing: IconButton(icon: const Icon(Icons.open_in_full),onPressed: () async {
            bool isExist = await File("$downloadedImagePath${widget.file.fileName}").exists();
            if(isExist){
              OpenFilex.open("$downloadedImagePath${widget.file.fileName}");
            }else{
              Fluttertoast.showToast(
                  msg: "Firstly, you must download",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          },),
          leading: IconButton(onPressed: () {
            context.read<FileDownloadCubit>().downloadFile(downloadedImagePath: downloadedImagePath, file: widget.file);
          },icon: isDownloaded?const Icon(Icons.done):const Icon(Icons.download),)

      ) ,
    );
  }
}