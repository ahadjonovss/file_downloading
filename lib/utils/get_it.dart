import 'package:dio/dio.dart';
import 'package:file_downloading/bloc/notification_cubit/notification_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
 getIt.registerLazySingleton(() => Dio());
 getIt.registerLazySingleton(() => NotificationCubit());
}