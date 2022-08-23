import 'package:commenting/screen/comment_screen.dart';
import 'package:commenting/screen/excecute_screen.dart';
import 'package:commenting/screen/log_screen.dart';
import 'package:commenting/screen/names_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BottomTabController extends GetxController {
  RxInt index = RxInt(3);
  List<Widget> screens = [
    LogScreen(),
    CommentScreen(),
    NamesPage(),
    ExcecuteScreen(),
  ];
  void updateTab(int index) {
    this.index.value = index;
    this.index.refresh();
  }
}
