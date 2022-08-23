import 'package:commenting/controller/send_comment_controller.dart';
import 'package:commenting/widget/sendedcomment/sended_comment_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SendedCommentListView extends StatelessWidget {
  const SendedCommentListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final SendCommentController _sendCommentController =
        Get.find<SendCommentController>();

    return Obx(
      () => MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: _sendCommentController.dbComments.value.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                shrinkWrap: false,
                itemCount: _sendCommentController.dbComments.value.length,
                itemBuilder: (context, index) {
                  return SendedCommentRow(
                    sendedComment: _sendCommentController
                        .dbComments.value.reversed
                        .elementAt(index),
                  );
                },
              )
            : Lottie.asset('assets/anim/empty.json'),
      ),
    );
  }
}
