import 'dart:io';
import 'dart:isolate';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_downloading/bloc/notification_cubit/notification_cubit.dart';
import 'package:file_downloading/data/models/file_model.dart';
import 'package:file_downloading/utils/get_it.dart';
import 'package:meta/meta.dart';

part 'file_download_state.dart';

class FileDownloadCubit extends Cubit<FileDownloadState> {
  FileDownloadCubit() : super(FileDownloadInitial());

  var downloadedImagePath = '/storage/emulated/0/Download/';

  void downloadFile({required FileModel file})  async {
     await Isolate.run( await _fileDownloader(file: file));
    Isolate.exit();
  }

  _fileDownloader({required FileModel file}) async {
    Dio dio = getIt<Dio>();
    try {
      bool isExist = await File("$downloadedImagePath${file.fileName}").exists();
      if(!isExist){
        getIt<NotificationCubit>().sendNotification();
        await dio.download(
          file.fileUrl,
          "$downloadedImagePath${file.fileName}",
          onReceiveProgress: (rec, total) async{
            num progress=rec/total;
            emitProgress(progress);
            if(rec == total){
              getIt<NotificationCubit>().sendNotification(isFinished: true);
              emit(FileDownloadInSuccessState());
            }
          },
        );
      }
      else{
      }
    } catch (e) {}
    emit(FileDownloadInSuccessState());
  }


  emitProgress(num progress){
    emit(FileDownloadInProgressState(progress: progress));
  }
}
