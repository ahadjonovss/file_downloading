import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_downloading/bloc/file_download_cubit/file_download_cubit.dart';
import 'package:file_downloading/data/models/file_model.dart';
import 'package:file_downloading/service/others/show_toast.dart';
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
  double done = 0;
  bool isDownloaded=false;

  checkStatus() async {
    isDownloaded = await File("/storage/emulated/0/Download/${widget.file.fileName}").exists();
    setState(() {});
  }
  @override
  void initState() {
    checkStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FileDownloadCubit(),
      child: BlocConsumer<FileDownloadCubit,FileDownloadState>(
        listener: (context, state) {
          if(state is FileDownloadInSuccessState){
            checkStatus();
          }
        },
        builder: (context, state) => Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
          ),
          child: ListTile(
              title: Text(widget.file.fileName),
              subtitle: LinearProgressIndicator(
                value: isDownloaded?100:state is FileDownloadInProgressState?state.progress.toDouble():0,
                backgroundColor: Colors.grey,
              ),
              trailing: IconButton(icon: const Icon(Icons.open_in_full),onPressed: () async {
                bool isExist = await File("/storage/emulated/0/Download/${widget.file.fileName}").exists();
                if(isExist){
                  OpenFilex.open("/storage/emulated/0/Download/${widget.file.fileName}");
                }else{
                  showToast();
                }
              },),
              leading: IconButton(onPressed: () {
                context.read<FileDownloadCubit>().downloadFile(file: widget.file);
              },icon: isDownloaded?const Icon(Icons.done,color: Colors.green,):const Icon(Icons.download),)

          ),
        ) ,
      ),
    );
  }
}