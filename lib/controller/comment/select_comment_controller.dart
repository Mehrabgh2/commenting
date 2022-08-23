import 'package:commenting/controller/comment/comment_controller.dart';
import 'package:commenting/model/comment.dart';
import 'package:get/get.dart';

class SelectCommentController extends GetxController {
  RxList<Comment> selectedComments = RxList([]);
  final CommentController _commentController = Get.find<CommentController>();

  RxBool isAll = RxBool(false);

  void selectAll() {
    _commentController.dbComments.forEach((element) {
      selectComment(element);
    });
  }

  void unselectAll() {
    _commentController.dbComments.forEach((element) {
      unselectComment(element);
    });
  }

  void selectComment(Comment comment) {
    selectedComments.value.add(comment);
    selectedComments.refresh();
    if (_commentController.dbComments.length == selectedComments.value.length) {
      isAll.value = true;
      isAll.refresh();
    }
  }

  void unselectComment(Comment comment) {
    selectedComments.value
        .removeWhere((element) => element.uuid == comment.uuid);
    selectedComments.refresh();
    isAll.value = false;
    isAll.refresh();
  }

  bool isCommentSelected(String uuid) {
    return selectedComments.value.any((element) => element.uuid == uuid);
  }
}
