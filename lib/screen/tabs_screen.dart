import 'package:commenting/controller/bottom_tab_controller.dart';
import 'package:commenting/widget/core/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BottomTabController _bottomTabController = Get.find<BottomTabController>();
    return Row(
      children: [
        CustomNavigationBar(),
        Expanded(
          child: Obx(
            () => _bottomTabController.screens
                .elementAt(_bottomTabController.index.value),
          ),
        ),
      ],
    );
  }
}
