import 'package:commenting/controller/comment/comment_controller.dart';
import 'package:commenting/controller/comment/select_comment_controller.dart';
import 'package:commenting/core/style.dart';
import 'package:commenting/model/comment.dart';
import 'package:commenting/screen/core/background_constant.dart';
import 'package:commenting/widget/comment/add_comment_bottom_sheet.dart';
import 'package:commenting/widget/comment/comment_listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SelectCommentController _selectCommentController =
        Get.find<SelectCommentController>();
    final CommentController _commentController = Get.find<CommentController>();
    final _devSize = MediaQuery.of(context).size;

    void onEdit(Comment comment) {
      showUpdateCommentBottomSheet(context, comment);
    }

    void selectAll() {
      _selectCommentController.selectAll();
    }

    void unselectAll() {
      _selectCommentController.unselectAll();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  showAddCommentBottomSheet(context);
                },
                icon: const Icon(Icons.add),
                color: Theme.of(context).hoverColor),
            Padding(
              padding: EdgeInsets.only(
                right: _devSize.width * .02,
                left: _devSize.width * .02,
                bottom: _devSize.width * .005,
                top: _devSize.width * .01,
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  children: [
                    Text(
                      'تعداد کل کامنت ها : ',
                      style: Style.getHeaderTextStyle(context),
                    ),
                    Obx(
                      () => Text(
                        _commentController.dbComments.value.length.toString() +
                            ' ',
                        style: Style.getPrimaryTextStyle(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            right: _devSize.width * .02,
            left: _devSize.width * .02,
            bottom: _devSize.width * .005,
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: [
                Text(
                  'تعداد کامنت های انتخاب شده : ',
                  style: Style.getHeaderTextStyle(context),
                ),
                Obx(
                  () => Text(
                    _selectCommentController.selectedComments.value.length
                            .toString() +
                        ' ',
                    style: Style.getPrimaryTextStyle(context),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: _devSize.width * .02,
            left: _devSize.width * .02,
            bottom: _devSize.width * .005,
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: [
                Text(
                  'انتخاب همه',
                  style: Style.getHeaderTextStyle(context),
                ),
                SizedBox(
                  width: _devSize.width * .025,
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: FittedBox(
                    child: Obx(
                      () => CupertinoSwitch(
                        activeColor: Theme.of(context).buttonColor,
                        value: _selectCommentController.isAll.value,
                        onChanged: (newValue) {
                          if (newValue) {
                            selectAll();
                          } else {
                            unselectAll();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: CommentListView(
            onEdit: onEdit,
          ),
        ),
      ],
    );
  }

  void showAddCommentBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      isDismissible: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return AddCommentBottomSheet();
      },
    );
  }

  void showUpdateCommentBottomSheet(BuildContext context, Comment comment) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      isDismissible: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return AddCommentBottomSheet(updateComment: comment);
      },
    );
  }
}
