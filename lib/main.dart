import 'package:file_downloading/bloc/file_download_cubit/file_download_cubit.dart';
import 'package:file_downloading/bloc/notification_cubit/notification_cubit.dart';
import 'package:file_downloading/service/notification_sevice/notification_service.dart';
import 'package:file_downloading/ui/file_downloac_page.dart';
import 'package:file_downloading/utils/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  LocalNotificationService.localNotificationService.init(navigatorKey);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => FileDownloadCubit(),),
      BlocProvider(create: (context) => getIt<NotificationCubit>(),),
    ],
      child:  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FileDownloadPage(),
    );
  }
}
