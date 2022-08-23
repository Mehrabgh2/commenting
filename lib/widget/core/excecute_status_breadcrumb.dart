import 'package:commenting/controller/excecuter/excecuter_controller.dart';
import 'package:commenting/widget/core/excecute_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExcecuteStatusBreadcrumb extends StatelessWidget {
  final ExcecuteController _excecuteController = Get.find();
  ExcecuteStatusBreadcrumb({required this.onRun});
  VoidCallback onRun;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          ExcecuteStatusWidget(
            title: 'دریافت محصولات از سایت',
            jobStatus: _excecuteController.jobsStatus.value.elementAt(0),
            indexIcon: Icons.looks_one_rounded,
            onRun: onRun,
            onStop: null,
          ),
          ExcecuteStatusWidget(
            title: 'اتصال کامنت ها به محصولات',
            jobStatus: _excecuteController.jobsStatus.value.elementAt(1),
            indexIcon: Icons.looks_two_rounded,
            onRun: onRun,
            onStop: null,
          ),
          ExcecuteStatusWidget(
            title: 'ارسال کامنت ها',
            jobStatus: _excecuteController.jobsStatus.value.elementAt(2),
            indexIcon: Icons.looks_3_rounded,
            onRun: () {},
            onStop: () {
              _excecuteController.stopSending();
            },
          ),
        ],
      ),
    );
  }
}
