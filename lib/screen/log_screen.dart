import 'package:commenting/controller/send_comment_controller.dart';
import 'package:commenting/core/style.dart';
import 'package:commenting/widget/sendedcomment/sended_comment_listview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SendCommentController _sendCommentController =
        Get.find<SendCommentController>();
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(
              size.height * .025,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.delete_rounded,
                    color: Theme.of(context).hintColor,
                  ),
                  onPressed: () {
                    _sendCommentController.clear();
                  },
                ),
                Text(
                  'تاریخچه کامنت ها',
                  style: Style.getHeaderTextStyle(context),
                ),
              ],
            ),
          ),
          const Expanded(child: SendedCommentListView()),
        ],
      ),
    );
  }
}
