import 'package:commenting/controller/comment/comment_controller.dart';
import 'package:commenting/controller/comment/select_comment_controller.dart';
import 'package:commenting/model/comment.dart';
import 'package:commenting/widget/comment/comment_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CommentListView extends StatelessWidget {
  const CommentListView({Key? key, required this.onEdit}) : super(key: key);
  final Function onEdit;
  @override
  Widget build(BuildContext context) {
    final CommentController _commentController = Get.find<CommentController>();
    final SelectCommentController _selectCommentController =
        Get.find<SelectCommentController>();
    void select(Comment comment) =>
        _selectCommentController.selectComment(comment);

    void unselect(Comment comment) =>
        _selectCommentController.unselectComment(comment);

    void onDeleteComment(Comment comment) =>
        _commentController.removeComment(comment);

    return Center(
      child: Obx(
        () {
          List<Comment> comments =
              _commentController.dbComments.value.reversed.toList();
          return MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: comments.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    shrinkWrap: false,
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      return CommentRow(
                        comment: comments.elementAt(index),
                        onEdit: onEdit,
                        onDelete: onDeleteComment,
                        selected: select,
                        unselected: unselect,
                      );
                    },
                  )
                : Lottie.asset('assets/anim/empty.json'),
          );
        },
      ),
    );
  }
}
