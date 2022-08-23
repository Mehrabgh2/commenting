import 'package:commenting/controller/comment/select_comment_controller.dart';
import 'package:commenting/core/style.dart';
import 'package:commenting/model/comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentRow extends StatelessWidget {
  const CommentRow({
    Key? key,
    required this.comment,
    required this.onEdit,
    required this.onDelete,
    required this.selected,
    required this.unselected,
  }) : super(key: key);

  final Comment comment;
  final Function onEdit;
  final Function onDelete;
  final Function selected;
  final Function unselected;

  @override
  Widget build(BuildContext context) {
    final SelectCommentController _selectCommentController =
        Get.find<SelectCommentController>();
    final _devSize = MediaQuery.of(context).size;
    return Container(
      height: _devSize.height * .1,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: EdgeInsets.only(
          right: _devSize.width * .02, left: _devSize.width * .02),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  unselected(comment);
                  onDelete(comment);
                },
                icon: Icon(
                  Icons.delete_rounded,
                  color: Theme.of(context).hintColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  onEdit(comment);
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).hintColor,
                ),
              ),
              Container(
                height: _devSize.height * .0375,
                child: FittedBox(
                  child: Obx(
                    () => CupertinoSwitch(
                      activeColor: Theme.of(context).buttonColor,
                      value: _selectCommentController
                          .isCommentSelected(comment.uuid),
                      onChanged: (newValue) {
                        if (newValue) {
                          selected(comment);
                        } else {
                          unselected(comment);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Text(
              comment.title,
              textAlign: TextAlign.right,
              style: Style.getHeaderTextStyle(context),
            ),
          ),
        ],
      ),
    );
  }
}
