import 'package:commenting/controller/bottom_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BottomTabController _tabController = Get.find<BottomTabController>();
    return Container(
      height: double.infinity,
      width: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                _tabController.updateTab(0);
              },
              icon: const Icon(
                Icons.event_note_rounded,
              ),
              color: _tabController.index.value == 0
                  ? Theme.of(context).buttonColor
                  : Theme.of(context).shadowColor,
            ),
            IconButton(
              onPressed: () {
                _tabController.updateTab(1);
              },
              icon: const Icon(
                Icons.category_rounded,
              ),
              color: _tabController.index.value == 1
                  ? Theme.of(context).buttonColor
                  : Theme.of(context).shadowColor,
            ),
            IconButton(
              onPressed: () {
                _tabController.updateTab(2);
              },
              icon: const Icon(
                Icons.people_alt_rounded,
              ),
              color: _tabController.index.value == 2
                  ? Theme.of(context).buttonColor
                  : Theme.of(context).shadowColor,
            ),
            IconButton(
              onPressed: () {
                _tabController.updateTab(3);
              },
              icon: const Icon(
                Icons.rocket_launch_rounded,
              ),
              color: _tabController.index.value == 3
                  ? Theme.of(context).buttonColor
                  : Theme.of(context).shadowColor,
            ),
          ],
        ),
      ),
    );
  }
}
