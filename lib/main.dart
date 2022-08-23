import 'dart:io';
import 'package:commenting/controller/bottom_tab_controller.dart';
import 'package:commenting/controller/comment/comment_controller.dart';
import 'package:commenting/controller/comment/select_comment_controller.dart';
import 'package:commenting/controller/excecuter/excecuter_controller.dart';
import 'package:commenting/controller/name/lastname_controller.dart';
import 'package:commenting/controller/name/name_controller.dart';
import 'package:commenting/controller/send_comment_controller.dart';
import 'package:commenting/model/comment.dart';
import 'package:commenting/model/lastname.dart';
import 'package:commenting/model/name.dart';
import 'package:commenting/model/sended_comment.dart';
import 'package:commenting/screen/core/background.dart';
import 'package:commenting/screen/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:window_size/window_size.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Diginice');
    setWindowMinSize(const Size(1280, 800));
  }
  String dir = Directory.current.path;
  await Hive.initFlutter(dir + "/db");
  Hive.registerAdapter(CommentAdapter());
  Hive.registerAdapter(SendedCommentAdapter());
  Hive.registerAdapter(NameAdapter());
  Hive.registerAdapter(LastNameAdapter());
  await Hive.openBox<Map<dynamic, dynamic>>("names");
  await Hive.openBox<Map<dynamic, dynamic>>("lastNames");
  await Hive.openBox<Map<dynamic, dynamic>>("comments");
  await Hive.openBox<Map<dynamic, dynamic>>("sendedComments");
  Get.put(NameController());
  Get.put(LastNameController());
  Get.lazyPut(() => SendCommentController());
  Get.lazyPut(() => ExcecuteController());
  Get.lazyPut(() => CommentController());
  Get.lazyPut(() => SelectCommentController());
  Get.lazyPut(() => BottomTabController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFF1B1F30),
        statusBarColor: Color(0xFF1B1F30),
      ),
    );
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white, // background color
        cardColor: Color.fromARGB(
            255, 212, 212, 212), // card color and bottom app bar color
        buttonColor: const Color(0xFF4341FF), // button color
        hintColor: Color.fromARGB(255, 37, 37, 37), // header color
        secondaryHeaderColor: const Color(0xFFC0C3CF), // second text color
        hoverColor: Color.fromARGB(255, 32, 32, 32), // third text color
        highlightColor: const Color(0xFF4A81F0), // selected icon color
        shadowColor: const Color(0xFF6A7196), // unselected icon color
        errorColor: Colors.red, // error color
        indicatorColor: Colors.green, // error color
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Background(
          child: TabsScreen(),
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
